import 'package:flutter/material.dart';
import '../../../core/models/story.dart';
import 'avatar.dart';

class StoryList extends StatelessWidget {
  final List<Story> stories;
  const StoryList({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    if (stories.isEmpty) {
      return const SizedBox(height: 104);
    }

    return SizedBox(
      height: 104,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final s = stories[i];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Avatar(
                url: s.user.avatarUrl,
                size: 62,
                hasRing: !s.isViewed,
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 72,
                child: Text(
                  s.user.username,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
