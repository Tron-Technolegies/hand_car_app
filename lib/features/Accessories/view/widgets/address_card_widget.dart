import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class AddressCard extends StatelessWidget {
  final String name;
  final String address;
  final String poBox;
  final String mobile;
  final bool isSelected;

  const AddressCard({
    super.key,
    required this.name,
    required this.address,
    required this.poBox,
    required this.mobile,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? context.colors.white : context.colors.background,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile(
        activeColor: context.colors.primaryTxt,
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(address),
            Text(poBox),
            Text(mobile),
          ],
        ),
        value: isSelected,
        groupValue: true,
        onChanged: (bool? value) {
          // Handle address selection
        },
      ),
    );
  }
}