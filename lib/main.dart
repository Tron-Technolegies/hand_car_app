import 'package:flutter/material.dart';
import 'package:hand_car/core/theme/light_theme.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hand Car',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: const NavigationPage(),
    );
  }
}
