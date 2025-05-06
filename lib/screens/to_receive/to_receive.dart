import 'package:flutter/material.dart';
import 'package:profile_app/screens/to_receive/track_to_receive.dart';
import 'package:profile_app/screens/to_receive/delivered_review.dart';
import 'package:profile_app/screens/voucher/vouchers_screen.dart';
import 'package:profile_app/screens/settings/settings.dart'; // <-- добавь этот импорт

class ToReceiveScreen extends StatelessWidget {
  const ToReceiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          const Icon(Icons.menu, color: Colors.blue),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.discount_outlined, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VouchersScreen()),
              );
            },
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.blue),
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
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                width: 60,
                height: 60,
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Standard Delivery',
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        status,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDelivered ? Colors.black : Colors.orange,
                        ),
                      ),
                      if (isDelivered)
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 18,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  '$items items',
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 95,
                  child:
                      buttonText == 'Track'
                          ? ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const TrackOrderScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Track',
                              textAlign: TextAlign.center,
                            ),
                          )
                          : OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          const TrackOrderCompletedScreen(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              side: const BorderSide(color: Colors.blue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Review',
                              textAlign: TextAlign.center,
                            ),
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
