import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sheber_market/screens/main/category_screen/category_screen.dart';
import 'package:sheber_market/screens/main/home_screen/home_screen.dart';
import 'package:sheber_market/screens/main/basket_screen/basket_screen.dart'; // Импортируйте BasketScreen

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
    CategoryScreen(),// Замените на соответствующие экраны
    BasketScreen(),    // Замените на соответствующие экраны
    CategoryScreen(),  // Замените на соответствующие экраны
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        child: GNav(
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          gap: 10,
          backgroundColor: Theme.of(context).colorScheme.primary,
          color: Theme.of(context).colorScheme.onPrimary,
          activeColor: Theme.of(context).colorScheme.onPrimary,
          tabBackgroundColor: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.all(10),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
              onPressed: () => setState(() => _currentIndex = 0),
            ),
            GButton(
              icon: Icons.category,
              text: 'Categories',
              onPressed: () => setState(() => _currentIndex = 1),
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favorites',
              onPressed: () => setState(() => _currentIndex = 2),
            ),
            GButton(
              icon: Icons.shopping_basket,
              text: 'Basket',
              onPressed: () => setState(() => _currentIndex = 3),
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
              onPressed: () => setState(() => _currentIndex = 4),
            ),
          ],
        ),
      ),
    );
  }
}
