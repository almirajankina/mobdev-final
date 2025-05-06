import 'package:flutter/material.dart';

class FlashSaleScreen extends StatelessWidget {
  const FlashSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _buildHeader(context),
          _buildFilterBar(),
          _buildDiscountSection(context),
          _buildBigSaleBanner(),
          _buildNewItemsSection(),
          _buildMostPopularSection(),
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
          const Text("Flash Sale", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text("Choose Your Discount", style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.access_time, color: Colors.white),
              SizedBox(width: 8),
              Text("00  :  36  :  58", style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    final filters = ["All", "10%", "20%", "30%", "40%", "50%"];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: filters.map((filter) {
          final isSelected = filter == "20%";
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blue),
            ),
            child: Text(filter, style: TextStyle(color: isSelected ? Colors.white : Colors.blue)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDiscountSection(BuildContext context) {
    final products = [
      {'img': 'assets/images/flash_sale_5.png', 'price': '\$16,00', 'oldPrice': '\$20,00'},
      {'img': 'assets/images/flash_sale_6.png', 'price': '\$16,00', 'oldPrice': '\$20,00'},
      {'img': 'assets/images/flash_sale_1.png', 'price': '\$16,00', 'oldPrice': '\$20,00'},
      {'img': 'assets/images/flash_sale_2.png', 'price': '\$16,00', 'oldPrice': '\$20,00'},
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("20% Discount", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Icon(Icons.tune, size: 20, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 6),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7,
            physics: const NeverScrollableScrollPhysics(),
            children: products.map((product) {
              return GestureDetector(
                onTap: () {
                Navigator.pushNamed(context, '/productFull');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(product['img']!, fit: BoxFit.cover, height: 150, width: double.infinity),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                            child: const Text("-20%", style: TextStyle(color: Colors.white, fontSize: 10)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text("Lorem ipsum dolor sit amet", style: TextStyle(fontSize: 12)),
                    Row(
                      children: [
                        Text(product['price']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 4),
                        Text(
                          product['oldPrice']!,
                          style: const TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBigSaleBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset('assets/images/big_sale.png', height: 120, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildNewItemsSection() {
    final images = [
      {'img': 'assets/images/categories_shoes_2.png', 'price': '\$16,00', 'oldPrice': '\$20,00'},
      {'img': 'assets/images/categories_shoes_1.png', 'price': '\$16,00', 'oldPrice': '\$20,00'},
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("New Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Icon(Icons.arrow_forward, color: Colors.blue, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: images.map((item) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(item['img']!, width: 130, height: 130, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(item['price']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      Text(item['oldPrice']!, style: const TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough, fontSize: 12)),
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

  Widget _buildMostPopularSection() {
    final items = [
      {'img': 'assets/images/profile_most_popular_1.png', 'label': 'New'},
      {'img': 'assets/images/profile_most_popular_2.png', 'label': 'Sale'},
      {'img': 'assets/images/profile_most_popular_3.png', 'label': 'Hot'},
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Most Popular", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Icon(Icons.arrow_forward, color: Colors.blue, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((item) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(item['img']!, width: 100, height: 100, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text("1780"),
                      const SizedBox(width: 4),
                      const Icon(Icons.favorite, color: Colors.blue, size: 14),
                      if (item['label']!.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Text(item['label']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]
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
    );
  }
}
