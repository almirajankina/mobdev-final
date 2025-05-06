import 'package:flutter/material.dart';

class CountrySelectionScreen extends StatelessWidget {
  final List<String> countries = [
    'Australia',
    'Brazil',
    'Canada',
    'China',
    'Germany',
    'India',
    'Japan',
    'Kazakhstan',
    'Russia',
    'United States',
  ];

  @override
  Widget build(BuildContext context) {
    countries.sort(); // Сортировка по алфавиту

    return Scaffold(
      appBar: AppBar(title: const Text('Select Country')),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(countries[index]),
            onTap: () {
              Navigator.pop(
                context,
                countries[index],
              ); // Вернуть выбранную страну
            },
          );
        },
      ),
    );
  }
}
