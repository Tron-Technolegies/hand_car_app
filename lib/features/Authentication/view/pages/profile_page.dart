import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/controller/image_picker_controller.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/controller/user_controller.dart';
import 'package:hand_car/features/Authentication/view/pages/edit_profile_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hand_car/features/Authentication/view/widgets/profile_menu_items_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class ProfilePage extends ConsumerWidget {
  static const route = '/profile';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final image = ref.watch(imagePickerProvider);
    final authState = ref.watch(authControllerProvider);
    final userData = ref.watch(userDataProviderProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 600,
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
                                  child: userData.when(
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                    error: (_, __) => const Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                    data: (user) => user?.profileImage != null
                                        ? Image.network(
                                            user!.profileImage!,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                            errorBuilder: (_, __, ___) =>
                                                const Icon(
                                              Icons.person,
                                              size: 50,
                                              color: Colors.grey,
                                            ),
                                          )
                                        : const Icon(
                                            Icons.person,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
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
                        userData.when(
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stackTrace) => Center(
                            child: Column(
                              children: [
                                Text('Error: $error'),
                                ElevatedButton(
                                  onPressed: () =>
                                      ref.invalidate(userDataProviderProvider),
                                  child: Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                          data: (user) => user != null
                              ? Column(
                                  children: [
                                    Text(user.name),
                                    Text(user.email),
                                  ],
                                )
                              : Text('No user data'),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Profile menu items
                  ProfileMenuItem(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    onTap: () => context.push(EditProfileScreen.route),
                  ),

                  ProfileMenuItem(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    icon: Icons.logout_outlined,
                    title: 'Logout',
                    onTap: () async {
                      PanaraConfirmDialog.show(
                        context,
                        buttonTextColor: context.colors.white,
                        color: context.colors.primary,
                        panaraDialogType: PanaraDialogType.error,
                        title: "Logout Confirmation",
                        message: "Are you sure you want to logout?",
                        confirmButtonText: "Logout",
                        cancelButtonText: "Cancel",
                        onTapCancel: () {
                          Navigator.pop(context); // Close dialog on cancel
                        },
                        onTapConfirm: () async {
                          Navigator.pop(
                              context); // Close dialog before logging out

                          // Perform logout
                          await ref
                              .read(authControllerProvider.notifier)
                              .logout();

                          if (context.mounted) {
                            if (authState.error != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(authState.error.toString()),
                                  backgroundColor: context.colors.primary,
                                ),
                              );
                            } else {
                              // Navigate to login screen
                              context.go(LoginWithPhoneAndPasswordPage.route);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Successfully logged out'),
                                ),
                              );
                            }
                          }
                        },
                        barrierDismissible: false,
                      );
                    },
                    showArrow: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



