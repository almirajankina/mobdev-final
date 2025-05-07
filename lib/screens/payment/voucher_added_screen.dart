import 'package:flutter/material.dart';

class VoucherAddedScreen extends StatelessWidget {
  const VoucherAddedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payment',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildShippingAddress(context),
          const SizedBox(height: 16),
          _buildContactInfo(),
          const SizedBox(height: 16),
          _buildItemsSection(),
          const SizedBox(height: 16),
          _buildShippingOptions(),
          const SizedBox(height: 16),
          _buildPaymentMethod(context),
          const SizedBox(height: 16),
          _buildTotalAndPayButton(context),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF004CFF),
        unselectedItemColor: Color(0xFF004CFF),
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

  Widget _buildShippingAddress(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
                '26, Duong So 2, Thao Dien Ward, An Phu, District 2,\nHo Chi Minh City',
                style: TextStyle(fontSize: 12)),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/editShipping'),
            icon: const Icon(Icons.edit, color: Color(0xFF004CFF), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text('+84987654321\namandamorgan@example.com',
                style: TextStyle(fontSize: 12)),
          ),
          IconButton(
            onPressed: () {}, // можно позже добавить переход
            icon: const Icon(Icons.edit, color: Color(0xFF004CFF), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Items 2',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF004CFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Text('5% Discount',
                      style: TextStyle(color: Color(0xFF004CFF), fontSize: 10)),
                  SizedBox(width: 4),
                  Icon(Icons.close, size: 12, color: Color(0xFF004CFF)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildItemTile('assets/images/profile_most_popular_1.png',
            'Lorem ipsum dolor sit amet', '\$17,00'),
        const SizedBox(height: 12),
        _buildItemTile('assets/images/profile_most_popular_2.png',
            'Lorem ipsum dolor sit amet', '\$17,00'),
      ],
    );
  }

  Widget _buildItemTile(String imgPath, String title, String price) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(imgPath, width: 60, height: 60, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(title, style: const TextStyle(fontSize: 14)),
        ),
        Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildShippingOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Shipping Options',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: [
            Radio(value: true, groupValue: true, onChanged: (value) {}),
            const Text('Standard 5-7 days', style: TextStyle(fontSize: 12)),
            const Spacer(),
            const Text('FREE',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            Radio(value: false, groupValue: true, onChanged: (value) {}),
            const Text('Express 1-2 days', style: TextStyle(fontSize: 12)),
            const Spacer(),
            const Text('\$12.00',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethod(BuildContext context) {
    return Row(
      children: [
        const Text('Payment Method',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        IconButton(
          onPressed: () => Navigator.pushNamed(context, '/choosePayment'),
          icon: const Icon(Icons.edit, color: Color(0xFF004CFF), size: 20),
        ),
      ],
    );
  }

  Widget _buildTotalAndPayButton(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
            Text('\$34.00', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Pay', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
