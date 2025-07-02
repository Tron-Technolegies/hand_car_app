// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';

// enum AddressType {
//   home,
//   work,
// }

// class AddressTypeSelectorWidget extends HookWidget {
//   final AddressType? initialAddress;
//   final Function(AddressType) selectedAddressType;
//   const AddressTypeSelectorWidget({
//     super.key,
//     this.initialAddress,
//     required this.selectedAddressType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final selectedAddress = useState<AddressType?>(initialAddress);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 selectedAddress.value = AddressType.home;
//                 selectedAddressType(AddressType.home);
//               },
//               child: Container(
//                 height: 20,
//                 width: 20,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: selectedAddress.value == AddressType.home
//                       ? Colors.green
//                       : Colors.transparent,
//                   border: Border.all(
//                     color: selectedAddress.value == AddressType.home
//                         ? Colors.green
//                         : Colors.grey.shade300,
//                   ),
//                 ),
//                 child: Container(
//                   height: 10,
//                   width: 10,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: selectedAddress.value == AddressType.home
//                         ? Colors.green
//                         : Colors.transparent,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             const Text('Home'),
//           ],
//         ),
//         Row(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 selectedAddress.value = AddressType.work;
//                 selectedAddressType(AddressType.work);
//               },
//               child: Container(
//                 padding: EdgeInsets.all(context.space.space_50),
//                 height: 20,
//                 width: 20,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: selectedAddress.value == AddressType.work
//                       ? Colors.white
//                       : Colors.transparent,
//                 ),
//                 child: Container(
//                   height: 10,
//                   width: 10,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: selectedAddress.value == AddressType.work
//                         ? Colors.black
//                         : Colors.transparent,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             const Text('Work'),
//           ],
//         )
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart'; // Assuming this provides context.space

enum AddressType {
  home,
  work,
}

class AddressTypeSelectorWidget extends HookWidget {
  final AddressType? initialAddress;
  final Function(AddressType) selectedAddressType;

  const AddressTypeSelectorWidget({
    super.key,
    this.initialAddress,
    required this.selectedAddressType,
  });

  @override
  Widget build(BuildContext context) {
    final selectedAddress = useState<AddressType?>(initialAddress);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Home Radio Button
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min, 
            children: [
              Radio<AddressType>(
                value: AddressType.home,
                groupValue: selectedAddress.value,
                onChanged: (AddressType? value) {
                  if (value != null) {
                    selectedAddress.value = value;
                    selectedAddressType(value);
                  }
                },
                activeColor: Colors.black, 
              ),
              const Text('Home'),
            ],
          ),
        ),
        SizedBox(
            width: context
                .space.space_100), 

        // Work Radio Button
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min, // To keep the row compact
            children: [
              Radio<AddressType>(
                value: AddressType.work,
                groupValue: selectedAddress.value,
                onChanged: (AddressType? value) {
                  if (value != null) {
                    selectedAddress.value = value;
                    selectedAddressType(value);
                  }
                },
                activeColor: Colors.black, // You can customize this
              ),
              const Text('Work'),
            ],
          ),
        ),
      ],
    );
  }
}
