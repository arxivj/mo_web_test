import 'package:flutter/material.dart';
import 'package:mo_web_test/utils/animation_calculator.dart';

// 상태를 가진 위젯, 애플리케이션의 메인 페이지
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // 상태 객체 생성
}

class _MyHomePageState extends State<MyHomePage> { // MyHomePage의 상태를 관리하는 클래스

late final ScrollController _scrollController;
Size? _size;
double? scrollHeight;
bool scrolling = false;
Color backgroundColor = Colors.white;
bool fadeIn = false;





  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
