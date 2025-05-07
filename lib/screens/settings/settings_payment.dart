import 'package:flutter/material.dart';

class SettingsAddCardPage extends StatelessWidget {
  const SettingsAddCardPage({Key? key}) : super(key: key);

  void _showCardForm(BuildContext context, {bool isEdit = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: CardForm(isEdit: isEdit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Example transaction data
    final List<Map<String, String>> transactions = [
      {
        'title': 'Order #92287157',
        'date': 'April 19 2020 12:31',
        'amount': '-\$14.00'
      },
      {
        'title': 'Order #92287157',
        'date': 'April 19 2020 12:31',
        'amount': '-\$37.00'
      },
      {
        'title': 'Order #92287157',
        'date': 'April 19 2020 12:31',
        'amount': '-\$21.00'
      },
      {
        'title': 'Order #92287157',
        'date': 'April 19 2020 12:31',
        'amount': '-\$75.00'
      },
      {
        'title': 'Order #92287157',
        'date': 'April 19 2020 12:31',
        'amount': '-\$214.00'
      },
      {
        'title': 'Order #92287157',
        'date': 'April 19 2020 12:31',
        'amount': '-\$53.00'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Payment Methods',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/0/04/Mastercard-logo.png',
                                width: 40,
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.settings,
                                    color: Colors.grey),
                                onPressed: () {
                                  _showCardForm(context, isEdit: true);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            '**** **** **** 1579',
                            style: TextStyle(
                              letterSpacing: 2,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'AMANDA MORGAN',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '12/22',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => _showCardForm(context, isEdit: false),
                    child: Container(
                      height: 130,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Transactions List
              Expanded(
                child: ListView.separated(
                  itemCount: transactions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final tx = transactions[index];
                    final isNegative = tx['amount']!.startsWith('-');
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: isNegative
                                  ? const Color.fromARGB(255, 205, 218, 255)
                                  : Colors.blue.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isNegative ? Icons.shopping_bag : Icons.lock,
                              color: isNegative
                                  ? const Color.fromARGB(255, 54, 98, 244)
                                  : Colors.blue,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tx['date']!,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tx['title']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            tx['amount']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isNegative
                                  ? const Color.fromARGB(255, 18, 17, 17)
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardForm extends StatelessWidget {
  final bool isEdit;

  const CardForm({super.key, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    final cardHolderController =
        TextEditingController(text: isEdit ? 'Romina' : '');
    final cardNumberController =
        TextEditingController(text: isEdit ? '•••• •••• •••• 1579' : '');
    final validController =
        TextEditingController(text: isEdit ? '12 / 22' : '');
    final cvvController = TextEditingController(text: isEdit ? '209' : '');

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                isEdit ? 'Edit Card' : 'Add Card',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (isEdit)
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Здесь можно добавить удаление карты
                  },
                )
            ],
          ),
          const SizedBox(height: 10),
          _buildTextField('Card Holder', 'Required', cardHolderController),
          const SizedBox(height: 10),
          _buildTextField('Card Number', 'Required', cardNumberController),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: _buildTextField('Valid', 'Required', validController)),
              const SizedBox(width: 10),
              Expanded(
                  child: _buildTextField('CVV', 'Required', cvvController)),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Сохраняем изменения
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Save Changes', style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
