import 'package:feed/models/review_model.dart';
import 'package:feed/widgets/review/info_chip.dart';
import 'package:flutter/material.dart';

class ReviewRouteInfo extends StatelessWidget {
  final ReviewModel review;

  const ReviewRouteInfo({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          InfoChip(text: review.route),
          const SizedBox(width: 8),
          InfoChip(text: review.airline),
          const SizedBox(width: 8),
          InfoChip(text: review.travelClass),
          const SizedBox(width: 8),
          InfoChip(text: review.date),
        ],
      ),
    );
  }
}
