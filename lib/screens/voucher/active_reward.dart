import 'package:flutter/material.dart';

class ActiveRewardsTab extends StatelessWidget {
  const ActiveRewardsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _voucherCard(
          title: 'First Purchase',
          description: '5% off for your next order',
          validUntil: 'Valid Until 5.16.20',
          isExpiring: false,
        ),
        _voucherCard(
          title: 'Gift From Customer Care',
          description: '15% off your next purchase',
          validUntil: 'Valid Until 6.20.20',
          isExpiring: false,
        ),
        _voucherCard(
          title: 'Loyal Customer',
          description: '10% off your next purchase',
          validUntil: 'Valid Until 6.20.20',
          isExpiring: true,
          expiringText: '3 days left',
        ),
      ],
    );
  }

  Widget _voucherCard({
    required String title,
    required String description,
    required String validUntil,
    required bool isExpiring,
    String? expiringText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isExpiring ? Colors.red[50] : Colors.white,
        border: Border.all(
          color: isExpiring ? Colors.red : Colors.blue,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.card_giftcard, size: 32, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(description),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (isExpiring && expiringText != null)
                      Text(
                        expiringText,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const Spacer(),
                    Text(
                      validUntil,
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Collected',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
