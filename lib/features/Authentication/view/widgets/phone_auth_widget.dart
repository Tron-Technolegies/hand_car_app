import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/auth_field_widget.dart';

class PhoneAuthField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onCountryChanged;
  final String initialCountryCode;

  const PhoneAuthField({
    super.key,
    required this.controller,
    this.validator,
    this.onCountryChanged,
    this.initialCountryCode = 'AE',
  });

  @override
  Widget build(BuildContext context) {
    return AuthField(
      controller: controller,
      hintText: "Enter Your Phone Number",
      keyboardType: TextInputType.phone,
      validator: validator,
      padding: EdgeInsets.all(context.space.space_200),
      prefixIcon: SizedBox(
        width: 120,
        child: CountryCodePicker(
          onChanged: (countryCode) {
            if (onCountryChanged != null) {
              onCountryChanged!(countryCode.dialCode?.replaceAll('+', '') ?? '971');
            }
          },
          initialSelection: initialCountryCode,
          favorite: const ['+971'],
          showCountryOnly: false,
          showOnlyCountryWhenClosed: false,
          alignLeft: true,
          padding: EdgeInsets.zero,
          textStyle: context.typography.body,
          searchStyle: context.typography.body,
          dialogTextStyle: context.typography.body,
          flagWidth: 30,
          boxDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}