
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';
// import 'package:hand_car/features/Accessories/controller/address/address_controller.dart';
// import 'package:hand_car/features/Accessories/view/widgets/address/address_card_widget.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';


// class AddressListPage extends HookConsumerWidget {
//   const AddressListPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final addressController = ref.watch(addressControllerProvider);
//     final selectedAddress = useState<String?>(null);

//     useEffect(() {
//       ref.read(addressControllerProvider.notifier).fetchAddresses();
//       return null;
//     }, []);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select Address"),
//       ),
//       body: addressController.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : addressController.error != null
//               ? Center(
//                   child: Text(
//                     "Error: ${addressController.error}",
//                     style: TextStyle(color: context.colors.primary),
//                   ),
//                 )
//               : ListView.builder(
//                   itemCount: addressController.addresses.length,
//                   itemBuilder: (context, index) {
//                     final address = addressController.addresses[index];
//                     return AddressCard(
//                       name: address.id ?? "Unknown",
//                       address: "${address.street}, ${address.city}, ${address.state}, ${address.country}",
//                       poBox: "ZIP: ${address.zipCode}",
//                        // Replace with phone number if available
//                       selectedAddress: selectedAddress,
//                     );
//                   },
//                 ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navigate to Add Address Form
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AddressForm()),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class AddressForm extends HookConsumerWidget {
//   const AddressForm({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final streetController = useTextEditingController();
//     final cityController = useTextEditingController();
//     final stateController = useTextEditingController();
//     final zipController = useTextEditingController();
//     final countryController = useTextEditingController();

//     final addressController = ref.read(addressControllerProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(title: const Text("Add Address")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: streetController,
//               decoration: const InputDecoration(
//                 labelText: 'Street',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: context.space.space_200),
//             TextField(
//               controller: cityController,
//               decoration: const InputDecoration(
//                 labelText: 'City',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: context.space.space_200),
//             TextField(
//               controller: stateController,
//               decoration: const InputDecoration(
//                 labelText: 'State',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: context.space.space_200),
//             TextField(
//               controller: zipController,
//               decoration: const InputDecoration(
//                 labelText: 'ZIP Code',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: context.space.space_200),
//             TextField(
//               controller: countryController,
//               decoration: const InputDecoration(
//                 labelText: 'Country',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: context.space.space_300),
//             ElevatedButton(
//               onPressed: () {
//                 addressController.addAddress(
//                   street: streetController.text,
//                   city: cityController.text,
//                   state: stateController.text,
//                   zipCode: zipController.text,
//                   country: countryController.text,
//                 );
//                 Navigator.pop(context);
//               },
//               child: const Text("Save Address"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
