import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hand_car/core/router/router.dart';
import 'package:hand_car/core/theme/light_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
   await GetStorage.init();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Hand Car',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      scaffoldMessengerKey: scaffoldMessengerKey,
      routerConfig: router,
    );
  }
}