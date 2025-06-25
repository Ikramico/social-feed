import 'package:feed/models/comment_model.dart';
import 'package:flutter/material.dart';

class CommentHeader extends StatelessWidget {
  final CommentModel comment;

  const CommentHeader({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              comment.userName,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
            
            const Spacer(),
            Text(
              '${comment.upvotes} Upvotes',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
          
        ),
        const SizedBox(height: 3),
        Text(
          comment.timeAgo,
          style: TextStyle(color: Colors.grey[800], fontSize: 11),
        ),
      ],
    );
  }
}
