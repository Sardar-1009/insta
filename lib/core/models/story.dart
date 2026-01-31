import 'user.dart';

class Story {
  final String id;
  final User user;
  final bool isViewed;
  final String mediaUrl;

  const Story({
    required this.id,
    required this.user,
    required this.isViewed,
    required this.mediaUrl,
  });
}
