import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}
