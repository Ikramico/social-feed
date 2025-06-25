import 'package:feed/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReviewActionButtons extends StatelessWidget {
  final ReviewModel review;
  final VoidCallback onLike;
  final VoidCallback onShare;

  const ReviewActionButtons({
    super.key,
    required this.review,
    required this.onLike,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: onLike,
            icon: SvgPicture.asset(
              'lib/assets/svgs/thumbs_up.svg',
              width: 25,
              height: 25,
            ),
            label: const Text(
              'Like',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black,
              ),
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[600],
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
          TextButton.icon(
            onPressed: onShare,
            icon: SvgPicture.asset(
              'lib/assets/svgs/share.svg',
              width: 22,
              height: 22,
            ),
            label: const Text(
              'Share',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,
              color: Colors.black,
              ),
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[600],
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        ],
      ),
    );
  }
}
