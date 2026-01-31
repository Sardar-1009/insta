import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../app/locator.dart';
import '../../../core/models/post.dart';
import '../../../core/models/story.dart';
import '../../../core/repositories/feed_repository.dart';

class HomeViewModel extends BaseViewModel {
  final FeedRepository _repo = locator<FeedRepository>();

  List<Story> _stories = [];
  List<Post> posts = [];

  final Set<String> likedPostIds = {};
  final Set<String> savedPostIds = {};
  final Set<String> viewedStoryIds = {};

  final Map<String, List<String>> postComments = {}; // postId -> comments
  final Map<String, List<String>> storyReplies = {}; // storyId -> replies

  List<Story> get stories {
    return _stories.map((s) {
      final viewed = viewedStoryIds.contains(s.id) || s.isViewed;
      return Story(
        id: s.id,
        user: s.user,
        isViewed: viewed,
        mediaUrl: s.mediaUrl,
      );
    }).toList();
  }

  Future<void> init() async {
    setBusy(true);
    try {
      final res = await Future.wait([
        _repo.getStories(),
        _repo.getPosts(),
      ]);
      _stories = res[0] as List<Story>;
      posts = res[1] as List<Post>;
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> refresh() => init();

  // ---------- Likes ----------
  bool isLiked(Post post) => likedPostIds.contains(post.id);

  void toggleLike(Post post) {
    if (isLiked(post)) {
      likedPostIds.remove(post.id);
    } else {
      likedPostIds.add(post.id);
    }
    notifyListeners();
  }

  void onDoubleTap(Post post) {
    if (!isLiked(post)) {
      likedPostIds.add(post.id);
      notifyListeners();
    }
  }

  // ---------- Save ----------
  bool isSaved(Post post) => savedPostIds.contains(post.id);

  void toggleSave(Post post) {
    if (isSaved(post)) {
      savedPostIds.remove(post.id);
    } else {
      savedPostIds.add(post.id);
    }
    notifyListeners();
  }

  // ---------- Share ----------
  void sharePost(BuildContext context, Post post) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Поделиться постом @${post.user.username}')),
    );
  }

  // ---------- Stories ----------
  void markStoryViewed(Story story) {
    viewedStoryIds.add(story.id);
    notifyListeners();
  }

  // ---------- Comments (Posts) ----------
  List<String> getPostComments(String postId) => postComments[postId] ?? const [];

  void addPostComment(String postId, String text) {
    final t = text.trim();
    if (t.isEmpty) return;
    postComments.putIfAbsent(postId, () => []);
    postComments[postId]!.add(t);
    notifyListeners();
  }

  Future<void> openPostCommentsSheet(BuildContext context, Post post) async {
    final controller = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Comments', style: TextStyle(fontWeight: FontWeight.w700)),
                const Divider(height: 20),

                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: getPostComments(post.id).length,
                    separatorBuilder: (_, __) => const Divider(height: 10),
                    itemBuilder: (_, i) => Text(getPostComments(post.id)[i]),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            filled: true,
                            fillColor: Colors.white10,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          addPostComment(post.id, controller.text);
                          controller.clear();
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------- Replies (Stories) ----------
  List<String> getStoryReplies(String storyId) => storyReplies[storyId] ?? const [];

  void addStoryReply(String storyId, String text) {
    final t = text.trim();
    if (t.isEmpty) return;
    storyReplies.putIfAbsent(storyId, () => []);
    storyReplies[storyId]!.add(t);
    notifyListeners();
  }

  Future<void> openStoryReplySheet(BuildContext context, Story story) async {
    final controller = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Reply to @${story.user.username}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const Divider(height: 20),

                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: getStoryReplies(story.id).length,
                    separatorBuilder: (_, __) => const Divider(height: 10),
                    itemBuilder: (_, i) => Text(getStoryReplies(story.id)[i]),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: 'Type a reply...',
                            filled: true,
                            fillColor: Colors.white10,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          addStoryReply(story.id, controller.text);
                          controller.clear();
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------- Create ----------
  void openCreateSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Create', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.grid_on),
                title: const Text('Post'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Создание поста (заглушка)')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text('Story'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Создание сторис (заглушка)')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
