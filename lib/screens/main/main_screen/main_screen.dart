import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sheber_market/screens/main/home_screen/home_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
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
              onPressed: () => Navigator.of(context).pushNamed('/home'),
            ),
            GButton(
              icon: Icons.category,
              text: 'Categories',
              onPressed: () => Navigator.of(context).pushNamed('/categories'),
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favorites',
              onPressed: () => Navigator.of(context).pushNamed('/favorites'),
            ),
            GButton(
              icon: Icons.shopping_basket,
              text: 'Basket',
              onPressed: () => Navigator.of(context).pushNamed('/basket'),
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
              onPressed: () => Navigator.of(context).pushNamed('/profile'),
            ),
          ],
        ),
      ),
    );
  }
}
