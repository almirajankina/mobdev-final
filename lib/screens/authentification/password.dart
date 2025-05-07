import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String email = '';
  String? firstName;
  int passwordLength = 0;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String && email.isEmpty) {
      email = args;
      fetchUserInfo();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });

    passwordController.addListener(() {
      setState(() {});
    });
  }

  Future<void> fetchUserInfo() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        setState(() {
          firstName = data['email'].split('@')[0];
          passwordLength = data['passwordLength'] ?? 0;
        });
      } else {
        throw Exception("No user found");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading user data: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildPasswordDots(int total, int filled) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        total,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: index < filled ? Color(0xFF004CFF) : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 280,
                  child: Image.asset(
                    'assets/images/Bubbles3.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/image.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Hello, ${firstName ?? 'User'}',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Type your password',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 24),

                        // Dots
                        buildPasswordDots(
                          passwordLength,
                          passwordController.text.length,
                        ),

                        // Скрытый TextField
                        Opacity(
                          opacity: 0.0,
                          child: TextField(
                            focusNode: _focusNode,
                            controller: passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            onSubmitted: (_) => login(),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Login button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF004CFF),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: login,
                            child: const Text('Login',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),

                        const SizedBox(height: 12),

                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
