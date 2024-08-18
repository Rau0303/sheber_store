const functions = require('firebase-functions');
const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json'); // Укажите путь к вашему файлу ключа

// Инициализация Firebase Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// Функция для отправки уведомлений
const sendNotification = (token, title, body) => {
  const message = {
    notification: {
      title: title,
      body: body,
    },
    token: token,
  };

  return admin.messaging().send(message)
    .then(response => {
      console.log('Successfully sent message:', response);
      return response;
    })
    .catch(error => {
      console.error('Error sending message:', error);
      throw new Error('Error sending message');
    });
};

// Обработчик для событий создания и изменения заказов
exports.onOrderUpdate = functions.firestore
  .document('orders/{orderId}')
  .onUpdate((change, context) => {
    const after = change.after.data(); // данные после обновления
    const before = change.before.data(); // данные до обновления

    // Проверяем, что данные существуют и что статус заказа изменился
    if (!after || !before || after.status === before.status) {
      return null;
    }

    const userId = after.userId;
    const status = after.status;

    // Получаем токен пользователя для отправки уведомления
    return admin.firestore().collection('users').doc(userId).get()
      .then(userDoc => {
        if (userDoc.exists) {
          const userData = userDoc.data();
          const token = userData.fcm_token; // Предполагаем, что у пользователя есть FCM токен

          // Отправляем уведомление в зависимости от статуса заказа
          switch (status) {
            case 'Новый':
              return sendNotification(token, 'Ваш заказ создан', 'Спасибо за ваш заказ!');
            case 'Принят':
              return sendNotification(token, 'Ваш заказ принят', 'Ваш заказ был принят администратором.');
            case 'Отправлен':
              return sendNotification(token, 'Ваш заказ отправлен', 'Ваш заказ был отправлен.');
            case 'Доставлен':
              return sendNotification(token, 'Ваш заказ доставлен', 'Ваш заказ был доставлен.');
            default:
              console.log('Unknown status:', status);
              return null;
          }
        } else {
          console.log('User not found');
          return null;
        }
      })
      .catch(error => {
        console.error('Error fetching user data:', error);
        return null;
      });
  });
