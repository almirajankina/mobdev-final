import 'package:flutter/material.dart';

class SizeSelectionScreen extends StatefulWidget {
  final String selectedSize;

  const SizeSelectionScreen({super.key, required this.selectedSize});

  @override
  State<SizeSelectionScreen> createState() => _SizeSelectionScreenState();
}

class _SizeSelectionScreenState extends State<SizeSelectionScreen> {
  String? selected;

  final List<String> sizes = ['US', 'EU', 'UK'];

  @override
  void initState() {
    super.initState();
    selected = widget.selectedSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Size')),
      body: ListView(
        children:
            sizes.map((size) {
              return RadioListTile<String>(
                title: Text(size),
                value: size,
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
