import 'user.dart';

class Post {
  final String id;
  final User user;
  final String imageUrl;
  final String caption;
  final int likes;
  final DateTime createdAt;

  const Post({
    required this.id,
    required this.user,
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.createdAt,
  });
}
