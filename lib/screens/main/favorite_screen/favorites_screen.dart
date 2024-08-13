import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/providers/favorite_provider.dart';
import 'package:sheber_market/providers/product_provider.dart';
import 'package:sheber_market/widgets/enhanced_app_bar.dart';
import 'widgets/favorite_item.dart'; // Импортируйте виджет FavoriteItem

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<Product>> _favoritesFuture;
  
Future<List<Product>> _loadFavorites() async {
  final favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
  final productProvider = Provider.of<ProductProvider>(context, listen: false);
  final auth = FirebaseAuth.instance;
  final currentUser = auth.currentUser;
  final currentUserId = currentUser?.uid ?? "";

  // Получаем избранные элементы для текущего пользователя
  final favoriteItems = await favoriteProvider.fetchFavoriteItems(currentUserId);
  final productIds = favoriteItems.map((item) => item.productId).toList(); // Измените на item.productId если используете number

  // Получаем продукты по ID
  return await productProvider.fetchProductsByIds(productIds);
}


  @override
  void initState() {
    super.initState();
    _favoritesFuture = _loadFavorites();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: EnhancedAppBar(
      title: 'Избранное',
      onActionPressed: () async {
        final favorites = await _loadFavorites(); // Получаем избранные товары
        if (favorites.isNotEmpty) {
          showClearFavoritesDialog();
        }
      },
      showAction: true,
    ),
    body: FutureBuilder<List<Product>>(
      future: _favoritesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Избранное пусто'));
        } else {
          final favorites = snapshot.data!;
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.02,
              horizontal: MediaQuery.of(context).size.width * 0.02,
            ),
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return FavoriteItem(product: product); // Используем новый виджет
              },
            ),
          );
        }
      },
    ),
  );
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
              final auth = FirebaseAuth.instance;
              final currentUser = auth.currentUser;
              final currentUserId = currentUser?.uid ?? "";

              // Получаем избранные товары
              final favorites = await favoriteProvider.fetchFavoriteItems(currentUserId);
              
              // Удаляем каждый товар из избранного
              for (var favoriteItem in favorites) {
                final productId = favoriteItem.productId;
                print('Удаление продукта с ID: $productId'); // Логируем удаление
                await favoriteProvider.deleteFavoriteItem(currentUserId, productId);
              }
              
              // Обновляем данные после удаления
              if (mounted) {
                Navigator.of(context).pop();
                setState(() {
                  _favoritesFuture = _loadFavorites(); // Обновляем список избранного
                });
              }
            },
            child: const Text('Очистить'),
          ),
        ],
      );
    },
  );
}

}
