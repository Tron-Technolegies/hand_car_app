import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.colors.primary,
            ),
            child: const Column(children: [
              CircleAvatar(
                radius: 40,
                child: CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
              Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ]),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
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
        ],
      ),
    );
  }
}
