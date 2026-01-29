import 'package:stacked/stacked.dart';
import '../../../app/locator.dart';
import '../../../core/models/post.dart';
import '../../../core/models/story.dart';
import '../../../core/repositories/feed_repository.dart';

class HomeViewModel extends BaseViewModel {
  final FeedRepository _repo = locator<FeedRepository>();

  List<Story> stories = [];
  List<Post> posts = [];

  Future<void> init() async {
    setBusy(true);
    try {
      final res = await Future.wait([
        _repo.getStories(),
        _repo.getPosts(),
      ]);
      stories = res[0] as List<Story>;
      posts = res[1] as List<Post>;
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> refresh() => init();
}
