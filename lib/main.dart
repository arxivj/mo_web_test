import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'my_app.dart';

// App 시작점
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FontLoader('Pretendard').load();
  runApp(const MyApp());
}
