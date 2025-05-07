import 'package:flutter/material.dart';

class ShopClothingScreen extends StatelessWidget {
  const ShopClothingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            _buildHeader(context),
            _buildCategoryChips(),
            _buildAllItemsSection(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Shop",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Container(
            width: 180,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    // логика сброса фильтра
                    Navigator.pop(context);
                  },
                  child: const Text("Clothing ×",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/search'),
                  child: const Icon(Icons.camera_alt_outlined,
                      size: 18, color: Colors.grey),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    final categories = [
      {'img': 'assets/images/flash_sale_2.png', 'label': 'Dresses'},
      {'img': 'assets/images/flash_sale_5.png', 'label': 'Pants'},
      {'img': 'assets/images/categories_clothing_2.png', 'label': 'Skirts'},
      {'img': 'assets/images/flash_sale_3.png', 'label': 'Shorts'},
      {'img': 'assets/images/profile_most_popular_2.png', 'label': 'Jackets'},
      {'img': 'assets/images/categories_hoodies_1.png', 'label': 'Hoodies'},
      {'img': 'assets/images/profile_most_popular_1.png', 'label': 'Shirts'},
      {'img': 'assets/images/profile_most_popular_3.png', 'label': 'Polo'},
      {'img': 'assets/images/profile_most_popular_4.png', 'label': 'T-shirts'},
      {'img': 'assets/images/flash_sale_4.png', 'label': 'Tunics'},
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8),
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Можно сделать фильтрацию или переход
              },
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(categories[index]['img']!,
                        width: 60, height: 60, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 4),
                  Text(categories[index]['label']!,
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAllItemsSection(BuildContext context) {
    final products = [
      {'img': 'assets/images/profile_most_popular_1.png'},
      {'img': 'assets/images/profile_new_items_2.png'},
      {'img': 'assets/images/profile_most_popular_2.png'},
      {'img': 'assets/images/profile_new_items_3.png'},
      {'img': 'assets/images/flash_sale_1.png'},
      {'img': 'assets/images/profile_most_popular_1.png'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("All Items",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/filter'),
                child: const Icon(Icons.tune, size: 20, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/product'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(products[index]['img']!,
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 4),
                    const Text("Lorem ipsum dolor sit amet",
                        style: TextStyle(fontSize: 12)),
                    const SizedBox(height: 2),
                    const Text("\$17,00",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            },
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
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      ],
    );
  }
}
