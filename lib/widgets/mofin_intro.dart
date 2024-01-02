import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scroll_status_notifier.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MofinIntroduction extends StatefulWidget {
  final Size size;

  const MofinIntroduction({super.key, required this.size});

  @override
  MofinIntroductionState createState() => MofinIntroductionState();
}

class MofinIntroductionState extends State<MofinIntroduction> {
  late ScrollController _scrollController;
  double? startScrollPos;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final scrollPercentage =
        Provider.of<ScrollStatusNotifier>(context, listen: false)
            .scrollPercentage;
    if (scrollPercentage > 2.1) {
      startScrollPos ??= _scrollController.position.pixels;
    } else {
      startScrollPos = null;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScrollStatusNotifier>(
      builder: (context, scrollStatus, child) {
        double animationStartValue = 1;
        double animationEndValue = 1.4;

        if (scrollStatus.scrollPercentage >= animationStartValue) {
          double animationValue;
          if (scrollStatus.scrollPercentage < animationEndValue) {
            animationValue =
                (scrollStatus.scrollPercentage - animationStartValue) /
                    (animationEndValue - animationStartValue);
          } else {
            animationValue = 1.0;
          }

          if (scrollStatus.scrollPercentage > 2.1) {
            animationValue = 0;
          }
          return _buildAnimatedIntro(context, animationValue);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildAnimatedIntro(BuildContext context, double animationValue) {
    double textSize = 40.sp;
    return Column(children: [
      const SizedBox(
        height: 160,
      ),
      SizedBox(
        width: widget.size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                _buildAnimatedText(
                    text: '금융에 혁신을 더하다',
                    animationValue: animationValue,
                    isLeftToRight: false,
                    fontSize: 28.sp,
                    color: '000000',
                    fontWeight: FontWeight.w700),
                _buildAnimatedText(
                    text: 'MOFIN',
                    animationValue: animationValue,
                    isLeftToRight: false,
                    fontSize: 96.sp,
                    color: '000000',
                    fontWeight: FontWeight.w800),
              ],
            ),
            const SizedBox(
              width: 80,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAnimatedText(
                    text: '주식회사 모핀은 핀테크 플랫폼 구축 경험과 API 연계 기술로',
                    animationValue: animationValue,
                    isLeftToRight: true,
                    fontSize: textSize,
                    color: '000000',
                    fontWeight: FontWeight.w700),
                _buildAnimatedText(
                    text: '공공 및 금융기관의 데이터를 제공받아 이를 수집',
                    animationValue: animationValue,
                    isLeftToRight: true,
                    fontSize: textSize,
                    color: '000000',
                    fontWeight: FontWeight.w700),
                _buildAnimatedText(
                    text: '빅데이터 분석, 가공하는 축적된 기술력을 바탕으로',
                    animationValue: animationValue,
                    isLeftToRight: true,
                    fontSize: textSize,
                    color: '000000',
                    fontWeight: FontWeight.w700),
                _buildAnimatedText(
                    text: '개인투자자 및 기관 투자자 모두에게 편익을 제공하는 ',
                    animationValue: animationValue,
                    isLeftToRight: true,
                    fontSize: textSize,
                    color: '000000',
                    fontWeight: FontWeight.w700),
                _buildAnimatedText(
                    text: '금융투자 서비스 기업',
                    additionalText: '입니다.',
                    animationValue: animationValue,
                    isLeftToRight: true,
                    fontSize: textSize,
                    color: 'AB2C20',
                    additionalColor: '000000',
                    fontWeight: FontWeight.w700),
              ],
            ),
          ],
        ),
      ),
      Stack(
        children: [
          SizedBox(
            width: 730.w,
            height: 530.h,
            child: _buildAnimatedImage(
              imagePath: 'assets/images/intro_1.png',
              animationValue: animationValue,
              startAnimationValue: 0.2,
              endAnimationValue: 0.8,
            ),
          ),
          SizedBox(
            width: 730.w,
            height: 530.h,
            child: _buildAnimatedImage(
              imagePath: 'assets/images/intro_2.png',
              animationValue: animationValue,
              startAnimationValue: 0.5,
              endAnimationValue: 1.0,
            ),
          ),
        ],
      ),
    ]);
  }

  Widget _buildAnimatedText({
    required String text,
    String? additionalText,
    required double animationValue,
    required bool isLeftToRight,
    required double fontSize,
    required String color,
    String? additionalColor,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    double offsetValue = startScrollPos != null
        ? _scrollController.position.pixels - startScrollPos!
        : 0;

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: animationValue),
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(
                isLeftToRight
                    ? 100.sp * (1 - value) - offsetValue
                    : -100.sp * (1 - value) - offsetValue,
                0),
            child: additionalText == null
                ? Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Color(int.parse("0xff$color")),
                      fontWeight: fontWeight,
                    ),
                  )
                : RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: text,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Color(int.parse("0xff$color")),
                            fontWeight: fontWeight,
                          ),
                        ),
                        TextSpan(
                          text: additionalText,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Color(
                                int.parse("0xff${additionalColor ?? color}")),
                            fontWeight: fontWeight,
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

  Widget _buildAnimatedImage({
    required String imagePath,
    required double animationValue,
    required double startAnimationValue,
    required double endAnimationValue,
  }) {
    double adjustedAnimationValue;
    if (animationValue < startAnimationValue) {
      adjustedAnimationValue = 0.0;
    } else if (animationValue > endAnimationValue) {
      adjustedAnimationValue = 1.0;
    } else {
      adjustedAnimationValue = (animationValue - startAnimationValue) /
          (endAnimationValue - startAnimationValue);
    }

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: adjustedAnimationValue),
      duration: const Duration(milliseconds: 500),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 400.sp * (1 - value)),
            child: Image.asset(imagePath),
          ),
        );
      },
    );
  }

}
