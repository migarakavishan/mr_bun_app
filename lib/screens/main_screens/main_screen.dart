import 'package:bun_app/screens/cart/cart_scrren.dart';
import 'package:bun_app/screens/favorite/favorite_screen.dart';
import 'package:bun_app/screens/home_screen/home_screen.dart';
import 'package:bun_app/screens/profile/profile_screen/profile_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const CartScrren(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle, // Animation style
        items: const [
          TabItem(
            icon: Icons.home_outlined,
            title: 'Home',
          ),
          TabItem(
            icon: Icons.favorite_outline,
            title: 'Favorite',
          ),
          TabItem(
            icon: Icons.add_shopping_cart_outlined,
            title: 'Cart',
          ),
          TabItem(
            icon: Icons.person_2_outlined,
            title: 'Profile',
          ),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        activeColor: const Color(0xff352A4C), // Color of the active icon
        color: Colors.black, // Color of the inactive icons
      ),
    );
  }
}
