import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'reels_viewmodel.dart';

class ReelsView extends StatelessWidget {
  const ReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReelsViewModel(),
      child: const _ReelsBody(),
    );
  }
}

class _ReelsBody extends StatelessWidget {
  const _ReelsBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ReelsViewModel>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, page) {
          final index = vm.realIndex(page);

          return Stack(
            children: [
              /// BACKGROUND
              Positioned.fill(
                child: Image.network(
                  vm.images[index],
                  fit: BoxFit.cover,
                ),
              ),

              /// TOP BAR
              Positioned(
                top: 40,
                left: 16,
                right: 16,
                child: Row(
                  children: const [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      'Reels',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.keyboard_arrow_down,
                        color: Colors.white),
                    SizedBox(width: 16),
                    Text(
                      'Friends',
                      style: TextStyle(color: Colors.white54),
                    ),
                    Spacer(),
                    Icon(Icons.favorite_border,
                        color: Colors.white),
                    SizedBox(width: 16),
                    Icon(Icons.tune, color: Colors.white),
                  ],
                ),
              ),

              /// RIGHT ACTIONS (НИЗ)
              Positioned(
                right: 12,
                bottom: 120,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage:
                          NetworkImage(vm.images[index]),
                    ),
                    const SizedBox(height: 16),

                    IconButton(
                      icon: Icon(
                        vm.liked[index] == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: vm.liked[index] == true
                            ? Colors.red
                            : Colors.white,
                        size: 32,
                      ),
                      onPressed: () => vm.toggleLike(page),
                    ),
                    Text(
                      '${vm.likes[index] ?? 12000}',
                      style:
                          const TextStyle(color: Colors.white),
                    ),

                    const SizedBox(height: 18),
                    IconButton(
                      icon: const Icon(Icons.comment,
                          color: Colors.white, size: 30),
                      onPressed: () =>
                          _openComments(context, vm, page),
                    ),
                    Text(
                      '${vm.getComments(page).length}',
                      style:
                          const TextStyle(color: Colors.white),
                    ),

                    const SizedBox(height: 18),
                    const Icon(Icons.send,
                        color: Colors.white, size: 28),
                    const SizedBox(height: 18),
                    const Icon(Icons.more_vert,
                        color: Colors.white),
                  ],
                ),
              ),

              /// USERNAME + DESCRIPTION (СТРОГО ВНИЗУ)
              Positioned(
                left: 16,
                right: 90,
                bottom: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '@tadclover_jax',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'This is a breaking bad reference',
                      style:
                          TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static void _openComments(
  BuildContext context,
  ReelsViewModel vm,
  int page,
) {
  final controller = TextEditingController();

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.black,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      final height = MediaQuery.of(context).size.height * 0.6;

      return SizedBox(
        height: height,
        child: Column(
          children: [
            /// drag indicator
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: 40,
                height: 4,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
              ),
            ),

            /// comments list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: vm
                    .getComments(page)
                    .map(
                      (c) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          c,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            /// input
            Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Add a comment',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        vm.addComment(page, controller.text);
                        controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
}
