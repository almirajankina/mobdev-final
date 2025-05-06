import 'package:flutter/material.dart';

class CurrencySelectionScreen extends StatefulWidget {
  final String selectedCurrency;

  const CurrencySelectionScreen({super.key, required this.selectedCurrency});

  @override
  State<CurrencySelectionScreen> createState() =>
      _CurrencySelectionScreenState();
}

class _CurrencySelectionScreenState extends State<CurrencySelectionScreen> {
  String? selected;

  final List<String> currencies = ['USD', 'EUR', 'KZT', 'RUB', 'JPY'];

  @override
  void initState() {
    super.initState();
    selected = widget.selectedCurrency;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Currency')),
      body: ListView(
        children:
            currencies.map((currency) {
              return RadioListTile<String>(
                title: Text(currency),
                value: currency,
                groupValue: selected,
                onChanged: (value) {
                  setState(() => selected = value);
                  Navigator.pop(context, value);
                },
              );
            }).toList(),
      ),
    );
  }
}
