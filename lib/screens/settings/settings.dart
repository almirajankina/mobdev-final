import 'package:flutter/material.dart';
import 'package:profile_app/screens/settings/settings_country.dart';
import 'package:profile_app/screens/settings/settings_currency.dart';
import 'package:profile_app/screens/settings/settings_sizes.dart';
import 'package:profile_app/screens/settings/settings_language.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? selectedCountry;
  String? selectedCurrency;
  String? selectedSize;
  String? selectedLanguage;

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget buildSettingRow(String label, {VoidCallback? onTap}) {
    return Column(
      children: [
        ListTile(
          title: Text(label),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
        const Divider(thickness: 1, color: Colors.grey),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          // Personal Section
          buildSectionTitle('Personal'),
          buildSettingRow('Profile'),
          buildSettingRow('Shipping Address'),
          buildSettingRow('Payment Methods'),

          // Shop Section
          buildSectionTitle('Shop'),
          buildSettingRow(
            'Country${selectedCountry != null ? ': $selectedCountry' : ''}',
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CountrySelectionScreen(),
                ),
              );
              if (result != null) {
                setState(() {
                  selectedCountry = result;
                });
              }
            },
          ),
          buildSettingRow(
            'Currency${selectedCurrency != null ? ': $selectedCurrency' : ''}',
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => CurrencySelectionScreen(
                        selectedCurrency: selectedCurrency ?? '',
                      ),
                ),
              );
              if (result != null) {
                setState(() {
                  selectedCurrency = result;
                });
              }
            },
          ),
          buildSettingRow(
            'Sizes${selectedSize != null ? ': $selectedSize' : ''}',
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          SizeSelectionScreen(selectedSize: selectedSize ?? ''),
                ),
              );
              if (result != null) {
                setState(() {
                  selectedSize = result;
                });
              }
            },
          ),
          buildSettingRow('Terms and Conditions'),

          // Account Section
          buildSectionTitle('Account'),
          buildSettingRow(
            'Language${selectedLanguage != null ? ': $selectedLanguage' : ''}',
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => LanguageSelectionScreen(
                        selectedLanguage: selectedLanguage ?? '',
                      ),
                ),
              );
              if (result != null) {
                setState(() {
                  selectedLanguage = result;
                });
              }
            },
          ),
          buildSettingRow('About Slada'),

          const SizedBox(height: 20),

          Center(
            child: TextButton(
              onPressed: () {
                // handle delete account
              },
              child: const Text(
                'Delete My Account',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          Center(
            child: Column(
              children: const [
                Text(
                  'Slada',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Version 1.0 • April, 2020',
                  style: TextStyle(color: Colors.black38, fontSize: 12),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
