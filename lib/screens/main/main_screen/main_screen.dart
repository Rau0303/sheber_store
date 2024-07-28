import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sheber_market/screens/main/category_screen/category_screen.dart';
import 'package:sheber_market/screens/main/favorite_screen/favorites_screen.dart';
import 'package:sheber_market/screens/main/home_screen/home_screen.dart';
import 'package:sheber_market/screens/main/basket_screen/basket_screen.dart';
import 'package:sheber_market/screens/main/profile_screen/profile_screen/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    CategoryScreen(),
    FavoritesScreen(),
    BasketScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      body: _pages[_currentIndex],
      backgroundColor: theme.scaffoldBackgroundColor,
      bottomNavigationBar: Container(
        color: theme.bottomAppBarTheme.color,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02,
          vertical: screenHeight * 0.02,
        ),
        child: GNav(
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          gap: 10,
          backgroundColor: theme.bottomAppBarTheme.color!,
          color: theme.colorScheme.onSurface, // Цвет иконок неактивных
          activeColor: Colors.white, // Цвет иконок активных
          tabBackgroundColor: Colors.deepOrange, // Цвет фона активной вкладки
          padding: const EdgeInsets.all(10),
          tabs: [
            GButton(
              icon: CupertinoIcons.home,
              text: 'Главная',
              onPressed: () => setState(() => _currentIndex = 0),
            ),
            GButton(
              icon: CupertinoIcons.square_grid_2x2,
              text: 'Категории',
              onPressed: () => setState(() => _currentIndex = 1),
            ),
            GButton(
              icon: CupertinoIcons.heart,
              text: 'Избранное',
              onPressed: () => setState(() => _currentIndex = 2),
            ),
            GButton(
              icon: CupertinoIcons.cart,
              text: 'Корзина',
              onPressed: () => setState(() => _currentIndex = 3),
            ),
            GButton(
              icon: CupertinoIcons.person,
              text: 'Профиль',
              onPressed: () => setState(() => _currentIndex = 4),
            ),
          ],
        ),
      ),
    );
  }
}
