import 'package:flutter/material.dart';

class PaymentInProgressScreen extends StatelessWidget {
  final bool isSuccess;

  const PaymentInProgressScreen({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    // Автоматический переход после 3 секунд
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        isSuccess ? '/paymentSuccess' : '/paymentFailed',
      );
    });

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: 280,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(height: 8),
              CircularProgressIndicator(color: Color(0xFF004CFF)),
              SizedBox(height: 24),
              Text(
                'Payment is in progress',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Please, wait a few moments',
                style: TextStyle(color: Colors.grey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
