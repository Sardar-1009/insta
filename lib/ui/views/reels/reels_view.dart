import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'reels_viewmodel.dart';

class ReelsView extends StatelessWidget {
  const ReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReelsViewModel>.reactive(
      viewModelBuilder: () => ReelsViewModel(),
      onViewModelReady: (vm) => vm.init(),
      builder: (context, vm, _) {
        if (vm.isBusy) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          body: RefreshIndicator(
            onRefresh: vm.refresh,
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: vm.images.length,
              itemBuilder: (context, i) {
                final url = vm.images[i];

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: Colors.white10),
                      errorWidget: (_, __, ___) => Container(
                        color: Colors.white10,
                        child: const Icon(Icons.broken_image, color: Colors.white54),
                      ),
                    ),

                    // затемнение сверху
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 130,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black54, Colors.transparent],
                          ),
                        ),
                      ),
                    ),

                    // заголовок
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Row(
                          children: const [
                            Text('Reels', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                            Spacer(),
                            Icon(Icons.camera_alt_outlined),
                          ],
                        ),
                      ),
                    ),

                    // подпись снизу слева
                    Positioned(
                      left: 12,
                      right: 90,
                      bottom: 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('@salikh', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                          SizedBox(height: 6),
                          Text(
                            'Reels images only — подпись/описание здесь',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // кнопки справа
                    Positioned(
                      right: 10,
                      bottom: 30,
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () => vm.like(i),
                            icon: const Icon(Icons.favorite_border, size: 30),
                          ),
                          const Text('1.2k', style: TextStyle(fontSize: 12)),
                          const SizedBox(height: 14),
                          IconButton(
                            onPressed: () => vm.comment(i),
                            icon: const Icon(Icons.chat_bubble_outline, size: 28),
                          ),
                          const Text('245', style: TextStyle(fontSize: 12)),
                          const SizedBox(height: 14),
                          IconButton(
                            onPressed: () => vm.share(i),
                            icon: const Icon(Icons.send_outlined, size: 28),
                          ),
                          const SizedBox(height: 14),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz, size: 28),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
