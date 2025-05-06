import 'package:flutter/material.dart';
import '../../main.dart';

class CartEmptyShownFromWishlistScreen extends StatelessWidget {
  const CartEmptyShownFromWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!isCartEmpty) {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/cart');
      });
    }

    final wishlistItems = [
      'assets/images/flash_sale_1.png',
      'assets/images/flash_sale_3.png',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Text("Cart", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("0", style: TextStyle(color: Colors.black, fontSize: 12)),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildShippingAddress(context),
          const SizedBox(height: 24),
          _buildEmptyCartIcon(),
          const SizedBox(height: 24),
          const Text("From Your Wishlist", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          ...wishlistItems.map(_buildWishlistItem),
          const SizedBox(height: 16),
          _buildTotalAndCheckout(context),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }

  Widget _buildShippingAddress(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/images/profile_most_popular_1.png')),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city",
              style: TextStyle(fontSize: 12),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/editShipping'),
            child: const CircleAvatar(
              radius: 14,
              backgroundColor: Colors.blue,
              child: Icon(Icons.edit, size: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCartIcon() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(Icons.shopping_bag_outlined, size: 60, color: Colors.blue),
      ),
    );
  }

  Widget _buildWishlistItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagePath, height: 80, width: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Lorem ipsum dolor sit amet", style: TextStyle(fontSize: 12)),
                SizedBox(height: 4),
                Text("\$17,00", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Pink   M", style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.move_to_inbox, color: Colors.blue)
        ],
      ),
    );
  }

  Widget _buildTotalAndCheckout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Total \$0.00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/payment'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text("Checkout", style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }
}
