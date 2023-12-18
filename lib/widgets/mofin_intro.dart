import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scroll_status_notifier.dart';

class MofinIntroduction extends StatelessWidget {
  final Size size;

  const MofinIntroduction({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScrollStatusNotifier>(
      builder: (context, scrollStatus, child) {
        double animationStartValue = 0.7;
        double animationEndValue = 2.1;

        if (scrollStatus.scrollPercentage > animationStartValue && scrollStatus.scrollPercentage < animationEndValue) {
          double animationValue = (scrollStatus.scrollPercentage - animationStartValue) / (animationEndValue - animationStartValue);
          return _buildAnimatedIntro(context, animationValue);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildAnimatedIntro(BuildContext context, double animationValue) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAnimatedText(
            '금융에 혁신을 더하다',
            animationValue,
            false,
          ),
          _buildAnimatedText(
            '주식회사 모핀은 핀테크 플랫폼 구축 경험과 API 연계 기술로 공공 및 금융기관의 데이터를 제공받아 이를 수집, 빅데이터 분석, 가공하는 축적된 기술력을 바탕으로 개인투자자 및 기관 투자자 모두에게 편익을 제공하는 금융투자 서비스 기업입니다',
            animationValue,
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedText(String text, double animationValue, bool isLeftToRight) {
    return Expanded(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(isLeftToRight ? 50 * (1 - value) : -50 * (1 - value), 0),
              child: Text(
                text,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}
