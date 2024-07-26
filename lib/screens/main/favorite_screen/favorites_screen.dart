import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/screens/main/favorite_screen/favorites_screen_logic.dart';
import 'package:sheber_market/widgets/enhanced_app_bar.dart';
import 'widgets/favorite_item.dart'; // Импортируйте виджет FavoriteItem

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  late FavoritesLogic logic;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logic = Provider.of<FavoritesLogic>(context); 
  }

  @override
  Widget build(BuildContext context) {
    final favorites = logic.getFavorites();

    return Scaffold(
      appBar: EnhancedAppBar(
        title: 'Избранное',
        onActionPressed: () {
          if (favorites.isNotEmpty) {
            logic.showClearFavoritesDialog();
          }
        },
        showAction: favorites.isNotEmpty,
      ),
      body: logic.isLoading
          ? const Center(child: CircularProgressIndicator())
          : favorites.isEmpty
              ? const Center(child: Text('Избранное пусто'))
              : Padding(
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
                ),
    );
  }
}
