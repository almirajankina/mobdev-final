import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  bool _obscurePassword = true;
  File? _profileImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _registerUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final phone = phoneController.text.trim();

    if (email.isEmpty || password.isEmpty || phone.isEmpty || _profileImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fill all fields and select a photo')),
      );
      return;
    }

    try {
      // ✅ Register with Firebase Auth
      UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final uid = userCred.user!.uid;
      print("✅ Registered user: $uid");

      // ✅ Upload profile image to Firebase Storage
      final imageRef = FirebaseStorage.instance.ref().child('users/$uid/profile.jpg');
      await imageRef.putFile(_profileImage!);
      final imageUrl = await imageRef.getDownloadURL();
      print("✅ Image uploaded: $imageUrl");

      // ✅ Prepare data
      final Map<String, dynamic> userData = {
        'uid': uid,
        'email': email,
        'phone': phone,
        'imageUrl': imageUrl,
        'passwordLength': password.length,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // ✅ Write to Firestore under users/{uid}
      await FirebaseFirestore.instance.collection('users').doc(uid).set(userData);
      print("✅ User data written to Firestore");

      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      print("❌ Error during registration: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 330,
                  child: Image.asset('assets/images/Bubbles.png', fit: BoxFit.cover),
                ),
                const Positioned(
                  left: 24,
                  bottom: 24,
                  child: Text(
                    'Create\nAccount',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: CustomPaint(
                    painter: DashedCirclePainter(),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt_outlined, size: 32, color: Colors.blue),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildInputField(controller: emailController, hintText: 'Email'),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: phoneController,
                    hintText: 'Your Number',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _registerUser,
                      child: const Text('Done', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/welcome');
                    },
                    child: const Text('Cancel', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 6;
    const dashSpace = 4;
    final radius = size.width / 2;
    final count = (2 * 3.1415926 * radius / (dashWidth + dashSpace)).floor();
    final angleStep = 2 * 3.1415926 / count;

    for (int i = 0; i < count; i++) {
      final startAngle = i * angleStep;
      final sweepAngle = angleStep * (dashWidth / (dashWidth + dashSpace));
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
