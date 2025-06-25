import 'package:flutter/material.dart';

class ShareExperienceHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback onClose;

  const ShareExperienceHeaderWidget({
    super.key,
    required this.title,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: const Icon(Icons.close, color: Colors.black, size: 24),
          ),
        ],
      ),
    );
  }
}
