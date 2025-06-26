import 'package:feed/models/review_model.dart';
import 'package:feed/widgets/review/comment_actions.dart';
import 'package:feed/widgets/review/review_comment.dart';
import 'package:flutter/material.dart';

class ReviewCommentsSection extends StatelessWidget {
  final ReviewModel review;

  const ReviewCommentsSection({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final hasComments = review.commentsList.isNotEmpty;
    
    // Check if this review is from share experience
    // You can identify this by checking if timeAgo is "Just now" or by adding a flag to ReviewModel
    final isFromShareExperience = review.timeAgo == 'Just now';
    
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          // Only show comments if they exist AND it's not from share experience
          if (hasComments && !isFromShareExperience) ...[
            ...review.commentsList.map(
              (comment) => Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ReviewComment(comment: comment),
              ),
            ),
            const SizedBox(height: 8),
          ],
          
          // Always show comment input, but pass the flags
          CommentActions(
            hasComments: hasComments,
            isFromShareExperience: isFromShareExperience,
          ),
        ],
      ),
    );
  }
}