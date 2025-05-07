import 'package:flutter/material.dart';
import 'shop/shop_screen.dart';
import 'wishlist/wishlist_screen.dart';
import 'wishlist/wishlist_empty_screen.dart';
import 'cart/cart_screen.dart';
import 'cart/cart_empty_shown_from_wishlist_screen.dart';
import 'profile/profile_screen.dart';
import 'chat/chat_support.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  bool isWishlistEmpty = false;
  bool isCartEmpty = false;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      const ShopScreen(),
      isWishlistEmpty ? const WishlistEmptyScreen() : const WishlistScreen(),
      const Center(child: Text("Orders screen (coming soon)")),
      isCartEmpty
          ? const CartEmptyShownFromWishlistScreen()
          : const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Color(0xFF004CFF),
        unselectedItemColor: Color(0xFF004CFF),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatSupport()),
          );
        },
        backgroundColor: Color(0xFF004CFF),
        child: const Icon(Icons.chat),
      ),
    );
  }
}
