import 'package:flutter/material.dart';

// Updated InfoChip widget (if you want to modify it)
class InfoChip extends StatelessWidget {
  final String text;

  const InfoChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// Widget to display multiple info chips with wrapping
class InfoChipsRow extends StatelessWidget {
  final List<String> chipTexts;
  final double spacing;
  final double runSpacing;

  const InfoChipsRow({
    super.key,
    required this.chipTexts,
    this.spacing = 8.0,
    this.runSpacing = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing, // Horizontal spacing between chips
      runSpacing: runSpacing, // Vertical spacing between rows
      children: chipTexts.map((text) => InfoChip(text: text)).toList(),
    );
  }
}

// Example usage in your ReviewCard or any other widget
class ExampleUsage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example chip data - replace with your actual data
    final List<String> tags = [
      'Adventure',
      'Mountain Hiking',
      'Scenic Route',
      'Family Friendly',
      'Photography',
      'Wildlife',
      'Beginner Level',
      'Day Trip',
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Info Chips Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tags:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            InfoChipsRow(
              chipTexts: tags,
              spacing: 8.0, // Space between chips horizontally
              runSpacing: 8.0, // Space between rows vertically
            ),
          ],
        ),
      ),
    );
  }
}
