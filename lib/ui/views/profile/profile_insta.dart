// lib/ui/views/profile/profile_insta.dart

// Удалите 'main()' и 'MyApp' отсюда. Оставьте только нужные импорты и виджеты.
import 'package:flutter/material.dart';

// ================== ProfilePage ==================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ... весь ваш код для ProfilePage, ProfileInfo и т.д. остается здесь без изменений
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('banan_fixedgear'),
          backgroundColor: Colors.black,
          elevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.add_box_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          ],
        ),
        body: Column(
          children: [
            const ProfileInfo(),
            const TabRow(), // Строка Публикации | Reels | Отметки
            Expanded(
              child: TabBarView(
                children: const [
                  PostsGrid(), // Публикации
                  ReelsGrid(), // Reels
                  TaggedGrid(), // Отметки
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.send), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
            BottomNavigationBarItem(icon: CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3')), label: ''),
          ],
        ),
      ),
    );
  }
}


// ================== ProfileInfo ==================
class ProfileInfo extends StatelessWidget {
  // ... ваш код
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Icon(Icons.add, size: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Column(
                      children: [
                        Text('1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text('Публикации'),
                      ],
                    ),
                    Column(
                      children: [
                        Text('34', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text('Подписчики'),
                      ],
                    ),
                    Column(
                      children: [
                        Text('46', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text('Подписки'),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          const Text('...'),
          const SizedBox(height: 4),
          const Text(
            'https://youtu.be/dQw4w9WgXcQ',
            style: TextStyle(color: Colors.blue),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Редактировать'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Поделиться профилем'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

// ... и остальные ваши виджеты (TabRow, PostsGrid и т.д.)
// ================== Строка вкладок ==================
class TabRow extends StatelessWidget {
  const TabRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      indicatorColor: Colors.white,
      tabs: [
        Tab(text: 'Публикации'),
        Tab(text: 'Reels'),
        Tab(text: 'Отметки'),
      ],
    );
  }
}

// ================== Сетки ==================
class PostsGrid extends StatelessWidget {
  const PostsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Image.network(
          'https://picsum.photos/200?random=${index + 1}',
          fit: BoxFit.cover,
        );
      },
    );
  }
}

class ReelsGrid extends StatelessWidget {
  const ReelsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Image.network(
          'https://picsum.photos/201?random=${index + 1}',
          fit: BoxFit.cover,
        );
      },
    );
  }
}

class TaggedGrid extends StatelessWidget {
  const TaggedGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Image.network(
          'https://picsum.photos/202?random=${index + 1}',
          fit: BoxFit.cover,
        );
      },
    );
  }
}
