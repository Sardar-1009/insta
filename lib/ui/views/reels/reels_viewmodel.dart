import 'package:flutter/material.dart';

class ReelsViewModel extends ChangeNotifier {
  final List<String> images = [
    'https://picsum.photos/800/1400?1',
    'https://picsum.photos/800/1400?2',
    'https://picsum.photos/800/1400?3',
    'https://picsum.photos/800/1400?4',
    'https://picsum.photos/800/1400?5',
    'https://picsum.photos/800/1400?6',
    'https://picsum.photos/800/1400?7',
  ];

  final Map<int, bool> liked = {};
  final Map<int, int> likes = {};
  final Map<int, List<String>> comments = {};

  int realIndex(int page) => page % images.length;

  void toggleLike(int page) {
    final i = realIndex(page);
    liked[i] = !(liked[i] ?? false);
    likes[i] = (likes[i] ?? 12000) + (liked[i]! ? 1 : -1);
    notifyListeners();
  }

  List<String> getComments(int page) {
    return comments[realIndex(page)] ?? [];
  }

  void addComment(int page, String text) {
    final i = realIndex(page);
    comments.putIfAbsent(i, () => []);
    comments[i]!.add(text);
    notifyListeners();
  }
}
