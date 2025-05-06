import 'package:flutter/material.dart';
import '../shop/shop_clothing_screen.dart';

class CategoriesFilterScreen extends StatelessWidget {
  const CategoriesFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "All Categories",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 8),
            _buildGenderFilter(),
            const SizedBox(height: 16),
            _buildExpandedCategory(context),
            const SizedBox(height: 16),
            _buildCollapsedCategory('Shoes', 'assets/images/categories_shoes_2.png'),
            const SizedBox(height: 12),
            _buildCollapsedCategory('Bags', 'assets/images/categories_bags_1.png'),
            const SizedBox(height: 12),
            _buildCollapsedCategory('Lingerie', 'assets/images/categories_lingerie_2.png'),
            const SizedBox(height: 12),
            _buildCollapsedCategory('Accessories', 'assets/images/flash_sale_3.png'),
            const SizedBox(height: 12),
            _buildJustForYouCategory(),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildGenderButton("All", false),
        _buildGenderButton("Female", true),
        _buildGenderButton("Male", false),
      ],
    );
  }

  Widget _buildGenderButton(String title, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildExpandedCategory(BuildContext context) {
    final subcategories = [
      {'title': 'Dresses', 'img': 'assets/images/flash_sale_2.png'},
      {'title': 'Pants', 'img': 'assets/images/flash_sale_5.png'},
      {'title': 'Skirts', 'img': 'assets/images/categories_clothing_2.png'},
      {'title': 'Shorts', 'img': 'assets/images/categories_clothing_1.png'},
      {'title': 'Jackets', 'img': 'assets/images/categories_hoodies_2.png'},
      {'title': 'Hoodies', 'img': 'assets/images/categories_hoodies_1.png'},
      {'title': 'Shirts', 'img': 'assets/images/profile_most_popular_1.png'},
      {'title': 'Polo', 'img': 'assets/images/categories_clothing_3.png'},
      {'title': 'T-Shirts', 'img': 'assets/images/categories_clothing_4.png'},
      {'title': 'Tunics', 'img': 'assets/images/flash_sale_2.png'},
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/profile_most_popular_1.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                const Text("Clothing", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Spacer(),
                const Icon(Icons.keyboard_arrow_up),
              ],
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subcategories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ShopClothingScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.shade100),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(subcategories[index]['title']!),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollapsedCategory(String title, String imgPath) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(imgPath, width: 40, height: 40, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget _buildJustForYouCategory() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/profile_new_items_1.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          const Text("Just for You", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: Colors.blue, size: 18),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }
}
