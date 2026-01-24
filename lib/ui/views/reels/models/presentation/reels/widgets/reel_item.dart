import 'package:flutter/material.dart';
import '../../../data/models/reel_model.dart';

class ReelItem extends StatefulWidget {
  final ReelModel reel;

  const ReelItem({super.key, required this.reel});

  @override
  State<ReelItem> createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Фон
        Positioned.fill(
          child: Image.network(
            widget.reel.imageUrl,
            fit: BoxFit.cover,
          ),
        ),

        // 🔝 Верхняя панель (Reels / Friends)
        Positioned(
          top: 40,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: 12),
                  Text(
                    'Reels',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white),
                ],
              ),
              Row(
                children: const [
                  Icon(Icons.people_outline, color: Colors.white),
                  SizedBox(width: 16),
                  Icon(Icons.tune, color: Colors.white),
                ],
              ),
            ],
          ),
        ),

        // ❤️ Правая колонка иконок
        Positioned(
          right: 12,
          bottom: 80,
          child: Column(
            children: [
              // Лайк
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.white,
                      size: 28,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.reel.likes.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Комментарии
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.black,
                    isScrollControlled: true,
                    builder: (_) => const _CommentsSheet(),
                  );
                },
                child: _icon(
                  Icons.mode_comment_outlined,
                  widget.reel.comments.toString(),
                ),
              ),

              const SizedBox(height: 20),
              _icon(Icons.send, ''),
              const SizedBox(height: 20),
              _icon(Icons.more_vert, ''),
            ],
          ),
        ),

        // 👤 Инфо снизу
        Positioned(
          left: 12,
          bottom: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '@${widget.reel.username}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.reel.description,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _icon(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        if (text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

// 💬 BottomSheet комментариев
class _CommentsSheet extends StatelessWidget {
  const _CommentsSheet();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Comments',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const Divider(color: Colors.white24),
          const Expanded(
            child: Center(
              child: Text(
                'No comments yet',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
