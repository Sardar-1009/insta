import 'user.dart';

class MessageThread {
  final String id;
  final User peer;
  final String lastMessage;
  final DateTime updatedAt;
  final int unreadCount;

  const MessageThread({
    required this.id,
    required this.peer,
    required this.lastMessage,
    required this.updatedAt,
    required this.unreadCount,
  });
}
