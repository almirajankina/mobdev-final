import 'package:flutter/material.dart';
import 'package:profile_app/screens/settings/settings_country.dart';
import 'package:profile_app/screens/settings/settings_currency.dart';
import 'package:profile_app/screens/settings/settings_sizes.dart';
import 'package:profile_app/screens/settings/settings_language.dart';
import 'package:profile_app/screens/settings/settings_payment.dart';
import 'package:profile_app/screens/settings/settings_about.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:profile_app/screens/authentification/login.dart';
import 'package:profile_app/screens/settings/settings_profile_edit.dart';

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
          fontSize: 18,
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
          trailing: const Icon(Icons.arrow_forward_ios, size: 18),
          onTap: onTap,
        ),
        const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Color(0xFF004CFF),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          buildSectionTitle('Personal'),
          buildSettingRow(
            'Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfileScreen()),
              );
            },
          ),
          buildSettingRow('Shipping Address'),
          buildSettingRow(
            'Payment Methods',
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsAddCardPage(),
                ),
              );
            },
          ),
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
                  builder: (context) => CurrencySelectionScreen(
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
                  builder: (context) =>
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
          buildSectionTitle('Account'),
          buildSettingRow(
            'Language${selectedLanguage != null ? ': $selectedLanguage' : ''}',
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LanguageSelectionScreen(
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
          buildSettingRow(
            'About Shoppe',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  _showDeleteConfirmationDialog(user);
                }
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
          const Center(
            child: Column(
              children: [
                Text(
                  'Shoppe',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Version 1.0 • May, 2025',
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

  void _showDeleteConfirmationDialog(User user) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFE5EC),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.pinkAccent,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'You are going to delete\nyour account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "You won't be able to restore your data",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFB6C1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.pop(context); // Закрываем диалог

                          try {
                            await user.delete(); // Удаляем аккаунт
                            await FirebaseAuth.instance
                                .signOut(); // Обязательно выходим

                            // Переход на экран логина без маршрутов
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (Route<dynamic> route) => false,
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'requires-recent-login') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please re-authenticate to delete your account.')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: ${e.message}')),
                              );
                            }
                          }
                        },
                        child: const Text('Delete'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
