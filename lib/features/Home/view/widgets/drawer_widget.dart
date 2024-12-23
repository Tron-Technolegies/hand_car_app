import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/controller/image_picker_controller.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final image = ref.watch(imagePickerProvider);
    final authState = ref.watch(authControllerProvider);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.colors.primary,
            ),
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
                Text('Muhammed Risan',
                    style: context.typography.h2
                        .copyWith(color: context.colors.white)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.manage_accounts_outlined),
            title: const Text('Manage Account'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About US'),
            onTap: () {
              // Handle logout logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Contact US'),
            onTap: () {
              // Handle logout logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.quiz),
            title: const Text('FAQ'),
            onTap: () {
              // Handle logout logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.gavel_sharp),
            title: const Text('Terms & Conditions'),
            onTap: () {
              // Handle logout logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Logout'),
            onTap: () async {
              // Handle logout logic here
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );

              if (shouldLogout == true) {
                await ref.read(authControllerProvider.notifier).logout();

                if (context.mounted) {
                  if (authState.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(authState.error.toString()),
                        backgroundColor: Colors.red,
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
              }
            },
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hand_car/core/controller/image_picker_controller.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';
// import 'package:hand_car/gen/assets.gen.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:lottie/lottie.dart';

// class DrawerWidget extends HookConsumerWidget {
//   const DrawerWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final image = ref.watch(imagePickerProvider);
//     final animationControllers = List.generate(
//         6,
//         (_) => useAnimationController(
//               duration: const Duration(milliseconds: 250),
//             ));

//     useEffect(() {
//       // Trigger all animations when the widget is built
//       for (var controller in animationControllers) {
//         controller.forward();
//       }
//       return null;
//     }, const []);

//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: context.colors.primary,
//             ),
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: () =>
//                       ref.read(imagePickerProvider.notifier).pickImage(),
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.grey[300],
//                     child: ClipOval(
//                       child: image?.path == null
//                           ? Container()
//                           : Image.file(
//                               image!,
//                               fit: BoxFit.cover,
//                               width: 100,
//                               height: 100,
//                             ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: context.space.space_50),
//                 Text('Muhammed Risan',
//                     style: context.typography.bodyLarge
//                         .copyWith(color: context.colors.white)),
//               ],
//             ),
//           ),
//           ...List.generate(
//               6,
//               (index) => _buildAnimatedListTile(
//                   index, animationControllers[index], context)),
//         ],
//       ),
//     );
//   }

//   Widget _buildAnimatedListTile(
//       int index, AnimationController controller, BuildContext context) {
//     return FadeTransition(
//       opacity: controller,
//       child: SlideTransition(
//         position: Tween<Offset>(
//           begin: const Offset(-1, 0),
//           end: Offset.zero,
//         ).animate(controller),
//         child: ListTile(
//           leading: Lottie.asset(

//         ),
//           title: Text(_getTitle(index)),
//           onTap: () {
//             // Handle taps
//             print('Tapped on item $index');
//           },
//         ),
//       ),
//     );
//   }

//   String _getIcon(int index) {
//     switch (index) {
//       case 0:
//         return Assets.icons.;
//       case 1:
//         return Icons.info;
//       case 2:
//         return Icons.phone;
//       case 3:
//         return Icons.quiz;
//       case 4:
//         return Icons.gavel_sharp;
//       default:
//         return Icons.logout_outlined;
//     }
//   }

//   String _getTitle(int index) {
//     switch (index) {
//       case 0:
//         return 'Manage Account';
//       case 1:
//         return 'About Us';
//       case 2:
//         return 'Contact Us';
//       case 3:
//         return 'FAQ';
//       case 4:
//         return 'Terms & Conditions';
//       default:
//         return 'Logout';
//     }
//   }
// }
