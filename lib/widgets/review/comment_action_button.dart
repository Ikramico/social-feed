
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentActionButtons extends StatelessWidget {
  const CommentActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('lib/assets/svgs/up_arrow.svg', width: 25, height: 25),
        const SizedBox(width: 8,),
        const Text(
          'Upvote',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        const SizedBox(width: 30),
        SvgPicture.asset('lib/assets/svgs/reply.svg', width: 25, height: 25),
        const SizedBox(width: 8),
        const Text(
          'Reply',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
