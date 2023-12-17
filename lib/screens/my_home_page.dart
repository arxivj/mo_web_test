import 'package:flutter/material.dart';
import 'package:mo_web_test/utils/animation_calculator.dart';

import '../providers/scroll_status_notifier.dart';
import '../widgets/title_widget.dart';

// 상태를 가진 위젯, 애플리케이션의 메인 페이지
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // 상태 객체 생성
}

class _MyHomePageState extends State<MyHomePage> {
  // MyHomePage의 상태를 관리하는 클래스

  late final ScrollController _scrollController;
  Size? _size;
  double? scrollHeight;
  bool scrolling = false;
  Color backgroundColor = Colors.white;
  bool fadeIn = false;

// 위젯 초기화
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      // 스크롤 위치 변경에 따라 배경색 변경
      scrollStatusNotifier.setScrollPos(_scrollController.offset);
      changeBackgroundColor();
    });
    // 초기 페이드 인 애니메이션 지연 실행
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      setState(() {
        fadeIn = true;
      });
    });
    super.initState();
  }

// 배경색을 스크롤 위치에 따라 변경하는 함수
  void changeBackgroundColor() {
    if (backgroundColor == Colors.white &&
        scrollStatusNotifier.scrollPercentage > 6.3) {
      backgroundColor = Colors.black;
      setState(() {});
    } else if (backgroundColor == Colors.black &&
        scrollStatusNotifier.scrollPercentage < 6.1) {
      backgroundColor = Colors.white;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, constraints) {
        _size = MediaQuery.of(context).size; // 현재 화면 크기를 가져옴
        scrollStatusNotifier.size = _size!;
        // scrollHeight = _size!.height * 5;
        scrollHeight = _size!.height * 7.3; // 스크롤 높이 설정
        return Scaffold(
          backgroundColor: backgroundColor,
          body: AnimatedOpacity(
            opacity: fadeIn ? 1 : 0, // 페이드 인 애니메이션 적용
            duration: const Duration(seconds: 1),
            child: Center(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // 추가할 위젯들
                  buildTitle(_size!),
                  SingleChildScrollView(
                    controller: _scrollController, // 스크롤 컨트롤러 적용
                    physics:
                        fadeIn ? null : const NeverScrollableScrollPhysics(),
                    child: SizedBox(
                      height: scrollHeight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
