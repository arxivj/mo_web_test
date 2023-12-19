import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo_web_test/screens/my_home_page.dart';
import 'package:provider/provider.dart';
import 'package:mo_web_test/providers/scroll_status_notifier.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(2560, 1440),
      builder: (_, child) => MaterialApp(
        theme: ThemeData(
          fontFamily: 'Pretendard',
        ),
        home: ChangeNotifierProvider.value(
          value: scrollStatusNotifier,
          child: const MyHomePage(title: 'Mofin Website Demo Page'),
        ),
      ),
    );
  }
}
