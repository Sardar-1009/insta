import '../models/post.dart';
import '../models/story.dart';
import '../services/feed_service.dart';

class FeedRepository {
  final FeedService _service;
  FeedRepository(this._service);

  Future<List<Story>> getStories() => _service.fetchStories();
  Future<List<Post>> getPosts() => _service.fetchPosts();
}
