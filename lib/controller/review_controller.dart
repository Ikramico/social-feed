import 'package:feed/data/sample_data.dart';
import 'package:feed/models/comment_model.dart';
import 'package:feed/models/review_model.dart';
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
}
