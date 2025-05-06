import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payment', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildShippingAddress(),
          const SizedBox(height: 16),
          _buildContactInformation(),
          const SizedBox(height: 16),
          _buildItemsSection(context),
          const SizedBox(height: 16),
          _buildShippingOptions(),
          const SizedBox(height: 16),
          _buildPaymentMethod(context),
          const SizedBox(height: 24),
          _buildTotalAndPayButton(context),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }

  Widget _buildShippingAddress() {
    return _buildInfoCard(
      title: "Shipping Address",
      content: "26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city",
    );
  }

  Widget _buildContactInformation() {
    return _buildInfoCard(
      title: "Contact Information",
      content: "+84932000000\namandamorgan@example.com",
    );
  }

  Widget _buildInfoCard({required String title, required String content}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(content, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 14,
            backgroundColor: Colors.blue,
            child: Icon(Icons.edit, size: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Items", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
              child: const Text("2", style: TextStyle(fontSize: 12)),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/addVoucher'),
              child: const Text("Add Voucher", style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildItemRow('assets/images/flash_sale_1.png', "\$17,00"),
        const SizedBox(height: 12),
        _buildItemRow('assets/images/flash_sale_2.png', "\$17,00"),
      ],
    );
  }

  Widget _buildItemRow(String imagePath, String price) {
    return Row(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(imagePath, height: 60, width: 60, fit: BoxFit.cover),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: const Text('1', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            )
          ],
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text("Lorem ipsum dolor sit amet consectetur.", style: TextStyle(fontSize: 12)),
        ),
        const SizedBox(width: 8),
        Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildShippingOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Shipping Options", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildShippingOption("Standard", "5-7 days", "FREE", selected: true),
        const SizedBox(height: 12),
        _buildShippingOption("Express", "1-2 days", "\$12.00", selected: false),
        const SizedBox(height: 8),
        const Text("Delivered on or before Thursday, 23 April 2020", style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildShippingOption(String title, String time, String price, {required bool selected}) {
    return Row(
      children: [
        Icon(
          selected ? Icons.radio_button_checked : Icons.radio_button_off,
          color: selected ? Colors.blue : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        Text(time, style: TextStyle(color: selected ? Colors.blue : Colors.grey)),
        const Spacer(),
        Text(price, style: TextStyle(color: selected ? Colors.blue : Colors.black)),
      ],
    );
  }

  Widget _buildPaymentMethod(BuildContext context) {
    return Row(
      children: [
        const Text("Payment Method", style: TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/choosePayment'),
          child: const CircleAvatar(
            radius: 14,
            backgroundColor: Colors.blue,
            child: Icon(Icons.edit, size: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalAndPayButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Total \$34.00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/paymentInProgress'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Text("Pay", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
