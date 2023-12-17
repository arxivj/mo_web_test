import 'dart:ui';
import 'package:flutter/foundation.dart';

// 스크롤 이벤트 관련 상태관리 및 스크롤 위치에 따른 변경사항 알림
class ScrollStatusNotifier extends ChangeNotifier{
  ScrollStatusNotifier();

double _scrollPos = 0;
  double _scrollPercentage = 0;
  Size? _size;

  // getter 메소드
  double get scrollPos => _scrollPos;
  double get scrollPercentage => _scrollPercentage;

  // setter 메소드
  set size(Size sz) => _size ??= sz;

  // 스크롤 위치가 변할 때 호출 -> pos, per 업데이트 후 noti..() 호출을 통해 리스닝하는 위젯들에게 알림
  void setScrollPos(double value) {
    if (_size == null) {
      return;
    }
    _scrollPos = value;
    _scrollPercentage = _scrollPos / _size!.height;
    notifyListeners();
  }

  // percentage를 기반으로 실제 높이(px?)값을 계산
  double percentageToHeight(double percentage) {
    if (_size == null) {
      return 0;
    }
    return percentage * _size!.height;
  }
}

// ScrollStatusNotifier 클래스 인스턴스 생성 후 전역변수로 선언 -> scrollStatusNotifier
final ScrollStatusNotifier scrollStatusNotifier = ScrollStatusNotifier();