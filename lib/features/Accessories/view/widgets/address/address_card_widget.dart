import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

// Address Card For Selecting Address
class AddressCard extends HookWidget {
  final String name;
  final String address;
  final String poBox;

  final ValueNotifier<String?> selectedAddress;

  const AddressCard({
    super.key,
    required this.name,
    required this.address,
    required this.poBox,

    required this.selectedAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selectedAddress.value == name
            ? context.colors.white
            : context.colors.background,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile(
        activeColor: context.colors.primaryTxt,
        selected: selectedAddress.value == name,
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(address),
            Text(poBox),
           
          ],
        ),
        value: name,
        groupValue: selectedAddress.value,
        onChanged: (String? value) {
          if (value != null) {
            selectedAddress.value = value;
          }
        },
      ),
    );
  }
}
