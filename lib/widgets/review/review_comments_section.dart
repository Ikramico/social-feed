import 'package:feed/models/review_model.dart';
import 'package:feed/widgets/review/comment_actions.dart';
import 'package:feed/widgets/review/review_comment.dart';
import 'package:flutter/material.dart';

class ReviewCommentsSection extends StatelessWidget {
  final ReviewModel review;

  const ReviewCommentsSection({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: const EdgeInsets.only(top: 5),

      child: Column(
        children: [
          ...review.commentsList.map(
            (comment) => Container(
                    decoration: BoxDecoration(
                color: const  Color(0xFFF2F2F8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ReviewComment(comment: comment)),
          ),
          const SizedBox(height: 8),
          const CommentActions(),
        ],
      ),
    );
  }
}
