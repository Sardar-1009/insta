import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../shared/widgets/profile_header.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onViewModelReady: (vm) => vm.init(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(vm.me?.username ?? 'Profile'),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.add_box_outlined)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            ],
          ),
          body: vm.isBusy
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
            onRefresh: vm.refresh,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: ProfileHeader(
                    user: vm.me!,
                    posts: vm.myPosts.length,
                    followers: 1280,
                    following: 210,
                    onEdit: vm.editProfile,
                    onAddPerson: vm.addPerson,
                  ),
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, i) => CachedNetworkImage(
                      imageUrl: vm.myPosts[i],
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: Colors.white10),
                      errorWidget: (_, __, ___) => Container(
                        color: Colors.white10,
                        child: const Icon(Icons.broken_image, color: Colors.white54),
                      ),
                    ),
                    childCount: vm.myPosts.length,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
              ],
            ),
          ),
        );
      },
    );
  }
}
