import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed/models/review_model.dart';
import 'package:flutter/material.dart';

class ReviewImage extends StatelessWidget {
  final ReviewModel review;

  const ReviewImage({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        child: CachedNetworkImage(
          imageUrl: review.imageUrl!,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            height: 200,
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
