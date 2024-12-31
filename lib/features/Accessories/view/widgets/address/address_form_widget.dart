import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/features/Accessories/controller/address/address_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddressForm extends HookConsumerWidget {
  final VoidCallback? onAddressAdded;
  const AddressForm( {super.key,this.onAddressAdded, });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final addressController = ref.read(addressControllerProvider.notifier);

    // Form controllers
    final streetController = useTextEditingController();
    final cityController = useTextEditingController();
    final stateController = useTextEditingController();
    final zipController = useTextEditingController();
    final countryValue = useState<String?>(null);
    final isSubmitting = useState(false);

    // Clear all form fields
    void clearForm() {
      streetController.clear();
      cityController.clear();
      stateController.clear();
      zipController.clear();
      countryValue.value = null;
      formKey.currentState?.reset();
    }

    // Handle form submission
    Future<void> handleSubmit() async {
      // Unfocus any current text fields to dismiss keyboard
      FocusScope.of(context).unfocus();

      if (formKey.currentState?.validate() ?? false) {
        try {
          isSubmitting.value = true;
          
          await addressController.addAddress(
            street: streetController.text.trim(),
            city: cityController.text.trim(),
            state: stateController.text.trim(),
            zipCode: zipController.text.trim(),
            country: countryValue.value!,
            isDefault: false,
          );
          
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Address added successfully', 
                style: context.typography.bodyMedium?.copyWith(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
          
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
          SnackbarUtil.showsnackbar(
            message: errorMessage, 
            showretry: true
          );
        } finally {
          isSubmitting.value = false;
        }
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: streetController,
            decoration: InputDecoration(
              labelText: 'Street Address',
              hintText: 'Enter your street address',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) => 
              (value?.isEmpty ?? true) ? 'Please enter street address' : null,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: context.space.space_200),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) => 
                    (value?.isEmpty ?? true) ? 'Please enter city' : null,
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(width: context.space.space_200),
              Expanded(
                child: TextFormField(
                  controller: stateController,
                  decoration: InputDecoration(
                    labelText: 'State/Province',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) => 
                    (value?.isEmpty ?? true) ? 'Please enter state' : null,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ],
          ),
          SizedBox(height: context.space.space_200),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: zipController,
                  decoration: InputDecoration(
                    labelText: 'ZIP Code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) => 
                    (value?.isEmpty ?? true) ? 'Please enter ZIP code' : null,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(width: context.space.space_200),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: countryValue.value,
                  decoration: InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'UAE', child: Text('UAE')),
                    DropdownMenuItem(value: 'Qatar', child: Text('Qatar')),
                    DropdownMenuItem(value: 'Canada', child: Text('Canada')),
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
          SizedBox(height: context.space.space_300),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isSubmitting.value ? null : handleSubmit,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: context.space.space_200),
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
    );
  }
}