import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<dynamic> newItems = [];
  List<dynamic> flashSaleItems = [];
  List<dynamic> mostPopularItems = [];
  List<dynamic> justForYouItems = [];
  List<dynamic> topProducts = [];
  Map<String, List<dynamic>> categories = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    final url = Uri.parse('https://fakestoreapi.com/products');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final allProducts = json.decode(response.body);
      final clothingProducts = allProducts
          .where((item) =>
              item['category'] == "men's clothing" ||
              item['category'] == "women's clothing")
          .toList();

      setState(() {
        newItems = clothingProducts.take(3).toList();
        flashSaleItems = clothingProducts.skip(3).take(2).toList();
        mostPopularItems = clothingProducts.skip(5).take(2).toList();
        justForYouItems = clothingProducts.skip(7).take(2).toList();
        topProducts = clothingProducts.skip(9).take(4).toList();
        categories = {
          'Clothing': clothingProducts
              .where((item) => item['category'] == "men's clothing")
              .toList(),
          'Jewelery': allProducts
              .where((item) => item['category'] == "jewelery")
              .toList(),
        };
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildHeader(context)),
                  SliverToBoxAdapter(child: _buildBigSaleBanner()),
                  SliverToBoxAdapter(child: _buildCategoriesSection()),
                  SliverToBoxAdapter(child: _buildTopProductsSection()),
                  SliverToBoxAdapter(child: _buildNewItemsSection(context)),
                  SliverToBoxAdapter(child: _buildFlashSaleSection(context)),
                  SliverToBoxAdapter(child: _buildMostPopularSection(context)),
                  SliverToBoxAdapter(child: _buildJustForYouSection(context)),
                ],
              ),
      ),
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
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/search');
            },
            child: Container(
              width: 180,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: const [
                  SizedBox(width: 12),
                  Icon(Icons.camera_alt_outlined, size: 18, color: Colors.grey),
                  SizedBox(width: 8),
                  Text("Search", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBigSaleBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset('assets/images/big_sale.png',
            height: 120, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader("Categories"),
          const SizedBox(height: 8),
          ...categories.entries.map((entry) {
            final categoryItems = entry.value.take(4).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.key,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: categoryItems.map((item) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(item['image'],
                          width: 70, height: 70, fit: BoxFit.cover),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTopProductsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Top Products",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: topProducts.map((item) {
              return ClipOval(
                child: Image.network(item['image'],
                    width: 60, height: 60, fit: BoxFit.cover),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNewItemsSection(BuildContext context) {
    return _buildProductRowSection("New Items", newItems, context);
  }

  Widget _buildFlashSaleSection(BuildContext context) {
    return _buildProductWrapSection("Flash Sale", flashSaleItems, context);
  }

  Widget _buildMostPopularSection(BuildContext context) {
    return _buildProductHorizontalScroll(
        "Most Popular", mostPopularItems, context);
  }

  Widget _buildJustForYouSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text("Just For You",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 4),
              Icon(Icons.star, color: Colors.blue, size: 16),
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
            children: justForYouItems.map((item) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/productFull',
                    arguments: item),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(item['image'],
                          width: double.infinity,
                          height: 130,
                          fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 4),
                    Text(item['title'],
                        style: const TextStyle(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    Text("\$${item['price']}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRowSection(
      String title, List items, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(title),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((item) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/productFull',
                    arguments: item),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(item['image'],
                          width: 100, height: 100, fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 4),
                    Text("\$${item['price']}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductWrapSection(
      String title, List items, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/flashSaleLive'),
            child: _sectionHeader(title),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/productFull',
                    arguments: item),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(item['image'],
                          width: 99, height: 103, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
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
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductHorizontalScroll(
      String title, List items, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(title),
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
                  onTap: () => Navigator.pushNamed(context, '/productFull',
                      arguments: item),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(item['image'],
                            width: 100, height: 100, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: const [
                          Text("1780"),
                          SizedBox(width: 4),
                          Icon(Icons.favorite, color: Colors.blue, size: 14),
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

  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Container(
          padding: const EdgeInsets.all(4),
          decoration:
              const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          child: const Icon(Icons.arrow_forward, color: Colors.white, size: 14),
        ),
      ],
    );
  }
}
