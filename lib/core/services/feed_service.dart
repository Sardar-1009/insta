import '../models/post.dart';
import '../models/story.dart';
import '../models/user.dart';

class FeedService {
  Future<List<Story>> fetchStories() async {
    await Future.delayed(const Duration(milliseconds: 250));

    const u1 = User(
      id: 'u1',
      username: 'salikh',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
    );
    const u2 = User(
      id: 'u2',
      username: 'sardar',
      avatarUrl: 'https://i.pravatar.cc/150?img=32',
    );
    const u3 = User(
      id: 'u3',
      username: 'compass',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
    );

    return const [
      Story(id: 's1', user: u1, isViewed: false),
      Story(id: 's2', user: u2, isViewed: true),
      Story(id: 's3', user: u3, isViewed: false),
    ];
  }

  Future<List<Post>> fetchPosts() async {
    await Future.delayed(const Duration(milliseconds: 350));

    const u1 = User(
      id: 'u1',
      username: 'salikh',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
    );
    const u2 = User(
      id: 'u2',
      username: 'sardar',
      avatarUrl: 'https://i.pravatar.cc/150?img=32',
    );

    return [
      Post(
        id: 'p1',
        user: u1,
        imageUrl: 'https://picsum.photos/900/900?random=11',
        caption: 'Первый пост в нашем клоне 👋',
        likes: 124,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      Post(
        id: 'p2',
        user: u2,
        imageUrl: 'https://picsum.photos/900/900?random=25',
        caption: 'MVVM + чистая архитектура — кайф.',
        likes: 982,
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      ),
    ];
  }
}
