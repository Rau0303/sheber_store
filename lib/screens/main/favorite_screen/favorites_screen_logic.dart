import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/providers/favorite_provider.dart';

class FavoritesLogic extends ChangeNotifier {
  final BuildContext context;
  FavoritesLogic(this.context);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;
  late final List<Product> _favorites = []; // Временное хранилище для избранных товаров

  // Загрузка данных





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
              onPressed: () async {
                var favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);

                // Получаем текущего пользователя
                final User? currentUser = _auth.currentUser;
                final currentUserId = currentUser?.uid ?? "";

                for (var product in _favorites) {
                  await favoriteProvider.deleteFavoriteItem(currentUserId, product.id);
                }
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
              onPressed: () async {
                var favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);

                // Получаем текущего пользователя
                final User? currentUser = _auth.currentUser;
                final currentUserId = currentUser?.uid ?? "";

                await favoriteProvider.deleteFavoriteItem(currentUserId, product.id);
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
