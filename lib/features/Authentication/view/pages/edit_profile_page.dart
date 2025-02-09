import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/controller/image_picker_controller.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/core/widgets/outline_button_widget.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/controller/user_controller.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';
import 'package:hand_car/features/Authentication/view/widgets/user_info_edit_field.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditProfileScreen extends HookConsumerWidget {
  static String route = '/edit-profile';
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    // Create controllers using useMemoized to maintain the same instance
    final nameController = useMemoized(() => TextEditingController());
    final emailController = useMemoized(() => TextEditingController());
    final isLoading = useState(false);
    final image = ref.watch(imagePickerProvider);
    final mounted = context.mounted;

    // Watch user data
    final userData = ref.watch(userDataProviderProvider);

    // Initialize controllers with user data
    useEffect(() {
      userData.whenData((user) {
        if (user != null && mounted) {
          nameController.text = user.name;
          emailController.text = user.email;
        }
      });

      // Cleanup
      return () {
        if (mounted) {
          nameController.dispose();
          emailController.dispose();
        }
      };
    }, []);

    Future<void> handleSubmit() async {
      if (!mounted || !(formKey.currentState?.validate() ?? false)) return;

      isLoading.value = true;
      try {
        final updatedProfile = UserModel(
          name: nameController.text,
          email: emailController.text,
          profileImage: image?.path,
          phone: userData.value!.phone,
        );

        await ref.read(authControllerProvider.notifier).updateProfile(
              updatedProfile,
            );

        if (mounted) {
          await ref.read(userDataProviderProvider.notifier).refresh();

          if (context.mounted) {
            SnackbarUtil.showsnackbar(
              message: 'Profile updated successfully',
              showretry: false,
            );
            context.pop();
          }
        }
      } catch (e) {
        if (mounted && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating profile: $e')),
          );
        }
      } finally {
        if (mounted) {
          isLoading.value = false;
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: userData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (user) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              spacing: context.space.space_200,
              children: [
                CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    child: Image.asset(
                      Assets.images.userAvatar.path,
                      height: 80,
                      width: 80,
                    )),
                const Divider(),
                UserInfoEditField(
                  text: "Name",
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          context.colors.primaryTxt.withValues(alpha: 0.05),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.space.space_300,
                        vertical: context.space.space_200,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      hintText: 'Enter your name',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                UserInfoEditField(
                  text: "Email",
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          context.colors.primaryTxt.withValues(alpha: 0.05),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your email';
                      }
                      if (!value!.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     TextButton(
                //       onPressed: () => context.pop(),
                //       child: Text(
                //         'Cancel',
                //         style: TextStyle(color: context.colors.primaryTxt),
                //       ),
                //     ),
                //     const SizedBox(width: 16),
                //     ElevatedButton(
                //       onPressed: isLoading.value ? null : handleSubmit,
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: context.colors.primary,
                //         foregroundColor: Colors.white,
                //         minimumSize: const Size(120, 48),
                //         shape: const StadiumBorder(),
                //       ),
                //       child: isLoading.value
                //           ? const SizedBox(
                //               width: 24,
                //               height: 24,
                //               child: CircularProgressIndicator(
                //                 color: Colors.white,
                //                 strokeWidth: 2,
                //               ),
                //             )
                //           : const Text('Save'),
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: context.space.space_200,
                  children: [
                    OutlineButtonWidget(
                        label: "Cancel", onTap: () => context.pop()),
                    ButtonWidget(
                      label: "Save",
                      onTap: () async {
                        if (!isLoading.value) {
                          await handleSubmit();
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
