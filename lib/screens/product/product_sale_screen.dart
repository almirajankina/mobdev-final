import 'package:flutter/material.dart';

class ProductSaleScreen extends StatelessWidget {
  const ProductSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _buildImageSection(context),
          _buildDetailsSection(context),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Image.asset(
            'assets/images/flash_sale_2.png',
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const CircleAvatar(
              backgroundColor: Colors.black45,
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 60,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("\$24,00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(width: 8),
              const Text(
                "\$30,00",
                style: TextStyle(fontSize: 14, color: Colors.grey, decoration: TextDecoration.lineThrough),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                child: const Text("-20%", style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
              const Spacer(),
              Row(
                children: const [
                  Icon(Icons.access_time, size: 16, color: Colors.blue),
                  SizedBox(width: 4),
                  Text("00 : 36 : 58", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam arcu mauris, scelerisque eu mauris id, pretium pulvinar sapien.",
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text("Variations", style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/productVariations'),
                child: const Icon(Icons.arrow_forward, color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              _VariationItem(image: 'assets/images/categories_clothing_1.png'),
              SizedBox(width: 8),
              _VariationItem(image: 'assets/images/categories_clothing_2.png'),
              SizedBox(width: 8),
              _VariationItem(image: 'assets/images/categories_clothing_3.png'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.blue),
            onPressed: () {},
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Add to cart"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Buy now"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VariationItem extends StatelessWidget {
  final String image;

  const _VariationItem({required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(image, width: 80, height: 80, fit: BoxFit.cover),
    );
  }
}
