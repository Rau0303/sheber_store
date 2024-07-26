import 'package:flutter/material.dart';
import 'package:sheber_market/models/product.dart';

class FavoritesLogic extends ChangeNotifier {
  final BuildContext context;

  FavoritesLogic(this.context);

  bool isLoading = false;
  List<Product> _favorites = []; // Временное хранилище для избранных товаров

  // Загрузка данных (вместо использования сервиса)
  Future<void> loadFavorites() async {
    // Здесь можно загрузить данные из локального хранилища
    // Например, из базы данных SQLite или другого источника
    // Временно заполняем список тестовыми данными
    _favorites = [
      // Пример тестовых данных
      Product(
        id: 1,
        barcode: '123456',
        name: 'Товар 1',
        sellingPrice: 100.0,
        category: 'Категория 1',
        unit: 'шт',
        quantity: 10,
      ),
      Product(
        id: 2,
        barcode: '789012',
        name: 'Товар 2',
        sellingPrice: 200.0,
        category: 'Категория 2',
        unit: 'шт',
        quantity: 5,
      ),
    ];
    notifyListeners();
  }

  Future<void> showClearFavoritesDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Очистить Избранное?'),
          content: const Text('Вы уверены, что хотите очистить избранное?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.deepOrange),
              ),
              onPressed: () {
                _favorites.clear(); // Очищаем список
                Navigator.of(context).pop();
                notifyListeners(); // Обновляем состояние
              },
              child: const Text('Очистить'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showDeleteFavoritesDialog(Product product) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Удаление'),
          content: Text('Вы уверены, что хотите удалить ${product.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.deepOrange),
              ),
              onPressed: () {
                _favorites.remove(product); // Удаляем товар из списка
                Navigator.of(context).pop();
                notifyListeners(); // Обновляем состояние
              },
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }

  List<Product> getFavorites() {
    return _favorites; // Возвращаем локально хранимые данные
  }
}
