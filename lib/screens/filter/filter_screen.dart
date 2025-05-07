import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _priceRange = const RangeValues(10, 150);
  String selectedSize = 'M';
  String selectedSort = 'Popular';
  Color selectedColor = Colors.white;

  final List<Map<String, String>> categories = [
    {'label': 'Dresses', 'img': 'assets/images/categories_clothing_1.png'},
    {'label': 'Pants', 'img': 'assets/images/categories_clothing_2.png'},
    {'label': 'Skirts', 'img': 'assets/images/categories_clothing_3.png'},
    {'label': 'Shorts', 'img': 'assets/images/flash_sale_5.png'},
    {'label': 'Jackets', 'img': 'assets/images/flash_sale_4.png'},
    {'label': 'Hoodies', 'img': 'assets/images/categories_hoodies_1.png'},
    {'label': 'Shirts', 'img': 'assets/images/profile_most_popular_1.png'},
    {'label': 'Polo', 'img': 'assets/images/flash_sale_3.png'},
    {'label': 'T-Shirts', 'img': 'assets/images/flash_sale_2.png'},
    {'label': 'Tunics', 'img': 'assets/images/flash_sale_1.png'},
  ];

  final List<Color> colors = [
    Colors.white,
    Colors.black,
    Colors.red,
    Color(0xFF004CFF),
    Colors.green,
    Colors.yellow,
    Colors.purple,
  ];

  final List<String> sizes = ["XS", "S", "M", "L", "XL", "2XL"];

  final List<String> sortOptions = [
    "Popular",
    "Newest",
    "Price High to Low",
    "Price Low to High",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text("Filter",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCategorySelection(),
          const SizedBox(height: 24),
          _buildSizeSection(),
          const SizedBox(height: 24),
          _buildColorSection(),
          const SizedBox(height: 24),
          _buildPriceSection(),
          const SizedBox(height: 24),
          _buildSortSection(),
          const SizedBox(height: 24),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildCategorySelection() {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(categories[index]['img']!),
              ),
              const Positioned(
                top: 4,
                right: 4,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Color(0xFF004CFF),
                  child: Icon(Icons.check, size: 12, color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSizeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Size",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildToggleButton("Clothes", true),
            const SizedBox(width: 8),
            _buildToggleButton("Shoes", false),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: sizes.map((size) {
            final isSelected = size == selectedSize;
            return GestureDetector(
              onTap: () => setState(() => selectedSize = size),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF004CFF) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFF004CFF)),
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Color(0xFF004CFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildToggleButton(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF004CFF) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildColorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Color",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 12),
        Row(
          children: colors.map((color) {
            final isSelected = color == selectedColor;
            return GestureDetector(
              onTap: () => setState(() => selectedColor = color),
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: isSelected
                    ? const Center(
                        child: Icon(Icons.check,
                            size: 16, color: Color(0xFF004CFF)))
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Price",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("\$${_priceRange.start.toInt()}"),
            Text("\$${_priceRange.end.toInt()}"),
          ],
        ),
        const SizedBox(height: 8),
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 200,
          divisions: 20,
          onChanged: (values) => setState(() => _priceRange = values),
          activeColor: Color(0xFF004CFF),
        ),
      ],
    );
  }

  Widget _buildSortSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Sort",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: sortOptions.map((option) {
            final isSelected = option == selectedSort;
            return GestureDetector(
              onTap: () => setState(() => selectedSort = option),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF004CFF) : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedSize = 'M';
                selectedColor = Colors.white;
                selectedSort = 'Popular';
                _priceRange = const RangeValues(10, 150);
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text("Clear",
                    style: TextStyle(
                        color: Color(0xFF004CFF), fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Color(0xFF004CFF),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text("Apply",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
