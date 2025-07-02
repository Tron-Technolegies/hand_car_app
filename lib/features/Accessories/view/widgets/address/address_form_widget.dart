import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/features/Accessories/controller/address/address_controller.dart';
import 'package:hand_car/features/Accessories/view/widgets/address/address_type_selector_widget.dart';
import 'package:hand_car/features/Authentication/view/widgets/phone_auth_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddressForm extends HookConsumerWidget {
  final VoidCallback? onAddressAdded;
  const AddressForm({
    super.key,
    this.onAddressAdded,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final addressController = ref.read(addressControllerProvider.notifier);
    final selectedCountryCode = useState('971');
    final initialAddress = useState<AddressType?>(null);

    // Form controllers
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final streetController = useTextEditingController();
    final cityController = useTextEditingController();
     final buildingNameController = useTextEditingController();
    final floorAndApartmentController = useTextEditingController();
    final areacontroller = useTextEditingController();
    final zipController = useTextEditingController();
    final countryValue = useState<String?>(null);
    final cityValue=useState<String?>(null);
    final isSubmitting = useState(false);

    // Clear all form fields
    void clearForm() {
      streetController.clear();
      cityController.clear();
      areacontroller.clear();
      zipController.clear();
      countryValue.value = null;
      formKey.currentState?.reset();
    }

    String? validatePhoneNumber(String? value, String countryCode) {
      if (value == null || value.isEmpty) {
        return 'Phone number is required';
      }
      final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
      if (digitsOnly.length < 8 || digitsOnly.length > 15) {
        return 'Invalid phone number length';
      }
      return null;
    }

    // Handle form submission
    Future<void> handleSubmit() async {
      // Unfocus any current text fields to dismiss keyboard
      FocusScope.of(context).unfocus();

      if (formKey.currentState?.validate() ?? false) {
        try {
          isSubmitting.value = true;

          await addressController.addAddress(
            name: nameController.text.trim(),
            phone: phoneController.text.trim(),
            street: streetController.text.trim(),
            city: cityValue.value!,
            buildingName: buildingNameController.text.trim(),
            floorApartmentNo: floorAndApartmentController.text.trim(),
          areaDistrict: areacontroller.text.trim(),
            zipCode: zipController.text.trim(),
            country: countryValue.value!,
            addressType: initialAddress.value == AddressType.home ? 'home' : 'work',
            isDefault: false,
          );

          // Show success message
          SnackbarUtil.showsnackbar(message: 'Address added successfully');

          // Call the onAddressAdded callback if provided
          onAddressAdded?.call();

          // Clear all form fields after successful submission
          clearForm();
        } catch (e) {
          String errorMessage = 'Failed to add address';

          if (e is DioException) {
            errorMessage = e.response?.data['error'] ??
                e.message ??
                'Network error occurred';
          }

          // Show error snackbar
          SnackbarUtil.showsnackbar(message: errorMessage, showretry: true);
        } finally {
          isSubmitting.value = false;
        }
      }
    }

    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) =>
                  (value?.isEmpty ?? true) ? 'Please enter Your name' : null,
              textInputAction: TextInputAction.next,
            ),
     
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                prefixIcon: SizedBox(
                  width: 120,
                  child: CountryCodePicker(
                    onChanged: (countryCode) {
                      selectedCountryCode.value =
                          countryCode.dialCode?.replaceAll('+', '') ?? '971';
                    },
                    favorite: const ['+971'],
                    initialSelection: 'AE',
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
                labelText: 'Phone',
                hintText: 'Enter your phone number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) =>
                  validatePhoneNumber(value, selectedCountryCode.value),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: context.space.space_200),
            TextFormField(
              controller: streetController,
              decoration: InputDecoration(
                labelText: 'Street Address',
                hintText: 'eg: Al wasl road',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) => (value?.isEmpty ?? true)
                  ? 'Please enter street address'
                  : null,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: context.space.space_200),
            TextFormField(
              controller: buildingNameController,
              decoration: InputDecoration(
                labelText: 'Building Name',
                hintText: 'eg: Marina Tower',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) => (value?.isEmpty ?? true)
                  ? 'Please enter building name'
                  : null,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: context.space.space_200),
            TextFormField(
              controller: floorAndApartmentController,
              decoration: InputDecoration(
                labelText: 'Floor & Apartment NO',
                hintText: 'eg: 7a,Apt 705',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) => (value?.isEmpty ?? true)
                  ? 'Please enter  floor & apt no'
                  : null,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: context.space.space_200),
            TextFormField(
              controller: streetController,
              decoration: InputDecoration(
                labelText: 'Landmark (Optional)',
                hintText: 'eg: Dubai Mall',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // validator: (value) =>
              //     (value?.isEmpty ?? true) ? 'Please enter landmark' : null,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: context.space.space_200),
            TextFormField(
              controller: areacontroller,
              decoration: InputDecoration(
                labelText: 'Area/District',
                hintText: 'eg: Business Bay',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) => (value?.isEmpty ?? true)
                  ? 'Please enter  floor & apt no'
                  : null,
              textInputAction: TextInputAction.next,
            ),

            SizedBox(height: context.space.space_200),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: cityValue.value,
                    decoration: InputDecoration(
                      hintText: "Select City",
                      labelText: 'City',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'Select City',
                        enabled: false,
                        child: Text('Select City'),
                      ),
                      DropdownMenuItem(value: 'Dubai', child: Text('Dubai')),
                      DropdownMenuItem(
                          value: 'Abu Dhabi', child: Text('Abu Dhabi')),
                      DropdownMenuItem(
                          value: 'Sharjah', child: Text('Sharjah')),
                      DropdownMenuItem(value: 'Ajman', child: Text('Ajman')),
                      DropdownMenuItem(
                          value: 'Fujairah', child: Text('Fujairah')),
                      DropdownMenuItem(
                          value: 'Ras Al Khaimah',
                          child: Text('Ras Al Khaimah')),
                      DropdownMenuItem(
                          value: 'Umm Al Quwain', child: Text('Umm Al Quwain')),
                      DropdownMenuItem(value: 'Al Ain', child: Text('Al Ain')),
                      DropdownMenuItem(
                          value: "Khor Fakkan",
                          child: Text(
                            "Khor Fakkan",
                          )),
                      DropdownMenuItem(
                          value: "Dibba Al-Fujairah",
                          child: Text(
                            "Dibba Al-Fujairah",
                          ))
                    ],
                    onChanged: (value) {
                      countryValue.value = value;
                    },
                    validator: (value) =>
                        value == null ? 'Please select city' : null,
                  ),
                ),
                
              ],
            ),
            SizedBox(height: context.space.space_200),
              Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: cityValue.value,
                    decoration: InputDecoration(
                      hintText: "Select Contry",
                      labelText: 'Contry',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'Select Contry',
                        enabled: false,
                        child: Text('United Arab Emirates'),
                      ),
                     
                    ],
                    onChanged: (value) {
                      countryValue.value = value;
                    },
                    validator: (value) =>
                        value == null ? 'Please select country' : null,
                  ),
                ),
                
              ],
            ),
            Text("Address Type", style: context.typography.bodyLarge),
            AddressTypeSelectorWidget(selectedAddressType: (AddressType value) {
              initialAddress.value = value;
            }),
            SizedBox(height: context.space.space_300),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSubmitting.value ? null : handleSubmit,
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: context.space.space_200),
                ),
                child: isSubmitting.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        'Save Address',
                        style: context.typography.bodyLarge,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
