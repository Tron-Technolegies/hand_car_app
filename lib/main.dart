import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/router.dart';
import 'package:hand_car/core/theme/light_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();

  // Clear upgrader preferences for testing (optional)
  // await Upgrader.clearSavedSettings();

  log('Config: $baseUrl');
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
      builder: (context, child) {
        return UpgradeAlert(
          navigatorKey: router.routerDelegate.navigatorKey,
          cupertinoButtonTextStyle: const TextStyle(color: Colors.black),
          upgrader: Upgrader(
            messages: CustomUpgraderMessages(),
            debugLogging: true,
            debugDisplayAlways: false,
            debugDisplayOnce: false,
            durationUntilAlertAgain: const Duration(minutes: 1),
            willDisplayUpgrade: ({
              required bool display,
              String? installedVersion,
              UpgraderVersionInfo? versionInfo,
            }) {
              log('Upgrade Decision: display=$display, installed=$installedVersion, store=${versionInfo?.appStoreVersion}');
              if (versionInfo != null) {
                log('Store URL: ${versionInfo.appStoreListingURL}');
                log('Release Notes: ${versionInfo.releaseNotes}');
              }
            },
          ),
          child: child ?? const Text('child'),
        );
      },
    );
  }
}

class CustomUpgraderMessages extends UpgraderMessages {
  @override
  String get title => 'Update Required';

  @override
  String get body =>
      'A new version of Hand Car is available. Update now to continue using the app.';

  @override
  String get prompt => 'Update Now';

  @override
  String get buttonTitleIgnore => 'Later';

  @override
  String get buttonTitleLater => 'Remind Me Later';

  @override
  String get buttonTitleUpdate => 'Update Now';

  @override
  String get releaseNotes => 'Release Notes';
}

// Optional: Custom upgrade widget for more control
class CustomUpgradeAlert extends StatelessWidget {
  final Widget child;

  const CustomUpgradeAlert({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final upgrader = Upgrader(
      messages: CustomUpgraderMessages(),
      debugLogging: true,
      debugDisplayAlways: false, // Set to true for testing
      durationUntilAlertAgain: const Duration(minutes: 1),
      willDisplayUpgrade: (
          {required bool display,
          String? installedVersion,
          UpgraderVersionInfo? versionInfo}) {
        log('Custom Upgrade Check: $display');

        // Custom logic here if needed
        if (display) {
          // You can show your own dialog here
          _showCustomUpgradeDialog(context, versionInfo);
        }
      },
    );

    return UpgradeAlert(
      upgrader: upgrader,
      child: child,
    );
  }

  void _showCustomUpgradeDialog(
      BuildContext context, UpgraderVersionInfo? versionInfo) {
    // Custom dialog implementation
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Update Available'),
        content: Text(
            'Version ${versionInfo?.appStoreVersion} is available. Please update to continue.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Launch store
              Upgrader.sharedInstance.sendUserToAppStore();
            },
            child: const Text('Update Now'),
          ),
        ],
      ),
    );
  }
}
