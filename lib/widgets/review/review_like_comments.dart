import 'package:feed/models/review_model.dart';
import 'package:flutter/material.dart';

class ReviewLikesCommentsInfo extends StatelessWidget {
  final ReviewModel review;

  const ReviewLikesCommentsInfo({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            '${review.likes} Like',
            style: TextStyle(color: Colors.grey[800], fontSize: 15),
          ),
          const SizedBox(width: 16),
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[500],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '${review.comments} Comment',
            style: TextStyle(color: Colors.grey[800], fontSize: 15),
          ),
        ],
      ),
    );
  }
}
