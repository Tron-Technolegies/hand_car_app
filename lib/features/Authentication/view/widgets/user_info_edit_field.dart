
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class UserInfoEditField extends HookWidget {
  const UserInfoEditField({
    super.key,
    required this.text,
    required this.child,
  });

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: context.space.space_100),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(text),
          ),
          Expanded(
            flex: 3,
            child: child,
          ),
        ],
      ),
    );
  }
}
