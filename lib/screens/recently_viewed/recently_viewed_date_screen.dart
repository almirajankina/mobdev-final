import 'package:flutter/material.dart';

class RecentlyViewedDateScreen extends StatelessWidget {
  const RecentlyViewedDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios_new, size: 20),
              ),
              const SizedBox(width: 12),
              const Text("Recently viewed",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.arrow_back_ios_new, size: 16),
                    SizedBox(width: 8),
                    Text("April",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(30, (index) {
                    final day = index + 1;
                    return Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:
                            day == 18 ? Color(0xFF004CFF) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        day.toString().padLeft(2, '0'),
                        style: TextStyle(
                          color: day == 18 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Icon(Icons.keyboard_arrow_up, color: Colors.grey),
          const SizedBox(height: 20),
          _buildProductGrid(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildProductGrid() {
    final products = [
      'assets/images/flash_sale_4.png',
      'assets/images/profile_most_popular_1.png',
      'assets/images/flash_sale_5.png',
      'assets/images/flash_sale_6.png',
      'assets/images/profile_most_popular_2.png',
      'assets/images/flash_sale_2.png',
    ];

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.7,
      children: products.map((img) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(img,
                  fit: BoxFit.cover, width: double.infinity, height: 150),
            ),
            const SizedBox(height: 4),
            const Text("Lorem ipsum dolor sit amet",
                style: TextStyle(fontSize: 12)),
            const Text("\$17,00",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        );
      }).toList(),
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
