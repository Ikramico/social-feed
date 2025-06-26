import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentActions extends StatefulWidget {
  final bool hasComments;
  final bool isFromShareExperience; // Add this parameter

  const CommentActions({
    super.key, 
    this.hasComments = false,
    this.isFromShareExperience = false, // Add this parameter
  });

  @override
  State<CommentActions> createState() => _CommentActionsState();
}

class _CommentActionsState extends State<CommentActions> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Only show "See More Comments" if there are comments AND it's NOT from share experience
        if (widget.hasComments && !widget.isFromShareExperience)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'See More Comments',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.grey[700],
              ),
            ),
          ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'lib/assets/images/user_avatar.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.person,
                        color: Colors.grey[600],
                        size: 24,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F8),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFF2F2F8)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: 'Write your comment',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 5,
                            ),
                          ),
                          maxLines: null,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (value) {
                            _sendComment();
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: _sendComment,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(right: 4),
                          child: SvgPicture.asset(
                            'lib/assets/svgs/send.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _sendComment() {
    if (_commentController.text.trim().isNotEmpty) {
      print('Comment: ${_commentController.text}');
      _commentController.clear();
    }
  }
}