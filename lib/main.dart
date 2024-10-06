import 'package:diente_admin/presentation/screens/home.dart';
import 'package:diente_admin/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        ScreenUtil.init(context, designSize: const Size(1920, 1280));
        return AdminHomeScreen();
      },
      theme: lightMode,
    );
  }
}
