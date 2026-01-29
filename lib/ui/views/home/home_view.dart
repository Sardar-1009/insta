import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../shared/widgets/story_list.dart';
import '../../shared/widgets/post_card.dart';
import 'home_viewmodel.dart';

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
              IconButton(onPressed: () {}, icon: const Icon(Icons.add_box_outlined)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline)),
            ],
          ),
          body: vm.isBusy
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
            onRefresh: vm.refresh,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: StoryList(stories: vm.stories),
                ),
                SliverList.builder(
                  itemCount: vm.posts.length,
                  itemBuilder: (_, i) {
                    return PostCard(post: vm.posts[i]);
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
