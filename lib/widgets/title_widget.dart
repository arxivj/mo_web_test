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
      // ssn은 Scroll Status Notifier
      final portionValue = AnimationCalculator.linearInterpolateToZeroOne(
          scrollPercentage: ssn.scrollPercentage, start: 0, end: 1);

      final opacity = -pow(portionValue, 6) + 1; // 투명도 계산
      return Transform.translate(
          offset:
              Offset(0, -ssn.scrollPos + ssn.scrollPos * 0.3 * portionValue),
          child: Center(
            child: Opacity(
                opacity: opacity.toDouble(),
                child: SizedBox(
                  width: size.width,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('../assets/images/title_robot.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: size.height,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 4), // Shadow position
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GradientText(
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
                                  color: Colors.black),
                              maxLines: 1,
                            ),
                            GradientText(
                              'better tomorrow',
                              colors: const [
                                Color(0xffb1f560),
                                Color(0xffb1f560),
                              ],
                              style: const TextStyle(
                                  fontSize: 96,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              maxLines: 1,
                            ),
                            const Text(
                              "우리는 당신의 더 나은 내일을 응원합니다.",
                              style: TextStyle(
                                  fontSize: 48,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -1.44),
                            ),
                            const Text(
                              " 혁신을 더한 금융투자 플랫폼 mofin입니다.",
                              style: TextStyle(
                                  fontSize: 48,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -1.44),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ));
    },
  );
}
