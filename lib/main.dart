import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/router/router.dart';
import 'package:hand_car/core/theme/light_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the router
  final appRouter = await createRouter();

  runApp(ProviderScope(child: MainApp(router: appRouter)));
}

class MainApp extends StatelessWidget {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static final navigatorKey = GlobalKey<NavigatorState>();
  final GoRouter router;

  const MainApp({required this.router, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hand Car',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      scaffoldMessengerKey: scaffoldMessengerKey,
      routerConfig: router, // Use the initialized router here
    );
  }
}