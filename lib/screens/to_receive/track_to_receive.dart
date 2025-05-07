import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrackOrderScreen extends StatelessWidget {
  final String trackingNumber = "LGS-I92927839300763731";

  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int totalSteps = 6;
    final int completedSteps = 6;
    final bool isFailed = false;

    final double progress = completedSteps / totalSteps;
    final bool isLastStep = completedSteps == totalSteps;
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
                  'Track Your Order',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  // Фоновая линия
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  // Прогресс линия с градиентом
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isLastStep && !isFailed
                              ? [
                                  Color(0xFF004CFF),
                                  Color(0xFF004CFF),
                                  const Color.fromARGB(255, 190, 25, 10),
                                ]
                              : [Color(0xFF004CFF), Colors.lightBlueAccent],
                          stops:
                              isLastStep && !isFailed ? [0.0, 0.7, 1.0] : null,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),

                  // Точки по этапам
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(totalSteps, (index) {
                      final bool isCompleted = index < completedSteps;
                      return Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? (isLastStep && index == totalSteps - 1
                                  ? const Color.fromARGB(255, 190, 25, 10)
                                  : Color(0xFF004CFF))
                              : Colors.white,
                          border: Border.all(
                            color: isCompleted
                                ? (isLastStep && index == totalSteps - 1
                                    ? const Color.fromARGB(255, 190, 25, 10)
                                    : Color(0xFF004CFF))
                                : Colors.grey,
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tracking number
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      trackingNumber,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: trackingNumber));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tracking number copied')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Timeline steps
            buildTrackingStep(
              title: "Packed",
              subtitle:
                  "Your parcel is packed and will be handed over to our delivery partner.",
              date: "April19 12:31",
              active: true,
            ),
            buildTrackingStep(
              title: "On the Way to Logistic Facility",
              subtitle:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
              date: "April19 16:20",
              active: true,
            ),
            buildTrackingStep(
              title: "Arrived at Logistic Facility",
              subtitle:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
              date: "April19 19:07",
              active: true,
            ),
            buildTrackingStep(
              title: "Shipped",
              subtitle:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
              date: "April20 06:15",
              active: true,
            ),
            buildTrackingStep(
              title: "Out for Delivery",
              subtitle:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
              date: "April22 11:10",
              active: true,
            ),

            // Delivery failed
            GestureDetector(
              onTap: () {
                // Показываем уведомление при нажатии на текст
                _showNotificationDialog(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Attempt to deliver your parcel was not successful",
                        style: TextStyle(
                          color: Color(0xFF004CFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "April19 12:50",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTrackingStep({
    required String title,
    required String subtitle,
    required String date,
    required bool active,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            size: 20,
            color: active ? Color(0xFF004CFF) : Colors.grey,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: active ? Colors.black : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: active ? Colors.black87 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            date,
            style: TextStyle(
              color: active ? Colors.black : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// Метод для отображения уведомления
void _showNotificationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.warning_amber_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text(
              "Delivery was not successful",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "What should I do?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Don't worry, we will shortly contact you to arrange a more suitable time for the delivery. "
              "You can also contact us at +00 000 000 000 or chat with our customer care service.",
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF004CFF),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              //Переход в чат
            },
            child: const Text("Chat Now"),
          ),
        ],
      );
    },
  );
}
