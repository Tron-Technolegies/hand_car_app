import 'package:flutter/material.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/controller/address/address_controller.dart';

class AddressCard extends ConsumerWidget {
  final String name;
  final String phoneNumber;
  final String address;
  final String landmark;
  final String addressType;
  final ValueNotifier<String?> selectedAddress;
  final String id;
  final bool isDefault;

  const AddressCard({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.landmark,
    required this.addressType,
    required this.selectedAddress,
    required this.id,
    this.isDefault = false,
  });

  // Factory constructor to create AddressCard from API response
  factory AddressCard.fromApiResponse({
    required Map<String, dynamic> response,
    required ValueNotifier<String?> selectedAddress,
  }) {
    // Combine address fields into a single string
    final address = [
      response['street'],
      response['building_name'],
      response['floor_apartment_no'],
      response['area_district'],
      response['city'],
      response['country'],
    ].where((e) => e != null && e.isNotEmpty).join(', ');

    return AddressCard(
      name: response['name'] ?? 'Unknown',
      phoneNumber: response['phone_number'] ?? 'N/A',
      address: address,
      landmark: response['landmark']?.isNotEmpty ?? false
          ? response['landmark']
          : 'N/A',
      addressType: response['address_type']?.toUpperCase() ?? 'N/A',
      selectedAddress: selectedAddress,
      id: response['id'].toString(),
      isDefault: response['is_default'] ?? false,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressController = ref.read(addressControllerProvider.notifier);
    final isSelected = selectedAddress.value == id;

    Future<void> deleteAddress(int id) async {
      final confirmed = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Confirm Delete',
                style: context.typography.bodyLarge,
              ),
              content: Text(
                'Are you sure you want to delete this address?',
                style: context.typography.body,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    'Cancel',
                    style: context.typography.bodyMedium
                        .copyWith(color: context.colors.primary),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(
                    'Delete',
                    style: context.typography.bodyMedium
                        .copyWith(color: Colors.red),
                  ),
                ),
              ],
            ),
          ) ??
          false;
      if (confirmed) {
        try {
          await addressController.deleteAddress(id);
          if (context.mounted) {
            SnackbarUtil.showsnackbar(
              message: 'Address deleted successfully',
            );
          }
        } catch (e) {
          if (context.mounted) {
            SnackbarUtil.showsnackbar(
              message: 'Failed to delete address: $e',
            );
          }
        }
      }
    }

    return GestureDetector(
      onTap: () => selectedAddress.value = id,
      child: Container(
        padding: EdgeInsets.all(context.space.space_200),
        margin: EdgeInsets.symmetric(vertical: context.space.space_100),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? context.colors.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: context.colors.background,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
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
                      Row(
                        children: [
                          Text(
                            name,
                            style: context.typography.bodyLarge.copyWith(
                              color: context.colors.primaryTxt,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.space.space_100,
                              vertical: context.space.space_50,
                            ),
                            decoration: BoxDecoration(
                              color: addressType == 'HOME'
                                  ? context.colors.primary
                                      .withValues(alpha: 0.1)
                                  : Colors.grey.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              addressType,
                              style:
                                  context.typography.bodySmallMedium.copyWith(
                                color: addressType == 'HOME'
                                    ? context.colors.primary
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Phone: $phoneNumber',
                        style: context.typography.bodyMedium
                            .copyWith(color: context.colors.primaryTxt),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        address,
                        style: context.typography.bodyMedium
                            .copyWith(color: context.colors.primaryTxt),
                      ),
                      if (landmark != 'N/A') ...[
                        const SizedBox(height: 4),
                        Text(
                          'Landmark: $landmark',
                          style: context.typography.bodyMedium
                              .copyWith(color: context.colors.primaryTxt),
                        ),
                      ],
                    ],
                  ),
                ),
                Radio<String>(
                  value: id,
                  groupValue: selectedAddress.value,
                  onChanged: (value) => selectedAddress.value = value,
                  activeColor: context.colors.primary,
                ),
              ],
            ),
            const SizedBox(height: 12),
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
                    backgroundColor: context.colors.primaryTxt,
                    padding: EdgeInsets.symmetric(
                      horizontal: context.space.space_100,
                      vertical: context.space.space_50,
                    ),
                  )
                else
                  TextButton(
                    onPressed: () async {
                      try {
                        await addressController
                            .setDefaultAddress(int.parse(id));
                        if (context.mounted) {
                          SnackbarUtil.showsnackbar(
                            message: 'Default address updated',
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          SnackbarUtil.showsnackbar(
                            message: 'Error: $e',
                          );
                        }
                      }
                    },
                    child: Text(
                      'Set as Default',
                      style: context.typography.bodySmallMedium
                          .copyWith(color: context.colors.primary),
                    ),
                  ),
                IconButton(
                  onPressed: () => deleteAddress(int.parse(id)),
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.black,
                    size: context.space.space_300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
