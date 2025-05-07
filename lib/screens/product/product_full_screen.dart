import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart/cart_data.dart';
import '/services/favorites_service.dart';

class ProductFullScreen extends StatelessWidget {
  const ProductFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! Map) {
      return const Scaffold(
        body: Center(child: Text("Product data is missing")),
      );
    }

    final Map<String, dynamic> product = (args as Map).cast<String, dynamic>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text("Product Details",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              _buildImageHeader(context, product),
              _buildProductInfo(product),
              _buildVariations(context),
              _buildSpecifications(context),
              _buildDeliveryOptions(),
              _buildRatingReviews(context),
              _buildMostPopular(context),
              _buildYouMightLike(),
              const SizedBox(height: 100),
            ],
          ),
          _buildBottomButtons(context, product),
        ],
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context, Map<String, dynamic> product) {
    final favoritesService = Provider.of<FavoritesService>(context);

    return Stack(
      children: [
        Image.network(
          product['image'],
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 40,
          right: 16,
          child: IconButton(
            icon: Icon(
              favoritesService.isFavorite(product)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () {
              favoritesService.toggleFavorite(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(favoritesService.isFavorite(product)
                      ? "Added to favorites"
                      : "Removed from favorites"),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo(Map product) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("\$${product['price']}",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(product['title'] ?? '',
              style: const TextStyle(color: Colors.black87, fontSize: 16)),
          const SizedBox(height: 8),
          Text(product['description'] ?? '',
              style: const TextStyle(color: Colors.black54, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildVariations(BuildContext context) {
    final variations = [
      'assets/images/categories_shoes_2.png',
      'assets/images/categories_shoes_1.png',
      'assets/images/profile_most_popular_1.png',
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Variations",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Chip(label: Text("Pink")),
              const SizedBox(width: 8),
              const Chip(label: Text("M")),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/productVariations'),
                child: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.blue,
                  child:
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: variations.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    variations[index],
                    width: 80,
                    height: 80,
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

  Widget _buildSpecifications(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Specifications",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 12),
          _buildSpecRow("Material", "Cotton 95%   Nylon 5%"),
          _buildSpecRow("Origin", "EU"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Size guide", style: TextStyle(fontSize: 16)),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/categoriesFilter'),
                child: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.blue,
                  child:
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 16),
          Expanded(
              child: Text(subtitle,
                  style: const TextStyle(color: Colors.black54))),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Delivery",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          _buildDeliveryRow("Standard", "5-7 days", "\$3.00"),
          const SizedBox(height: 8),
          _buildDeliveryRow("Express", "1-2 days", "\$12.00"),
        ],
      ),
    );
  }

  Widget _buildDeliveryRow(String type, String time, String price) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(type, style: const TextStyle(fontSize: 16)),
          Text(time, style: const TextStyle(color: Colors.blue)),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRatingReviews(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Rating & Reviews",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star_border, color: Colors.amber),
              SizedBox(width: 8),
              Text("4/5",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/profile_most_popular_1.png'),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Veronika",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(
                      "Lorem ipsum dolor sit amet, consectetur sadipscing elitr.",
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/reviews'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("View All Reviews"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMostPopular(BuildContext context) {
    final items = [
      'assets/images/profile_most_popular_1.png',
      'assets/images/profile_most_popular_2.png',
      'assets/images/profile_most_popular_3.png',
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Most Popular",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/productSale'),
                child: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.blue,
                  child:
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(items[index],
                      width: 100, height: 100, fit: BoxFit.cover),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYouMightLike() {
    final products = [
      'assets/images/flash_sale_1.png',
      'assets/images/flash_sale_2.png',
      'assets/images/flash_sale_3.png',
      'assets/images/flash_sale_4.png',
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("You Might Like",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(products[index], fit: BoxFit.cover),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(
      BuildContext context, Map<String, dynamic> product) {
    final favoritesService = Provider.of<FavoritesService>(context);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                favoritesService.isFavorite(product)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                favoritesService.toggleFavorite(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(favoritesService.isFavorite(product)
                        ? "Added to favorites"
                        : "Removed from favorites"),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to cart")),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text("Add to cart"),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  addToCart(product);
                  Navigator.pushNamed(context, '/cart');
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Buy now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
