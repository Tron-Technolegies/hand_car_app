import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/controller/image_picker_controller.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Authentication/view/pages/edit_profile_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class SettingsPage extends ConsumerWidget {
  static const route = '/settings';
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(imagePickerProvider);
    // final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              color: context.colors.primary,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(imagePickerProvider.notifier).pickImage();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: image?.path == null
                            ? Container()
                            : Image.file(
                                image!,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Muhammed Risan',
                    style: context.typography.h2.copyWith(
                      color: context.colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.manage_accounts_outlined),
              title: const Text('Manage Account'),
              onTap: () => context.push(EditProfileScreen.route),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Contact Us'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.quiz),
              title: const Text('FAQ'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.gavel_sharp),
              title: const Text('Terms & Conditions'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout'),
              onTap: () => _showLogoutDialog(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context, WidgetRef ref) async {
    final authController = ref.read(authControllerProvider.notifier);
    
    return PanaraConfirmDialog.show(
      context,
      buttonTextColor: context.colors.white,
      color: context.colors.primary,
      panaraDialogType: PanaraDialogType.error,
      title: "Logout Confirmation",
      message: "Are you sure you want to logout?",
      confirmButtonText: "Logout",
      cancelButtonText: "Cancel",
      onTapCancel: () => Navigator.pop(context),
      onTapConfirm: () async {
        Navigator.pop(context);
        await authController.logout();

        if (context.mounted) {
          if (ref.read(authControllerProvider).error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(ref.read(authControllerProvider).error.toString()),
                backgroundColor: context.colors.primary,
              ),
            );
          } else {
            context.go(LoginWithPhoneAndPasswordPage.route);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Successfully logged out')),
            );
          }
        }
      },
      barrierDismissible: false,
    );
  }
}