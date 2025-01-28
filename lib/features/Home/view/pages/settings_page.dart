import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/controller/image_picker_controller.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Authentication/view/pages/edit_profile_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class ProfilePage extends ConsumerWidget {
  static const route = '/profile';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(imagePickerProvider);
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: context.colors.primary,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ref.read(imagePickerProvider.notifier).pickImage();
                          },
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: image?.path == null
                                      ? const Icon(Icons.person,
                                          size: 50, color: Colors.grey)
                                      : Image.file(
                                          image!,
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                        ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: context.colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                    color: context.colors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Your Name', // Replace with actual user name
                          style: context.typography.h2.copyWith(
                            color: context.colors.white,
                          ),
                        ),
                        Text(
                          'user@email.com', // Replace with actual user email
                          style: context.typography.bodySmall.copyWith(
                            color: context.colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text('Edit Profile'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => context.push(EditProfileScreen.route),
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications_outlined),
                    title: const Text('Notifications'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {}, // Add notification settings navigation
                  ),
                  ListTile(
                    leading: const Icon(Icons.payment_outlined),
                    title: const Text('Payment Methods'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {}, // Add payment methods navigation
                  ),
                  ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text('Order History'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {}, // Add order history navigation
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on_outlined),
                    title: const Text('Saved Addresses'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {}, // Add addresses navigation
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.help_outline),
                    title: const Text('Help & Support'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {}, // Add help & support navigation
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: const Text('Privacy Policy'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {}, // Add privacy policy navigation
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_outlined),
                    title: const Text('Logout'),
                    onTap: () => _showLogoutDialog(context, ref),
                  ),
                ],
              ),
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
                content:
                    Text(ref.read(authControllerProvider).error.toString()),
                backgroundColor: context.colors.warning,
              ),
            );
          } else {
            context.go(LoginWithPhoneAndPasswordPage.route);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Successfully logged out'),
                backgroundColor: context.colors.green,
              ),
            );
          }
        }
      },
      barrierDismissible: false,
    );
  }
}
