import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final int rating;
  final Function(int) onRatingChanged;
  final String label;
  final int maxRating;
  final double starSize;
  final Color activeColor;
  final Color inactiveColor;

  const StarRatingWidget({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.label = 'Rating',
    this.maxRating = 5,
    this.starSize = 24,
    this.activeColor = Colors.amber,
    Color? inactiveColor,
  }) : inactiveColor = inactiveColor ?? Colors.grey;

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
            return GestureDetector(
              onTap: () => onRatingChanged(index + 1),
              child: Icon(
                Icons.star,
                color: index < rating ? activeColor : inactiveColor,
                size: starSize,
              ),
            );
          }),
        ),
      ],
    );
  }
}
