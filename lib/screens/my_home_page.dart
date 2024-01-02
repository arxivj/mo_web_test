import 'package:flutter/material.dart';
import 'package:mo_web_test/utils/animation_calculator.dart';
import 'package:mo_web_test/widgets/mofin_intro.dart';

import '../providers/scroll_status_notifier.dart';
import '../widgets/rotate_circle.dart';
import '../widgets/service_intro.dart';
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

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;


// 위젯 초기화
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      // 스크롤 위치 변경에 따라 배경색 변경
      scrollStatusNotifier.setScrollPos(_scrollController.position.pixels);
      print(" pixel :  ${_scrollController.position.pixels}");
      print(" offset :  : ${_scrollController.offset}");
      print(" max :  : ${_scrollController.position.maxScrollExtent}");
      print(" min :  : ${_scrollController.position.minScrollExtent}");
      print(" Viewport Dimension :  : ${_scrollController.position.viewportDimension}");
      print(" 현재 스크롤 비율 : ${scrollStatusNotifier.scrollPercentage * 100}");
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
        scrollStatusNotifier.scrollPercentage > 2.1) {
      backgroundColor = const Color(0xFFF7F7F7);
      setState(() {});
    } else if (backgroundColor == const Color(0xFFF7F7F7) &&
        scrollStatusNotifier.scrollPercentage < 2.1) {
      backgroundColor = Colors.white;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, constraints) {
        _size = MediaQuery.of(context).size; // 현재 화면 크기를 가져옴
        print("현재 화면의 크기 : ${_size}");
        scrollStatusNotifier.size = _size!;
        // scrollHeight = _size!.height * 5;
        scrollHeight = _size!.height * 7.3; // 스크롤 높이 설정
        return Scaffold(
          backgroundColor: backgroundColor,
          floatingActionButton: scrolling
              ? null
              : FloatingActionButton.small(
            onPressed: () {
              setState(() {
                scrolling = true;
              });
              animateToEnd().then((value) => goBackToTop().then((value) {
                setState(() {
                  scrolling = false;
                });
              }));
            },
            child: const Icon(Icons.play_arrow),
          ),
          body: Center(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 추가할 위젯들
                AnimatedBackgroundTitle(size: _size!),
                ServiceIntroduction(size: _size!),
                SingleChildScrollView(child: MofinIntroduction(size: _size!)),
                // RotateCircle(size: _size!),
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
        );
      },
    );
  }



  // 스크롤을 끝까지 이동시키는 애니메이션
  Future<void> animateToEnd() {
    final leftScroll = scrollHeight! - scrollStatusNotifier.scrollPos;
    double seconds = leftScroll / scrollHeight! * 7;
    if (seconds <= 0) {
      seconds = 0.1;
    }
    return _scrollController.animateTo(scrollHeight!,
        duration: Duration(milliseconds: (seconds * 2000).toInt()),
        curve: Curves.linear);
  }

  // 스크롤을 맨 위로 되돌리는 애니메이션
  Future<void> goBackToTop() {
    return _scrollController.animateTo(0,
        duration: const Duration(seconds: 2), curve: Curves.easeInOutCubic);
  }


}
