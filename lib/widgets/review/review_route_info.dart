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
      child: Wrap(
        spacing: 5,
        runSpacing: 4,
        direction: Axis.horizontal,
        children: [
          InfoChip(text: review.route),
          InfoChip(text: review.airline),
          InfoChip(text: review.travelClass),
          InfoChip(text: review.date),
        ],
      ),
    );
  }
}
