import 'package:flutter/material.dart';
import 'package:mo_web_test/screens/my_home_page.dart';
import 'package:provider/provider.dart';
import 'package:mo_web_test/providers/scroll_status_notifier.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // root 위젯
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider.value(  // Provider를 사용하여 scrollStatusNotifier를 전역적으로 제공
          value: scrollStatusNotifier,
          child: const MyHomePage(title: 'Mofin Website Demo Page')),
    );
  }
}