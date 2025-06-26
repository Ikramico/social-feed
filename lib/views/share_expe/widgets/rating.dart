import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final int rating;
  final Function(int) onRatingChanged;
  final String label;
  final int maxRating;
  final double starSize;
  final Color activeColor;
  final Color inactiveColor;
  final Color borderColor;

  const StarRatingWidget({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.borderColor = const Color.fromARGB(255, 206, 205, 205),
    this.label = 'Rating',
    this.maxRating = 5,
    this.starSize = 22,
    this.activeColor = Colors.amber,
    Color? inactiveColor,
  }) : inactiveColor = inactiveColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 8),
        Row(
          children: List.generate(maxRating, (index) {
            final isActive = index < rating;
            return GestureDetector(
              onTap: () => onRatingChanged(index + 1),
              child: Stack(
                children: [
                  // Filled star (background)
                  Icon(
                    Icons.star,
                    color: isActive ? activeColor : inactiveColor,
                    size: starSize,
                  ),
                  // Outlined star (border)
                  Icon(Icons.star_border, color: borderColor, size: starSize),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
