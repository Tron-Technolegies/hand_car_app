import 'package:flutter/material.dart';
import 'package:hand_car/core/router/bottom_navigation_bar_routing.dart';
import 'package:hand_car/core/theme/light_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp( const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static final navigatorkey = GlobalKey<NavigatorState>();
  
   const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hand Car',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      scaffoldMessengerKey: scaffoldMessengerKey,
      routerConfig: router,
      

    );
  }
}
