
import 'package:flutter/material.dart';
import '../product/product_full_screen.dart';

class SearchResultsScreen extends StatelessWidget {
  final String query;
  const SearchResultsScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    final products = _getFilteredProducts(query);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _buildHeader(context),
          const SizedBox(height: 8),
          _buildProductGrid(context, products),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          const Text("Shop", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(query, style: const TextStyle(color: Colors.black54))),
                  IconButton(
                    icon: const Icon(Icons.close, size: 16, color: Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.camera_alt_outlined, color: Colors.blue),
          const SizedBox(width: 12),
          const Icon(Icons.tune, color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, List<Map<String, String>> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.7,
        physics: const NeverScrollableScrollPhysics(),
        children: products.map((product) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductFullScreen()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(product['img']!, height: 140, width: double.infinity, fit: BoxFit.cover),
                ),
                const SizedBox(height: 4),
                const Text("Lorem ipsum dolor sit amet", style: TextStyle(fontSize: 12)),
                const SizedBox(height: 2),
                Text(product['price']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  List<Map<String, String>> _getFilteredProducts(String query) {
    final allProducts = [
      {'img': 'assets/images/flash_sale_3.png', 'price': '\$17,00', 'category': 'Socks'},
      {'img': 'assets/images/flash_sale_1.png', 'price': '\$17,00', 'category': 'Clothing'},
      {'img': 'assets/images/profile_most_popular_2.png', 'price': '\$17,00', 'category': 'Clothing'},
      {'img': 'assets/images/flash_sale_2.png', 'price': '\$17,00', 'category': 'Socks'},
      {'img': 'assets/images/flash_sale_4.png', 'price': '\$17,00', 'category': 'Skirt'},
      {'img': 'assets/images/profile_most_popular_1.png', 'price': '\$17,00', 'category': 'Accessories'},
    ];

    return allProducts.where((product) =>
      product['category']!.toLowerCase().contains(query.toLowerCase())).toList();
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
