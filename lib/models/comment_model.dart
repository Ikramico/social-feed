class CommentModel {
  final String id;
  final String userName;
  final String userAvatar;
  final String timeAgo;
  final String commentText;
  final int upvotes;

  CommentModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.timeAgo,
    required this.commentText,
    this.upvotes = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userAvatar': userAvatar,
      'timeAgo': timeAgo,
      'commentText': commentText,
      'upvotes': upvotes,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      userName: json['userName'],
      userAvatar: json['userAvatar'],
      timeAgo: json['timeAgo'],
      commentText: json['commentText'],
      upvotes: json['upvotes'],
    );
  }
}
