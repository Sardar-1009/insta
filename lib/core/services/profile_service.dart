import '../models/user.dart';

class ProfileService {
  Future<User> fetchMe() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return const User(
      id: 'me',
      username: 'salikh',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
    );
  }

  Future<List<String>> fetchMyPosts() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return List.generate(21, (i) => 'https://picsum.photos/600/600?random=${i + 300}');
  }
}
