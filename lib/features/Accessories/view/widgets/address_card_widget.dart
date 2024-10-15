import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class AddressCard extends HookWidget {
  final String name;
  final String address;
  final String poBox;
  final String mobile;

  const AddressCard({
    super.key,
    required this.name,
    required this.address,
    required this.poBox,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = useState(false);

    return Container(
      decoration: BoxDecoration(
        color: isSelected.value ? context.colors.white : context.colors.background,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile(
        value: true,
        groupValue: isSelected.value,
        activeColor: context.colors.primaryTxt,
        selected: isSelected.value, // Use selected instead of redundant value
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(address),
            Text(poBox),
            Text(mobile),
          ],
        ),
        onChanged: (bool? value) {
          isSelected.value = value!;
        },
      ),
    );
  }
}