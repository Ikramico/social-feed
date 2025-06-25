import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class NavigationController extends GetxController {
  void navigateToShareExperience(BuildContext context) {
    context.push('/share-experience');
  }

  void navigateToAskQuestion(BuildContext context) {
    context.push('/ask-question');
  }

  void navigateToSearch(BuildContext context) {
    context.push('/search');
  }

  void shareReview(String reviewId) {
    Get.snackbar(
      'Share',
      'Review shared successfully!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
