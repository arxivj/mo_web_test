import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../providers/scroll_status_notifier.dart';
import '../utils/animation_calculator.dart';

class AnimatedBackgroundTitle extends StatefulWidget {
  final Size size;

  const AnimatedBackgroundTitle({Key? key, required this.size}) : super(key: key);

  @override
  AnimatedBackgroundTitleState createState() => AnimatedBackgroundTitleState();
}

class AnimatedBackgroundTitleState extends State<AnimatedBackgroundTitle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _imageIndex = 0;
  final List<String> _images = [
    '../assets/images/title_d.png',
    '../assets/images/title_building.png',
    '../assets/images/title_robot.png',
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Timer.periodic(const Duration(milliseconds: 3000), (Timer t) {
      setState(() {
        _imageIndex = (_imageIndex + 1) % _images.length;
      });
    });

    Provider.of<ScrollStatusNotifier>(context, listen: false).addListener(() {
      var scrollPercentage = Provider.of<ScrollStatusNotifier>(context, listen: false).scrollPercentage;
      _controller.value = scrollPercentage.clamp(0.0, 1.0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double opacity = 1.0 - _animation.value;
        double offset = -50 * _animation.value;

        return Transform.translate(
          offset: Offset(0, offset),
          child: Opacity(
            opacity: opacity,
            child: Center(
              child: SizedBox(
                width: widget.size.width,
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 2000),
                      child: Container(
                        key: ValueKey<String>(_images[_imageIndex]),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(_images[_imageIndex]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: widget.size.height,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4,
                              offset: const Offset(0, 4),
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
                              Colors.white,
                              Colors.white,
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
              ),
            ),
          ),
        );
      },
    );
  }
}
