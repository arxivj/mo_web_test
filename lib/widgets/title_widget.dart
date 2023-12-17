import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../providers/scroll_status_notifier.dart';
import '../utils/animation_calculator.dart';
import '../screens/my_home_page.dart';
import '../providers/scroll_status_notifier.dart';



// 스크롤 상태에 따라 변경되는 타이틀 위젯
Consumer<ScrollStatusNotifier> buildTitle(Size size) {
  return Consumer<ScrollStatusNotifier>(
    builder: (context, ssn, child) {
      final portionValue = AnimationCalculator.linearInterpolateToZeroOne(
          scrollPercentage: ssn.scrollPercentage, start: 0, end: 0.45);

      final opacity = -pow(portionValue, 6) + 1; // 투명도 계산
      return Transform.translate(
          offset:
          Offset(0, -ssn.scrollPos + ssn.scrollPos * 0.3 * portionValue),
          child: Center(
            child: Opacity(
                opacity: opacity.toDouble(),
                child: SizedBox(
                  width: size.width,
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: size.width * 0.2),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Column(
                        children: [
                          GradientText(
                            // 그라데이션 텍스트
                            'We are rooting for your',
                            colors: const [
                              Color(0xff4ea0b4),
                              Color(0xff6994e3),
                              Color(0xff9283eb),
                              Color(0xffe668a5),
                              Color(0xffdd514a),
                            ],
                            style: const TextStyle(
                                fontSize: 96,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SFPro',
                                color: Colors.black),
                            maxLines: 1,
                          ),
                          GradientText(
                            // 그라데이션 텍스트
                            'better tomorrow',
                            colors: const [
                              Color(0xffb1f560),
                              Color(0xffb1f560),
                            ],
                            style: const TextStyle(
                                fontSize: 96,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SFPro',
                                color: Colors.black),
                            maxLines: 1,
                          ),
                          const Text("우리는 당신의 더 나은 내일을 응원합니다.",style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -1.44
                          ),),
                          const Text(" 혁신을 더한 금융투자 플랫폼 mofin입니다.",style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -1.44
                          ),),
                        ],
                      ),
                    ),
                  ),
                )),
          ));
    },
  );
}
