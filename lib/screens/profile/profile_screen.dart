import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? firstName;
  String? imageUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = doc.data();

      setState(() {
        firstName = data?['email']?.split('@')[0];
        imageUrl = data?['imageUrl'];
        isLoading = false;
      });
    } catch (e) {
      print('Error loading profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final stories = [
      'assets/images/profile_recently_viewed_1.png',
      'assets/images/profile_recently_viewed_2.png',
      'assets/images/profile_recently_viewed_3.png',
      'assets/images/profile_recently_viewed_4.png',
    ];

    final recentlyViewed = stories;

    final categories = {
      'Clothing': [
        'assets/images/categories_clothing_1.png',
        'assets/images/categories_clothing_2.png',
        'assets/images/categories_clothing_3.png',
        'assets/images/categories_clothing_4.png',
      ],
      'Shoes': [
        'assets/images/categories_shoes_1.png',
        'assets/images/categories_shoes_2.png',
        'assets/images/categories_shoes_3.png',
        'assets/images/categories_shoes_4.png',
      ],
      'Bags': [
        'assets/images/categories_bags_1.png',
        'assets/images/categories_bags_2.png',
        'assets/images/categories_bags_3.png',
        'assets/images/categories_bags_4.png',
      ],
      'Lingerie': [
        'assets/images/categories_lingerie_1.png',
        'assets/images/categories_lingerie_2.png',
        'assets/images/categories_lingerie_3.png',
        'assets/images/categories_lingerie_4.png',
      ],
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            _buildHeader(context),
            _buildSubHeader(),
            _buildRecentlyViewed(context, recentlyViewed),
            _buildMyOrders(context),
            _buildStories(stories),
            _buildNewItems(context),
            _buildMostPopular(context),
            _buildCategories(categories),
            _buildFlashSale(context),
            _buildTopProducts(),
            _buildJustForYou(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    imageUrl != null ? NetworkImage(imageUrl!) : null,
                backgroundColor: Colors.grey[300],
                child: imageUrl == null
                    ? const Icon(Icons.person, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 12),
              Text(
                'Hello, ${firstName ?? 'User'}!',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/myActivity');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF004CFF)),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                'My Activity',
                style: TextStyle(
                  color: Color(0xFF004CFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(
            child: Text(
              "This is your profile.",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Icon(Icons.settings, color: Color(0xFF004CFF)),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewed(BuildContext context, List<String> avatars) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            'Recently viewed',
            onTap: () => Navigator.pushNamed(context, '/recentlyViewed'),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: avatars.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return ClipOval(
                  child: Image.asset(
                    avatars[index],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyOrders(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const _StatusButton(title: 'To Pay'),
          const SizedBox(width: 8),
          _StatusButton(
            title: 'To Receive',
            isActive: true,
            onTap: () {
              Navigator.pushNamed(context, '/toReceive');
            },
          ),
          const SizedBox(width: 8),
          const _StatusButton(title: 'To Review'),
        ],
      ),
    );
  }

  Widget _buildStories(List<String> stories) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: stories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  stories[index],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNewItems(BuildContext context) {
    final items = [
      {'img': 'assets/images/profile_new_items_1.png', 'price': '\$17,00'},
      {'img': 'assets/images/profile_new_items_2.png', 'price': '\$32,00'},
      {'img': 'assets/images/profile_new_items_3.png', 'price': '\$21,00'},
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('New Items'),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((item) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/product'),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        item['img']!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['price']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
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

  Widget _buildMostPopular(BuildContext context) {
    final items = [
      {'img': 'assets/images/profile_most_popular_1.png', 'label': 'New'},
      {'img': 'assets/images/profile_most_popular_2.png', 'label': 'Sale'},
      {'img': 'assets/images/profile_most_popular_3.png', 'label': 'Hot'},
      {'img': 'assets/images/profile_most_popular_4.png', 'label': ''},
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Most Popular'),
          const SizedBox(height: 8),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/product'),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item['img']!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text("1780"),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.favorite,
                            color: Color(0xFF004CFF),
                            size: 14,
                          ),
                          if (item['label']!.isNotEmpty) ...[
                            const SizedBox(width: 4),
                            Text(
                              item['label']!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(Map<String, List<String>> categories) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Categories'),
          const SizedBox(height: 8),
          ...categories.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: entry.value.map((img) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        img,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFlashSale(BuildContext context) {
    final items = [
      'assets/images/flash_sale_1.png',
      'assets/images/flash_sale_2.png',
      'assets/images/flash_sale_3.png',
      'assets/images/flash_sale_4.png',
      'assets/images/flash_sale_5.png',
      'assets/images/flash_sale_6.png',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/flashSaleLive'),
            child: _sectionHeader('Flash Sale'),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((img) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/product'),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        img,
                        width: 99,
                        height: 103,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "-20%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
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

  Widget _buildTopProducts() {
    final images = [
      'assets/images/top_products_1.png',
      'assets/images/top_products_2.png',
      'assets/images/top_products_3.png',
      'assets/images/top_products_4.png',
      'assets/images/top_products_5.png',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Products',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: images.map((img) {
              return ClipOval(
                child: Image.asset(
                  img,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildJustForYou(BuildContext context) {
    final items = [
      'assets/images/just_for_you_1.png',
      'assets/images/just_for_you_2.png',
      'assets/images/just_for_you_3.png',
      'assets/images/just_for_you_4.png',
      'assets/images/just_for_you_5.png',
      'assets/images/just_for_you_6.png',
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Just For You',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(width: 4),
              Icon(Icons.star, color: Color(0xFF004CFF), size: 16),
            ],
          ),
          const SizedBox(height: 8),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 155 / 171,
            children: items.map((img) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/product'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        img,
                        width: double.infinity,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Lorem ipsum dolor sit amet",
                      style: TextStyle(fontSize: 12),
                    ),
                    const Text(
                      "\$17,00",
                      style: TextStyle(fontWeight: FontWeight.bold),
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

  Widget _sectionHeader(String title, {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color(0xFF004CFF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback? onTap;

  const _StatusButton({
    Key? key,
    required this.title,
    this.isActive = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // <<< вот это обязательно!
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF004CFF) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(color: isActive ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
