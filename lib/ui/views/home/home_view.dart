import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../shared/widgets/story_list.dart';
import '../../shared/widgets/post_card.dart';
import 'home_viewmodel.dart';
import 'story_viewer_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (vm) => vm.init(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Instagram',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            actions: [
              IconButton(
                onPressed: () => vm.openCreateSheet(context),
                icon: const Icon(Icons.add_box_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chat_bubble_outline),
              ),
            ],
          ),
          body: vm.isBusy
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
            onRefresh: vm.refresh,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: StoryList(
                    stories: vm.stories,
                    onStoryTap: (story) {
                      final list = vm.stories;
                      final initialIndex = list.indexWhere((s) => s.id == story.id);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => StoryViewerView(
                            stories: list,
                            initialIndex: initialIndex < 0 ? 0 : initialIndex,
                            onViewed: vm.markStoryViewed,
                            onReply: (s) => vm.openStoryReplySheet(context, s),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SliverList.builder(
                  itemCount: vm.posts.length,
                  itemBuilder: (context, i) {
                    final post = vm.posts[i];

                    return GestureDetector(
                      onDoubleTap: () => vm.onDoubleTap(post),
                      child: PostCard(
                        post: post,
                        isLiked: vm.isLiked(post),
                        isSaved: vm.isSaved(post),
                        onLike: () => vm.toggleLike(post),
                        onComment: () => vm.openPostCommentsSheet(context, post),
                        onShare: () => vm.sharePost(context, post),
                        onSave: () => vm.toggleSave(post),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
