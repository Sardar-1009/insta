import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../../core/models/post.dart';
import 'avatar.dart';

class PostCard extends StatelessWidget {
  final Post post;

  // ✅ добавь поля
  final bool isLiked;
  final bool isSaved;

  // ✅ добавь коллбеки
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback onSave;

  const PostCard({
    super.key,
    required this.post,
    required this.isLiked,
    required this.isSaved,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM, HH:mm').format(post.createdAt);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Avatar(url: post.user.avatarUrl, size: 36),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  post.user.username,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),

        // image
        AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: post.imageUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: Colors.white10),
            errorWidget: (_, __, ___) => Container(
              color: Colors.white10,
              child: const Icon(Icons.broken_image, color: Colors.white54),
            ),
          ),
        ),

        // actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              IconButton(
                onPressed: onLike,
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : null,
                ),
              ),
              IconButton(
                onPressed: onComment,
                icon: const Icon(Icons.chat_bubble_outline),
              ),
              IconButton(
                onPressed: onShare,
                icon: const Icon(Icons.send_outlined),
              ),
              const Spacer(),
              IconButton(
                onPressed: onSave,
                icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
              ),
            ],
          ),
        ),

        // meta
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '${post.likes + (isLiked ? 1 : 0)} likes',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: post.user.username,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const TextSpan(text: '  '),
                TextSpan(text: post.caption),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            date,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ),

        const Divider(height: 1),
      ],
    );
  }
}
