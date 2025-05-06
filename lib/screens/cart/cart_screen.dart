import 'package:flutter/material.dart';
import '../../main.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (isCartEmpty) {
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

    final cartItems = [
      'assets/images/flash_sale_6.png',
      'assets/images/flash_sale_4.png',
    ];
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
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("2", style: TextStyle(color: Colors.white, fontSize: 12)),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildShippingAddress(context),
          const SizedBox(height: 16),
          ...cartItems.map(_buildCartItem).toList(),
          const SizedBox(height: 16),
          const Text("From Your Wishlist", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          ...wishlistItems.map(_buildWishlistItem).toList(),
          const SizedBox(height: 16),
          _buildTotalAndCheckout(context),
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
              child: Icon(Icons.arrow_forward, size: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(String imagePath) {
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
                Text("Pink, Size M", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 4),
                Text("\$17,00", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Column(
            children: [
              const Icon(Icons.delete_outline, color: Colors.red),
              const SizedBox(height: 8),
              Row(
                children: [
                  _qtyBtn(Icons.remove),
                  const SizedBox(width: 4),
                  const Text("1", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 4),
                  _qtyBtn(Icons.add),
                ],
              )
            ],
          )
        ],
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

  static Widget _qtyBtn(IconData icon) {
    return Container(
      height: 28,
      width: 28,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 16),
    );
  }

  Widget _buildTotalAndCheckout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Total \$34.00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
