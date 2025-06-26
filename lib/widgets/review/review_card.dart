import 'package:feed/controller/navigation_controller.dart';
import 'package:feed/controller/review_controller.dart';

import 'package:feed/models/review_model.dart';
import 'package:feed/widgets/review/review_action_button.dart';
import 'package:feed/widgets/review/review_comments_section.dart';
import 'package:feed/widgets/review/review_image.dart';
import 'package:feed/widgets/review/review_like_comments.dart';
import 'package:feed/widgets/review/review_route_info.dart';
import 'package:feed/widgets/review/review_text.dart';
import 'package:feed/widgets/review/review_user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  ReviewCard({super.key, required this.review});

  final ReviewController reviewController = Get.find<ReviewController>();
  final NavigationController navigationController =
      Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    final isFromShareExperience = review.timeAgo == 'Just now';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReviewUserInfo(review: review),
          ReviewRouteInfo(review: review),
          ReviewText(review: review),
          if (review.imageUrl != null) ReviewImage(review: review),
          const SizedBox(height: 10),
          ReviewLikesCommentsInfo(review: review),
          ReviewActionButtons(
            review: review,
            onLike: () => reviewController.likeReview(review.id),
            onShare: () => navigationController.shareReview(review.id),
          ),
          if (isFromShareExperience || review.commentsList.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ReviewCommentsSection(review: review),
            ),
        ],
      ),
    );
  }


}
