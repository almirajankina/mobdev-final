import 'package:flutter/material.dart';

class WishlistEmptyScreen extends StatelessWidget {
  const WishlistEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recentlyViewed = [
      'assets/images/top_products_1.png',
      'assets/images/top_products_2.png',
      'assets/images/top_products_3.png',
      'assets/images/top_products_4.png',
      'assets/images/top_products_5.png',
    ];

    final mostPopular = [
      {
        'img': 'assets/images/profile_most_popular_1.png',
        'label': '1780',
        'tag': 'New'
      },
      {
        'img': 'assets/images/profile_most_popular_2.png',
        'label': '1780',
        'tag': 'Sale'
      },
      {
        'img': 'assets/images/profile_most_popular_3.png',
        'label': '1780',
        'tag': 'Hot'
      },
      {
        'img': 'assets/images/profile_most_popular_4.png',
        'label': '1780',
        'tag': ''
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
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
                  backgroundColor: Colors.blue,
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
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                Image.asset('assets/images/wishlist_empty.png',
                    width: 120, height: 120),
                const SizedBox(height: 24),
                const Text('Your Wishlist is Empty',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text("Looks like you haven't added any items yet.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/shop'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Go to Shop',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Most Popular',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              GestureDetector(
                onTap: () {},
                child: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 12,
                  child:
                      Icon(Icons.arrow_forward, size: 14, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: mostPopular.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = mostPopular[index];
                return Container(
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(item['img']!,
                            width: double.infinity,
                            height: 90,
                            fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(item['label']!,
                              style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 4),
                          const Icon(Icons.favorite,
                              color: Colors.blue, size: 14),
                          if (item['tag']!.isNotEmpty) ...[
                            const SizedBox(width: 4),
                            Text(item['tag']!,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ]
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue,
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
