import 'package:flutter/material.dart';
void main() {
  runApp(const InstagramDMApp());
}
class InstagramDMApp extends StatelessWidget {
  const InstagramDMApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const ChatsScreen(),
    );
  }
}
/* ---------- COMMON LAYOUT ---------- */
class AppLayout extends StatelessWidget {
  final Widget child;
  const AppLayout({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: child,
      ),
    );
  }
}
/* ---------- CHATS SCREEN (ИЗ 1 КОДА) ---------- */
class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                '_rakhima_007_',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 6),
              CircleAvatar(radius: 4, backgroundColor: Colors.red),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: const [
            SearchField(),
            StoriesRow(),
            MessagesHeader(),
            Expanded(child: ChatsList()),
          ],
        ),
      ),
    );
  }
}
/* ---------- SEARCH ---------- */
class SearchField extends StatelessWidget {
  const SearchField({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Выполните поиск или спросите Meta…',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
/* ---------- STORIES ---------- */
class StoriesRow extends StatelessWidget {
  const StoriesRow({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _story(
            'Ваша заметка',
            'https://i.pinimg.com/736x/b6/d8/2a/b6d82a7581590ea7b593431372ff5212.jpg',
          ),
          _story('Камила', null),
          _story('Карта', null),
          _story('idyzo', null),
        ],
      ),
    );
  }
  Widget _story(String title, String? avatarUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey,
            backgroundImage:
            avatarUrl != null ? NetworkImage(avatarUrl) : null,
          ),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
/* ---------- HEADER ---------- */
class MessagesHeader extends StatelessWidget {
  const MessagesHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Сообщения',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            'Запросы',
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
/* ---------- CHAT LIST ---------- */
class ChatsList extends StatelessWidget {
  const ChatsList({super.key});
  @override
  Widget build(BuildContext context) {
    final chats = List.generate(
      10,
          (index) => Chat(
        name: 'user_${index + 1}',
        subtitle: 'Последнее сообщение',
        avatarUrl:
        'https://i.pinimg.com/736x/b6/d8/2a/b6d82a7581590ea7b593431372ff5212.jpg',
      ),
    );
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(chat.avatarUrl),
          ),
          title: Text(chat.name),
          subtitle: Text(chat.subtitle),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatDetailScreen(chat: chat),
              ),
            );
          },
        );
      },
    );
  }
}
/* ---------- CHAT DETAIL SCREEN (ИЗ 2 КОДА) ---------- */
class ChatDetailScreen extends StatelessWidget {
  final Chat chat;
  const ChatDetailScreen({super.key, required this.chat});
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.5,
          title: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(chat.avatarUrl),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chat.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Text(
                    'Бизнес-чат',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          actions: const [
            Icon(Icons.call_outlined),
            SizedBox(width: 12),
            Icon(Icons.videocam_outlined),
            SizedBox(width: 12),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 24),
/* ---------- PROFILE BLOCK ---------- */
            Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage(chat.avatarUrl),
                ),
                const SizedBox(height: 12),
                Text(
                  chat.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  '1 подписчик · 1 публикация',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Вы подписаны друг на друга в Instagram',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Посмотреть профиль',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const MessageInputField(),
          ],
        ),
      ),
    );
  }
}
/* ---------- MESSAGE INPUT ---------- */
class MessageInputField extends StatelessWidget {
  const MessageInputField({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Row(
          children: [
            Icon(Icons.camera_alt, color: Colors.blue),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Сообщение...',
                  border: InputBorder.none,
                ),
              ),
            ),
            Icon(Icons.mic),
            SizedBox(width: 8),
            Icon(Icons.image),
            SizedBox(width: 8),
            Icon(Icons.emoji_emotions_outlined),
            SizedBox(width: 8),
            Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}
/* ---------- MODEL ---------- */
class Chat {
  final String name;
  final String subtitle;
  final String avatarUrl;
  Chat({
    required this.name,
    required this.subtitle,
    required this.avatarUrl,
  });
}