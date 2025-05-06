import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  final String selectedLanguage;

  const LanguageSelectionScreen({super.key, required this.selectedLanguage});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? selected;

  final List<String> languages = ['English', 'Russian', 'Kazakh'];

  @override
  void initState() {
    super.initState();
    selected = widget.selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Language')),
      body: ListView(
        children:
            languages.map((lang) {
              return RadioListTile<String>(
                title: Text(lang),
                value: lang,
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
