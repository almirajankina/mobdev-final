import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/favorites_service.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesService = Provider.of<FavoritesService>(context);
    final wishlistItems = favoritesService.favorites;

    final recentlyViewed = [
      'assets/images/top_products_1.png',
      'assets/images/top_products_2.png',
      'assets/images/top_products_3.png',
      'assets/images/top_products_4.png',
    ];

    print("Wishlist length: ${wishlistItems.length}");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0056FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Wishlist', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recently viewed',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/recentlyViewed'),
                child: const CircleAvatar(
                  backgroundColor: Color(0xFF004CFF),
                  radius: 12,
                  child:
                      Icon(Icons.arrow_forward, size: 14, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recentlyViewed.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return ClipOval(
                  child: Image.asset(recentlyViewed[index],
                      width: 60, height: 60, fit: BoxFit.cover),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ...wishlistItems.map((item) => GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, '/product', arguments: item),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: item['image']!.startsWith('http')
                            ? Image.network(item['image']!,
                                width: 80, height: 80, fit: BoxFit.cover)
                            : Image.asset(item['image']!,
                                width: 80, height: 80, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['title'] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            const Row(
                              children: [
                                Text("Pink", style: TextStyle(fontSize: 12)),
                                SizedBox(width: 8),
                                Text("M", style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                                item['price'] != null
                                    ? '\$${item['price'].toString()}'
                                    : '',
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () =>
                                favoritesService.toggleFavorite(item),
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.red),
                          ),
                          const SizedBox(height: 4),
                          IconButton(
                            onPressed:
                                () {}, // You can add logic to add to cart
                            icon: const Icon(Icons.shopping_bag_outlined,
                                color: Color(0xFF004CFF)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
