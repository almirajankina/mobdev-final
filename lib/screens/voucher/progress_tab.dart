import 'package:flutter/material.dart';

class ProgressTab extends StatelessWidget {
  const ProgressTab({super.key});

  @override
  Widget build(BuildContext context) {
    final rewards = [
      {'icon': Icons.lock, 'title': 'First Purchase'},
      {'icon': Icons.favorite, 'title': 'Loyal Customer'},
      {'icon': Icons.star, 'title': 'Review Maker'},
      {'icon': Icons.face, 'title': 'Big Soul'},
      {'icon': Icons.emoji_people, 'title': 'T-Shirt Collector'},
      {'icon': Icons.shopping_bag, 'title': '10+ Orders'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: rewards.length,
      itemBuilder: (context, index) {
        final reward = rewards[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(reward['icon'] as IconData, size: 36, color: Colors.blue),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reward['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
