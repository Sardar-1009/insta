import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const InstagramCloneApp());
}
