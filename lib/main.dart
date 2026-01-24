// lib/main.dart

import 'package:flutter/material.dart';
import 'package:untitled/ui/views/home/home_view.dart';
// 1. Импортируйте ваш экран профиля
import 'package:untitled/ui/views/profile/profile_insta.dart'; // <-- Замените 'untitled' на имя вашего проекта, если оно другое

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // 2. Укажите ProfilePage как главный экран
      home: const HomeView(),
    );
  }
}
