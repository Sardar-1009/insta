import '../models/message_thread.dart';
import '../models/user.dart';

class DirectService {
  Future<List<MessageThread>> fetchThreads() async {
    await Future.delayed(const Duration(milliseconds: 300));

    const u1 = User(
      id: 'u2',
      username: 'sardar',
      avatarUrl: 'https://i.pravatar.cc/150?img=32',
    );
    const u2 = User(
      id: 'u3',
      username: 'compass',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
    );
    const u3 = User(
      id: 'u4',
      username: 'designer',
      avatarUrl: 'https://i.pravatar.cc/150?img=22',
    );

    return [
      MessageThread(
        id: 't1',
        peer: u1,
        lastMessage: 'Ок, делаем по MVVM ✅',
        updatedAt: DateTime.now().subtract(const Duration(minutes: 12)),
        unreadCount: 2,
      ),
      MessageThread(
        id: 't2',
        peer: u2,
        lastMessage: 'Скинь дизайн для профиля',
        updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
        unreadCount: 0,
      ),
      MessageThread(
        id: 't3',
        peer: u3,
        lastMessage: 'Завтра созвон по рилсам?',
        updatedAt: DateTime.now().subtract(const Duration(days: 1, minutes: 3)),
        unreadCount: 5,
      ),
    ];
  }
}
