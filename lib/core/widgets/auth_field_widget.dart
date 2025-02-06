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
  final String? Function(String?)? validator;
  final bool isPassword;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;

  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.onChanged,
    this.padding,
    this.inputFormatters,
    this.validator,
    this.isPassword = false,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? isPassword,
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      style: context.typography.body,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        hintText: hintText,
        hintStyle: context.typography.body.copyWith(
          color: const Color(0xFFD1D3D4),
        ),
        contentPadding: padding,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}