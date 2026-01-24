import 'package:flutter/material.dart';
import '../../../core/models/user.dart';
import 'avatar.dart';

class ProfileHeader extends StatelessWidget {
  final User user;
  final int posts;
  final int followers;
  final int following;

  final VoidCallback? onEdit;
  final VoidCallback? onAddPerson;

  const ProfileHeader({
    super.key,
    required this.user,
    required this.posts,
    required this.followers,
    required this.following,
    this.onEdit,
    this.onAddPerson,
  });

  @override
  Widget build(BuildContext context) {
    Widget stat(String value, String label) {
      return Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Avatar(url: user.avatarUrl, size: 72),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    stat('$posts', 'Posts'),
                    stat('$followers', 'Followers'),
                    stat('$following', 'Following'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(user.username, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onEdit ?? () {},
                  child: const Text('Edit profile'),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: onAddPerson ?? () {},
                child: const Icon(Icons.person_add_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
