import 'package:feed/models/comment_model.dart';
import 'package:feed/models/review_model.dart';

class SampleData {
  static List<ReviewModel> getReviews() {
    return [
      ReviewModel(
        id: '1',
        userName: 'Dianne Russell',
        userAvatar:
            'https://images.unsplash.com/photo-1494790108755-2616b612b3fd?w=150&h=150&fit=crop&crop=face',
        timeAgo: '1 day ago',
        rating: 5.0,
        route: 'LHR - DEL',
        airline: 'Air India',
        travelClass: 'Business Class',
        date: 'July 2023',
        reviewText:
            'I flew from DEL to DEL right on time but going with business class was the best experienced overall at your fingertips . a smoother, more convenient a smoother, more convenient other more convenient experience right at your',
        imageUrl:
            'https://images.unsplash.com/photo-1556388158-158ea5ccacbd?w=400&h=300&fit=crop',
        likes: 30,
        comments: 20,
        commentsList: [
          CommentModel(
            id: '1',
            userName: 'Damon Laveague',
            userAvatar:
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
            timeAgo: '2hrs ago',
            commentText:
                'Amazing review! Looks like a great experience. My question is: uidismod ullamco sed sit duis dolore exercitation non amet. Ullamco est consectetuer ullam fugiat elit do consectetur ut duis reprehenderit enim sed.',
            upvotes: 5,
          ),
        ],
      ),
    ];
  }
}
