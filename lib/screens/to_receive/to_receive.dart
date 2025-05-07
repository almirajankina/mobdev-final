import 'package:flutter/material.dart';
import 'package:profile_app/screens/to_receive/track_to_receive.dart';
import 'package:profile_app/screens/to_receive/delivered_review.dart';
import 'package:profile_app/screens/voucher/vouchers_screen.dart';
import 'package:profile_app/screens/settings/settings.dart';

class ToReceiveScreen extends StatelessWidget {
  const ToReceiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/flash_sale_2.png'),
              radius: 20,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To Receive',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'My Orders',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        actions: [
          const Icon(Icons.menu, color: Color(0xFF004CFF)),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.discount_outlined, color: Color(0xFF004CFF)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VouchersScreen()),
              );
            },
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF004CFF)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildOrderCard(
            context,
            image: 'assets/images/top_products_1.png',
            status: 'Packed',
            items: 3,
            buttonText: 'Track',
            isDelivered: false,
          ),
          buildOrderCard(
            context,
            image: 'assets/images/categories_watch_1.png',
            status: 'Shipped',
            items: 4,
            buttonText: 'Track',
            isDelivered: false,
          ),
          buildOrderCard(
            context,
            image: 'assets/images/profile_most_popular_1.png',
            status: 'Delivered',
            items: 2,
            buttonText: 'Review',
            isDelivered: true,
          ),
          buildOrderCard(
            context,
            image: 'assets/images/profile_most_popular_2.png',
            status: 'Delivered',
            items: 5,
            buttonText: 'Review',
            isDelivered: true,
          ),
          buildOrderCard(
            context,
            image: 'assets/images/profile_most_popular_4.png',
            status: 'Delivered',
            items: 1,
            buttonText: 'Review',
            isDelivered: true,
          ),
        ],
      ),
    );
  }

  Widget buildOrderCard(
    BuildContext context, {
    required String image,
    required String status,
    required int items,
    required String buttonText,
    required bool isDelivered,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order #92287157',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Standard Delivery',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        status,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isDelivered ? Colors.green : Colors.orange,
                          fontSize: 13,
                        ),
                      ),
                      if (isDelivered)
                        const Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Icon(Icons.check_circle,
                              size: 16, color: Color(0xFF004CFF)),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$items items',
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 85,
                  height: 32,
                  child: buttonText == 'Track'
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TrackOrderScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF004CFF),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Track'),
                        )
                      : OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TrackOrderCompletedScreen()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Color(0xFF004CFF),
                            side: const BorderSide(color: Color(0xFF004CFF)),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Review'),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
