import 'package:flutter/material.dart';
import './cart_data.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = getCartItems();
    if (cartItems.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            "Your cart is empty",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Text("Cart",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Color(0xFF004CFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "${cartItems.length}",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...cartItems.map((item) => _buildCartItem(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(item['image'],
                height: 80, width: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'], style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 4),
                const Text("Pink, Size M",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                Text("\$${item['price']}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
