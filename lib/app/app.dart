import 'package:flutter/material.dart';
import 'package:untitled/ui/views/%20shell/shell_view.dart';
import 'theme.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const ShellView(),
    );
  }
}
