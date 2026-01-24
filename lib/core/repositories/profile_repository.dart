import '../models/user.dart';
import '../services/profile_service.dart';

class ProfileRepository {
  final ProfileService _service;
  ProfileRepository(this._service);

  Future<User> getMe() => _service.fetchMe();
  Future<List<String>> getMyPosts() => _service.fetchMyPosts();
}
