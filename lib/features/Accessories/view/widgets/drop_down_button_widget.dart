import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class DropDownButtonWidget extends HookWidget {
  const DropDownButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dropdownValue = useState(1); // Hook to manage dropdown value
    List<int> dropdownItems = List.generate(9, (index) => index + 1);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.space.space_150,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.primaryTxt),
        borderRadius: BorderRadius.circular(context.space.space_100),
      ),
      child: DropdownButton<int>(
        value: dropdownValue.value,
        style: context.typography.bodyMedium
            .copyWith(color: context.colors.primaryTxt),
        onChanged: (int? newValue) {
          dropdownValue.value = newValue!; // Update state
        },
        items: dropdownItems.map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
      ),
    );
  }
}
