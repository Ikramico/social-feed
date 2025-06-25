import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ImageUploadWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const ImageUploadWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: const RectDottedBorderOptions(
        strokeWidth: 1,
        dashPattern: [6, 3],
        color: Color.fromARGB(255, 209, 209, 230),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/assets/images/image-upload.png'),
              const SizedBox(height: 8),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Drop Your Image Here Or ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'Browse',
                      style: TextStyle(
                        color: Color(0xFF364AFF),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF364AFF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
