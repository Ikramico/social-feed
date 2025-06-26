import 'package:feed/data/sample_data.dart';
import 'package:feed/models/comment_model.dart';
import 'package:feed/models/review_model.dart';
import 'package:feed/models/airport_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ReviewController extends GetxController {
  final RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadReviews();
  }

  Future<void> loadReviews() async {
    isLoading.value = true;

    final prefs = await SharedPreferences.getInstance();
    final reviewsJson = prefs.getStringList('reviews') ?? [];

    if (reviewsJson.isEmpty) {
      reviews.value = SampleData.getReviews();
      await saveReviews();
    } else {
      reviews.value = reviewsJson
          .map((json) => ReviewModel.fromJson(jsonDecode(json)))
          .toList();
    }

    isLoading.value = false;
  }

  Future<void> saveReviews() async {
    final prefs = await SharedPreferences.getInstance();
    final reviewsJson = reviews
        .map((review) => jsonEncode(review.toJson()))
        .toList();
    await prefs.setStringList('reviews', reviewsJson);
  }

  /// Add a new review from share experience form
  Future<void> addNewReview({
    required Airport departureAirport,
    required Airport arrivalAirport,
    required String airline,
    required String travelClass,
    required DateTime travelDate,
    required int rating,
    required String reviewText,
    String? imageUrl,
    String? userName,
    String? userAvatar,
  }) async {
    try {
      // Generate unique ID
      final String reviewId = DateTime.now().millisecondsSinceEpoch.toString();

      // Create route string
      final String route = '${departureAirport.iata} - ${arrivalAirport.iata}';

      // Format date
      final String formattedDate = _formatDate(travelDate);

      // Get user info (you can customize this based on your user management)
      final String finalUserName = userName ?? 'Anonymous User';
      final String finalUserAvatar =
          userAvatar ??
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face';

      // Create new review
      final ReviewModel newReview = ReviewModel(
        id: reviewId,
        userName: finalUserName,
        userAvatar: finalUserAvatar,
        timeAgo: 'Just now',
        rating: rating.toDouble(),
        route: route,
        airline: airline,
        travelClass: travelClass,
        date: formattedDate,
        reviewText: reviewText,
        imageUrl: imageUrl,
        likes: 0,
        comments: 0,
        commentsList: [],
      );

      // Add to the beginning of the list (most recent first)
      reviews.insert(0, newReview);

      // Save to local storage
      await saveReviews();

      // Show success message
      Get.snackbar(
        'Success',
        'Your review has been shared successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      // Show error message
      Get.snackbar(
        'Error',
        'Failed to share your review. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      print('Error adding review: $e');
    }
  }

  /// Format date for display
  String _formatDate(DateTime date) {
    const List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[date.month - 1]} ${date.year}';
  }

  /// Update time ago for all reviews (call this periodically)
  void updateTimeAgo() {
    for (int i = 0; i < reviews.length; i++) {
      final review = reviews[i];
      final updatedTimeAgo = _calculateTimeAgo(review.id);

      if (updatedTimeAgo != review.timeAgo) {
        reviews[i] = ReviewModel(
          id: review.id,
          userName: review.userName,
          userAvatar: review.userAvatar,
          timeAgo: updatedTimeAgo,
          rating: review.rating,
          route: review.route,
          airline: review.airline,
          travelClass: review.travelClass,
          date: review.date,
          reviewText: review.reviewText,
          imageUrl: review.imageUrl,
          likes: review.likes,
          comments: review.comments,
          commentsList: review.commentsList,
        );
      }
    }
    saveReviews();
  }

  /// Calculate time ago based on review ID (timestamp)
  String _calculateTimeAgo(String reviewId) {
    try {
      final timestamp = int.parse(reviewId);
      final reviewTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(reviewTime);

      if (difference.inMinutes < 1) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}h ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return '${weeks}w ago';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return '${months}mo ago';
      } else {
        final years = (difference.inDays / 365).floor();
        return '${years}y ago';
      }
    } catch (e) {
      return 'Some time ago';
    }
  }

  void likeReview(String reviewId) {
    final index = reviews.indexWhere((r) => r.id == reviewId);
    if (index != -1) {
      final review = reviews[index];
      reviews[index] = ReviewModel(
        id: review.id,
        userName: review.userName,
        userAvatar: review.userAvatar,
        timeAgo: review.timeAgo,
        rating: review.rating,
        route: review.route,
        airline: review.airline,
        travelClass: review.travelClass,
        date: review.date,
        reviewText: review.reviewText,
        imageUrl: review.imageUrl,
        likes: review.likes + 1,
        comments: review.comments,
        commentsList: review.commentsList,
      );
      saveReviews();
    }
  }

  void addComment(String reviewId, CommentModel comment) {
    final index = reviews.indexWhere((r) => r.id == reviewId);
    if (index != -1) {
      final review = reviews[index];
      final updatedComments = List<CommentModel>.from(review.commentsList)
        ..add(comment);

      reviews[index] = ReviewModel(
        id: review.id,
        userName: review.userName,
        userAvatar: review.userAvatar,
        timeAgo: review.timeAgo,
        rating: review.rating,
        route: review.route,
        airline: review.airline,
        travelClass: review.travelClass,
        date: review.date,
        reviewText: review.reviewText,
        imageUrl: review.imageUrl,
        likes: review.likes,
        comments: review.comments + 1,
        commentsList: updatedComments,
      );
      saveReviews();
    }
  }

  /// Delete a review (optional functionality)
  Future<void> deleteReview(String reviewId) async {
    reviews.removeWhere((review) => review.id == reviewId);
    await saveReviews();

    Get.snackbar(
      'Deleted',
      'Review has been deleted',
      backgroundColor: Colors.grey[600],
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  /// Get reviews by airline (for filtering)
  List<ReviewModel> getReviewsByAirline(String airline) {
    return reviews
        .where(
          (review) =>
              review.airline.toLowerCase().contains(airline.toLowerCase()),
        )
        .toList();
  }

  /// Get reviews by route (for filtering)
  List<ReviewModel> getReviewsByRoute(String route) {
    return reviews
        .where(
          (review) => review.route.toLowerCase().contains(route.toLowerCase()),
        )
        .toList();
  }

  /// Get reviews by rating range (for filtering)
  List<ReviewModel> getReviewsByRating(double minRating, double maxRating) {
    return reviews
        .where(
          (review) => review.rating >= minRating && review.rating <= maxRating,
        )
        .toList();
  }
}
