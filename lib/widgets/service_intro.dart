import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../providers/scroll_status_notifier.dart';
import '../utils/animation_calculator.dart';

class ServiceIntroduction extends StatefulWidget {
  const ServiceIntroduction({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<ServiceIntroduction> createState() => _WonderfulTextAnimState();
}

class _WonderfulTextAnimState extends State<ServiceIntroduction> {
  late final double shortLenth;
  static const double wonderfulTxtTransLenth = 0.45;
  double? startScrollPos;

  @override
  void initState() {
    shortLenth = (widget.size.width > widget.size.height)
        ? widget.size.height
        : widget.size.width;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ssn = Provider.of<ScrollStatusNotifier>(context);
    if (ssn.scrollPercentage > 2 && ssn.scrollPercentage < 10) {
      final minusOneToZeroToOne =
          AnimationCalculator.linearInterpolateToMinusOneOne(
              scrollPercentage: ssn.scrollPercentage, start: 2.2, end: 3.2);
      final double perspectiveValue = getPerspectiveValue(minusOneToZeroToOne);
      final double scaleValue = getScaleValue(minusOneToZeroToOne);
      final double yOffsetValue = getYTranslateValue(minusOneToZeroToOne);

      if (ssn.scrollPercentage > 3.3) {
        startScrollPos ??= ssn.scrollPos;
      } else {
        startScrollPos = null;
      }

      return LayoutBuilder(
        builder: (BuildContext, BoxConstraints) {
          return Opacity(
            opacity: AnimationCalculator.linearInterpolateToZeroOne(
                scrollPercentage: ssn.scrollPercentage, start: 2.18, end: 2.2),
            child: Transform.translate(
              offset: Offset(0,
                  startScrollPos != null ? startScrollPos! - ssn.scrollPos : 0),
              child: Container(
                alignment: Alignment.center,
                height: shortLenth,
                width: shortLenth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildBringBringTxt(ssn),
                    _buildWonderfulTxt(
                        perspectiveValue, scaleValue, yOffsetValue),
                    _buildPriceTxt(ssn),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  Opacity _buildPriceTxt(ScrollStatusNotifier ssn) {
    return Opacity(
      opacity: pow(
              AnimationCalculator.linearInterpolateToZeroOne(
                  scrollPercentage: ssn.scrollPercentage, start: 3.0, end: 3.3),
              2)
          .toDouble(),
      child: Transform.translate(
        offset: Offset(0, shortLenth * 0.2 - 250),
        child: SizedBox(
          width: shortLenth,
          child: const Text(
            '국내·외 주식 개인 투자자 고객을 위한 실시간 시세 호가 데이터 활용한 AI(강화학습) 기반 글로벌 주식 큐레이션 및 자동매매 플랫폼입니다',
            maxLines: 2,
            style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.44,
                fontStyle: FontStyle.normal),
          ),
        ),
      ),
    );
  }

  Transform _buildWonderfulTxt(
      double perspectiveValue, double scaleValue, double yOffsetValue) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // perspective
        ..rotateX(-0.01 * perspectiveValue)
        ..scale(scaleValue, scaleValue)
        ..translate(0, yOffsetValue),
      alignment: FractionalOffset.center,
      child: SizedBox(
        width: shortLenth,
        child: const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'QUANTMO.AI.',
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }

  Opacity _buildBringBringTxt(ScrollStatusNotifier ssn) {
    return Opacity(
      opacity: pow(
              AnimationCalculator.linearInterpolateToZeroOne(
                  scrollPercentage: ssn.scrollPercentage, start: 3.0, end: .3),
              2)
          .toDouble(),
      child: Transform.translate(
        offset: Offset(0, -shortLenth * 0.2 + 200 ),
        child: SizedBox(
          width: shortLenth * 0.2,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: GradientText(
              '서비스 소개',
              maxLines: 1,
              style: const TextStyle(
                fontSize: 46,
                fontWeight: FontWeight.w500,
              ),
              colors: const [
                Color(0xffe668a5),
                Color(0xffdd514a),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double getPerspectiveValue(double minusOneToZeroToOne) {
    final y = pow(minusOneToZeroToOne, 3);
    final animValue = yToPerspectiveValue(y);
    return animValue;
  }

  double getYTranslateValue(double minusOneToZeroToOne) {
    final y = pow(minusOneToZeroToOne, 5);
    final animValue =
        yToYTranslateValue(y) * shortLenth * wonderfulTxtTransLenth;
    const additionalOffset = 350.0;
    return animValue + additionalOffset;
  }

  double getScaleValue(double minusOneToZeroToOne) {
    Curves.decelerate;
    final y = -pow(minusOneToZeroToOne, 4);
    final animValue = yToScaleValue(y);
    return animValue;
  }

  double yToPerspectiveValue(num y) {
    return 78.5 * y - 78.5;
  }

  double yToScaleValue(num y) {
    return 0.4 * y + 1;
  }

  double yToYTranslateValue(num y) {
    return -0.5 * y - 0.5;
  }
}
