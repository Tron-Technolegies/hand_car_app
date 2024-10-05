import 'package:flutter/material.dart';
import 'package:hand_car/core/controller/image_picker_controller.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final image = ref.watch(imagePickerProvider);
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
            onTap: () {
              // Handle logout logic here
            },
          ),
        ],
      ),
    );
  }
}
