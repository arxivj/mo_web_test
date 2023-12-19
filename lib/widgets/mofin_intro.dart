import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scroll_status_notifier.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MofinIntroduction extends StatefulWidget {
  final Size size;

  const MofinIntroduction({super.key, required this.size});

  @override
  _MofinIntroductionState createState() => _MofinIntroductionState();
}

class _MofinIntroductionState extends State<MofinIntroduction> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
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
        double animationStartValue = 0.7;
        double animationEndValue = 2.1;

        if (scrollStatus.scrollPercentage > animationStartValue &&
            scrollStatus.scrollPercentage < animationEndValue) {
          double animationValue =
              (scrollStatus.scrollPercentage - animationStartValue) /
                  (animationEndValue - animationStartValue);
          return _buildAnimatedIntro(context, animationValue);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildAnimatedIntro(BuildContext context, double animationValue) {
    double textSize = 40.sp;
    return SizedBox(
      width: widget.size.width,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                _buildAnimatedText(
                    text: '금융에 혁신을 더하다',
                    animationValue: animationValue,
                    isLeftToRight: false,
                    fontSize: 28.sp,
                    color: '000000'),
                _buildAnimatedText(
                    text: 'MOFIN',
                    animationValue: animationValue,
                    isLeftToRight: false,
                    fontSize: 96.sp,
                    color: '000000'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAnimatedText(
                    text: '주식회사 모핀은 핀테크 플랫폼 구축 경험과 API 연계 기술로',
                    animationValue: animationValue,
                    isLeftToRight: true,
                    fontSize: textSize,
                    color: '000000'),
                _buildAnimatedText(
                    text: '공공 및 금융기관의 데이터를 제공받아 이를 수집',
                    animationValue: animationValue,
                    isLeftToRight: true,
                    fontSize: textSize,
                    color: '000000'),
                _buildAnimatedText(
                    text: '빅데이터 분석, 가공하는 축적된 기술력을 바탕으로',
                    animationValue: animationValue,
                    isLeftToRight: true,
                    fontSize: textSize,
                    color: '000000'),
                _buildAnimatedText(
                    text: '개인투자자 및 기관 투자자 모두에게 편익을 제공하는 ',
                    animationValue: animationValue,
                    isLeftToRight: true,
                    fontSize: textSize,
                    color: '000000'),
                _buildAnimatedText(
                    text: '금융투자 서비스 기업',
                    additionalText: '입니다.',
                    animationValue: animationValue,
                    isLeftToRight: true,
                    fontSize: textSize,
                    color: 'AB2C20',
                    additionalColor: '000000'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                _buildAnimatedImage(
                  imagePath: 'assets/images/intro_1.png', // 왼쪽 이미지 경로
                  animationValue: animationValue,
                  isLeftToRight: true,
                ),
                _buildAnimatedImage(
                  imagePath: 'assets/images/intro_2.png', // 오른쪽 이미지 경로
                  animationValue: animationValue,
                  isLeftToRight: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedText(
      {required String text,
      String? additionalText,
      required double animationValue,
      required bool isLeftToRight,
      required double fontSize,
      required String color,
      String? additionalColor}) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: animationValue),
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(
                isLeftToRight ? 640.sp * (1 - value) : -640.sp * (1 - value),
                0),
            child: additionalText == null
                ? Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Color(int.parse("0xff$color")),
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
                          ),
                        ),
                        TextSpan(
                          text: additionalText,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Color(
                                int.parse("0xff${additionalColor ?? color}")),
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
    required bool isLeftToRight,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1.0, end: animationValue),
      duration: const Duration(milliseconds: 500),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 1150.sp * (1 - value)),
            child: Image.asset(imagePath),
          ),
        );
      },
    );
  }
}
