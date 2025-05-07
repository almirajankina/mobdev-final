import 'package:flutter/material.dart';
import '../product/product_full_screen.dart';
import 'recently_viewed_date_screen.dart';

class RecentlyViewedDateChosenScreen extends StatelessWidget {
  const RecentlyViewedDateChosenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      'assets/images/profile_new_items_1.png',
      'assets/images/profile_new_items_2.png',
      'assets/images/profile_new_items_3.png',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => const RecentlyViewedDateScreen()),
            );
          },
        ),
        title: const Text("Recently Viewed",
            style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 155 / 171,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductFullScreen()),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(items[index],
                        height: 130, width: double.infinity, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 4),
                  const Text("Lorem ipsum dolor sit amet",
                      style: TextStyle(fontSize: 12)),
                  const Text("\$17,00",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
