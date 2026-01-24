import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/models/message_thread.dart';
import 'avatar.dart';

class ThreadTile extends StatelessWidget {
  final MessageThread thread;
  final VoidCallback? onTap;

  const ThreadTile({
    super.key,
    required this.thread,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('HH:mm').format(thread.updatedAt);

    return ListTile(
      leading: Avatar(url: thread.peer.avatarUrl, size: 44),
      title: Text(
        thread.peer.username,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        thread.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.white54)),
          const SizedBox(height: 6),
          if (thread.unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '${thread.unreadCount}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ),
        ],
      ),
      onTap: onTap,
    );
  }
}
