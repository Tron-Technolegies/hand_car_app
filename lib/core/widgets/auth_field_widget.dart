import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? padding;
  const AuthField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.keyboardType,
      this.onChanged,
      this.padding,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: context.typography.body,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF5F5F5),
          hintText: hintText,
          hintStyle: context.typography.body.copyWith(
            color: Color(0xFFD1D3D4),
          ),
          contentPadding: padding),
      keyboardType: keyboardType,
    );
  }
}
