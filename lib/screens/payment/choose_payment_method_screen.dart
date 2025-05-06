import 'package:flutter/material.dart';

class ChoosePaymentMethodScreen extends StatefulWidget {
  const ChoosePaymentMethodScreen({super.key});

  @override
  State<ChoosePaymentMethodScreen> createState() => _ChoosePaymentMethodScreenState();
}

class _ChoosePaymentMethodScreenState extends State<ChoosePaymentMethodScreen> {
  int selectedCardIndex = 0;

  final List<Map<String, String>> cards = [
    {
      'type': 'Mastercard',
      'number': '1579',
      'expiry': '12/22',
      'holder': 'Amanda Morgan',
    },
    {
      'type': 'Visa',
      'number': '4567',
      'expiry': '11/23',
      'holder': 'Amanda Morgan',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Payment Methods",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 130,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: cards.length + 1,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    if (index == cards.length) {
                      return _buildAddCardButton();
                    }
                    return _buildCard(index);
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Select", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(int index) {
    final card = cards[index];
    final isSelected = selectedCardIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCardIndex = index;
        });
      },
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade300, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(card['type']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                if (isSelected)
                  const Icon(Icons.check_circle, color: Colors.blue, size: 20),
              ],
            ),
            const SizedBox(height: 16),
            const Text("•••• •••• ••••", style: TextStyle(fontSize: 16)),
            Text(card['number']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(card['holder']!, style: const TextStyle(fontSize: 12)),
                Text(card['expiry']!, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddCardButton() {
    return GestureDetector(
      onTap: () {
        // В будущем — переход на экран добавления карты
        Navigator.pop(context); // Временно закрывает окно
      },
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
    );
  }
}
