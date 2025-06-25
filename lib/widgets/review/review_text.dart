import 'package:feed/models/review_model.dart';
import 'package:flutter/material.dart';

class ReviewText extends StatelessWidget {
  final ReviewModel review;

  const ReviewText({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        review.reviewText,
        style: TextStyle(fontSize: 14, color: Colors.grey[800], height: 1.4),
      ),
    );
  }
}
