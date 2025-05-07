import 'package:flutter/material.dart';
import 'flash_sale_screen.dart';

class FlashSaleLiveScreen extends StatelessWidget {
  const FlashSaleLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _buildHeader(context),
          _buildFilterBar(context),
          _buildArticleReimagined(),
          _buildDiscountSection(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF0056FF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 12),
          const Text("Flash Sale",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text("Choose Your Discount",
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.access_time, color: Colors.white),
              SizedBox(width: 8),
              Text("00 : 36 : 58",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    final filters = ["All", "10%", "20%", "30%", "40%", "50%"];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: filters.map((filter) {
          final isSelected = filter == "20%";
          return GestureDetector(
            onTap: () {
              if (filter == "20%") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FlashSaleScreen()),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF004CFF) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFF004CFF)),
              ),
              child: Text(filter,
                  style: TextStyle(
                      color: isSelected ? Colors.white : Color(0xFF004CFF))),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildArticleReimagined() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/article_reimagined.png',
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(12)),
              child: const Text("Live",
                  style: TextStyle(color: Colors.white, fontSize: 10)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountSection() {
    final products = [
      {
        'img': 'assets/images/flash_sale_1.png',
        'price': '\$16,00',
        'oldPrice': '\$20,00'
      },
      {
        'img': 'assets/images/flash_sale_2.png',
        'price': '\$16,00',
        'oldPrice': '\$20,00'
      },
      {
        'img': 'assets/images/flash_sale_3.png',
        'price': '\$16,00',
        'oldPrice': '\$20,00'
      },
      {
        'img': 'assets/images/flash_sale_4.png',
        'price': '\$16,00',
        'oldPrice': '\$20,00'
      },
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("20% Discount",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Icon(Icons.tune, size: 20, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 8),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7,
            physics: const NeverScrollableScrollPhysics(),
            children: products.map((product) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(product['img']!,
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Text("-20%",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text("Lorem ipsum dolor sit amet",
                      style: TextStyle(fontSize: 12)),
                  Row(
                    children: [
                      Text(product['price']!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      Text(
                        product['oldPrice']!,
                        style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      selectedItemColor: Color(0xFF004CFF),
      unselectedItemColor: Color(0xFF004CFF),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      ],
    );
  }
}
