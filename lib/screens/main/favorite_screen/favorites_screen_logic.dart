import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/providers/favorite_provider.dart';

class FavoritesLogic extends ChangeNotifier {
  final BuildContext context;
  FavoritesLogic(this.context);

  bool isLoading = false;
  List<Product> _favorites = []; // Временное хранилище для избранных товаров

  // Загрузка данных (вместо использования сервиса)
  Future<void> loadFavorites() async {
    isLoading = true;
    notifyListeners();
    
    try {
      var favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
      await favoriteProvider.fetchFavoriteItems();
      _favorites = favoriteProvider.favoriteItems.map((item) => Product(
        id: item.productId,
        barcode: '',
        name: '', // Должны быть заполнены данные о продукте
        sellingPrice: 0,
        category: '',
        unit: '',
        quantity: 0,
      )).toList();
    } catch (e) {
      print("Ошибка при загрузке избранных товаров: $e");
    }

    isLoading = false;
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
              
              onPressed: () async {
                var favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
                for (var favorite in _favorites) {
                  await favoriteProvider.deleteFavoriteItem(favorite.id);
                }
                _favorites.clear(); // Очищаем список
                if (context.mounted) {
                  Navigator.of(context).pop();
                  notifyListeners(); // Обновляем состояние
                }
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
                await favoriteProvider.deleteFavoriteItem(product.id);
                _favorites.remove(product); // Удаляем товар из списка
                
                if (context.mounted) {
                  Navigator.of(context).pop();
                  notifyListeners(); // Обновляем состояние
                }
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
