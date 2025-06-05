import 'package:flutter/material.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/controller/address/address_controller.dart';

class AddressCard extends ConsumerWidget {
  final String name;
  final String address;
  final String poBox;
  final ValueNotifier<String?> selectedAddress;
  final String id;
  final bool isDefault;

  const AddressCard({
    super.key,
    required this.name,
    required this.address,
    required this.poBox,
    required this.selectedAddress,
    required this.id,
    this.isDefault = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressController = ref.read(addressControllerProvider.notifier);
    final isSelected = selectedAddress.value == id;

    Future<void> deleteAddress(int id) async {
      final confirmed = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Confirm Delete'),
              content:
                  const Text('Are you sure you want to delete this address?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ) ??
          false;
      if (confirmed) {
        final controller = ref.read(addressControllerProvider.notifier);
        try {
          await controller.deleteAddress(id);
          if (context.mounted) {
            SnackbarUtil.showsnackbar(
              message: 'Address deleted successfully',
            );
          }
        } catch (e) {
          if (context.mounted) {
            SnackbarUtil.showsnackbar(
              message: 'Failed to delete address',
            );
          }
        }
      }
    }

    return GestureDetector(
      onTap: () => selectedAddress.value = id,
      child: Container(
        padding: EdgeInsets.all(context.space.space_200),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? context.colors.primary : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: context.typography.bodyLarge),
                      const SizedBox(height: 4),
                      Text(address, style: context.typography.bodyMedium),
                      Text(poBox, style: context.typography.bodyMedium),
                    ],
                  ),
                ),
                Radio<String>(
                  value: id,
                  groupValue: selectedAddress.value,
                  onChanged: (value) => selectedAddress.value = value,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isDefault)
                  Chip(
                    label: Text(
                      'Default',
                      style: context.typography.bodySmallMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: context.colors.primary,
                  )
                else
                  TextButton(
                    onPressed: () async {
                      try {
                        await addressController
                            .setDefaultAddress(int.parse(id));
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Default address updated'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      'Set as Default',
                      style: context.typography.bodySmallMedium,
                    ),
                  ),
                IconButton(
                  onPressed: () => deleteAddress(int.parse(id)),
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
