import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../home/home_view.dart';
import '../direct/direct_view.dart';
import '../search/search_view.dart';
import '../reels/reels_view.dart';
import '../profile/profile_view.dart';

import 'shell_viewmodel.dart';

class ShellView extends StatelessWidget {
  const ShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShellViewModel>.reactive(
      viewModelBuilder: () => ShellViewModel(),
      builder: (context, vm, _) {
        final pages = <Widget>[
          const HomeView(),
          const DirectView(),
          const SearchView(),
          const ReelsView(),
          const ProfileView(),
        ];

        return Scaffold(
          body: IndexedStack(
            index: vm.index,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: vm.index,
            onTap: vm.setIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.send_outlined),
                label: 'Direct',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.movie_creation_outlined),
                label: 'Reels',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
