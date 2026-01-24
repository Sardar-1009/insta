import 'package:flutter/material.dart';
import '../ui/views/ shell/shell_view.dart';
import 'theme.dart';


class InstagramCloneApp extends StatelessWidget {
  const InstagramCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const ShellView(),
    );
  }
}
