import 'package:feed/models/comment_model.dart';

class ReviewModel {
  final String id;
  final String userName;
  final String userAvatar;
  final String timeAgo;
  final double rating;
  final String route;
  final String airline;
  final String travelClass;
  final String date;
  final String reviewText;
  final String? imageUrl;
  final int likes;
  final int comments;
  final List<CommentModel> commentsList;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.timeAgo,
    required this.rating,
    required this.route,
    required this.airline,
    required this.travelClass,
    required this.date,
    required this.reviewText,
    this.imageUrl,
    this.likes = 0,
    this.comments = 0,
    this.commentsList = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userAvatar': userAvatar,
      'timeAgo': timeAgo,
      'rating': rating,
      'route': route,
      'airline': airline,
      'travelClass': travelClass,
      'date': date,
      'reviewText': reviewText,
      'imageUrl': imageUrl,
      'likes': likes,
      'comments': comments,
      'commentsList': commentsList.map((c) => c.toJson()).toList(),
    };
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      userName: json['userName'],
      userAvatar: json['userAvatar'],
      timeAgo: json['timeAgo'],
      rating: json['rating'].toDouble(),
      route: json['route'],
      airline: json['airline'],
      travelClass: json['travelClass'],
      date: json['date'],
      reviewText: json['reviewText'],
      imageUrl: json['imageUrl'],
      likes: json['likes'],
      comments: json['comments'],
      commentsList: (json['commentsList'] as List)
          .map((c) => CommentModel.fromJson(c))
          .toList(),
    );
  }
}
