import 'package:flutter/material.dart';
import '../product/product_full_screen.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String query = args['query'] ?? '';
    final List<Map<String, String>> products =
        List<Map<String, String>>.from(args['products'] ?? []);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _buildHeader(context, query),
          const SizedBox(height: 8),
          _buildProductGrid(context, products),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader(BuildContext context, String query) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          const Text("Shop",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
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
                  Expanded(
                      child: Text(query,
                          style: const TextStyle(color: Colors.black54))),
                  IconButton(
                    icon: const Icon(Icons.close,
                        size: 16, color: Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.camera_alt_outlined, color: Color(0xFF004CFF)),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/filter'),
            child: const Icon(Icons.tune, color: Color(0xFF004CFF)),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(
      BuildContext context, List<Map<String, String>> products) {
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
              Navigator.pushNamed(
                context,
                '/productFull',
                arguments: {
                  'image': product['img'],
                  'price': product['price']!.replaceAll('\$', ''),
                  'title': product['title'],
                  'description': 'Lorem ipsum dolor sit amet',
                },
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(product['img']!,
                      height: 140, width: double.infinity, fit: BoxFit.cover),
                ),
                const SizedBox(height: 4),
                Text(product['title']!, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 2),
                Text(product['price']!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          );
        }).toList(),
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
