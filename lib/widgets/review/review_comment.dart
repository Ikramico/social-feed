import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed/models/comment_model.dart';
import 'package:feed/widgets/review/comment_action_button.dart';
import 'package:feed/widgets/review/comment_header.dart';
import 'package:flutter/material.dart';

class ReviewComment extends StatelessWidget {
  final CommentModel comment;

  const ReviewComment({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: CachedNetworkImageProvider(comment.userAvatar),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommentHeader(comment: comment),
                const SizedBox(height: 4),
                Text(
                  comment.commentText,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
                const SizedBox(height: 8),
                const CommentActionButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
