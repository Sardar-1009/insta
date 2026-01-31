import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/models/story.dart';
import '../../shared/widgets/avatar.dart'; // ✅ правильный путь

class StoryViewerView extends StatefulWidget {
  final List<Story> stories;
  final int initialIndex;
  final void Function(Story story) onViewed;
  final void Function(Story story) onReply;

  const StoryViewerView({
    super.key,
    required this.stories,
    required this.initialIndex,
    required this.onViewed,
    required this.onReply,
  });

  @override
  State<StoryViewerView> createState() => _StoryViewerViewState();
}

class _StoryViewerViewState extends State<StoryViewerView> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onViewed(widget.stories[widget.initialIndex]);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.stories.length,
        onPageChanged: (i) => widget.onViewed(widget.stories[i]),
        itemBuilder: (context, i) {
          final s = widget.stories[i];

          return Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: s.mediaUrl,
                fit: BoxFit.cover,
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Align(
                    alignment:Alignment.topLeft,
                    child:Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close),
                        ),
                        const SizedBox(width: 8),
                        Avatar(url: s.user.avatarUrl, size: 32),
                        const SizedBox(width: 8),
                        Text(
                          s.user.username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ),
              ),

              Positioned(
                left: 12,
                right: 12,
                bottom: 20,
                child: InkWell(
                  onTap: () => widget.onReply(s),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text('Reply...', style: TextStyle(color: Colors.white70)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
