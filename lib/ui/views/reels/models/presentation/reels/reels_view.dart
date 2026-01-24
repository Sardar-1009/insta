import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'reels_viewmodel.dart';
import 'widgets/reel_item.dart';

class ReelsView extends StatelessWidget {
  const ReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ReelsViewModel>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: vm.reels.length,
        itemBuilder: (context, index) {
          return ReelItem(reel: vm.reels[index]);
        },
      ),
    );
  }
}
