import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/features/Accessories/controller/address/address_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddressForm extends HookConsumerWidget {
  const AddressForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final addressState = ref.watch(addressControllerProvider);
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
      formKey.currentState?.reset(); // Reset validation state
    }

    // Handle form submission
    Future<void> handleSubmit() async {
      if (formKey.currentState?.validate() ?? false) {
        try {
          isSubmitting.value = true;
          await addressController.addAddress(
            street: streetController.text,
            city: cityController.text,
            state: stateController.text,
            zipCode: zipController.text,
            country: countryValue.value!,
            isDefault: false,
          );
          
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Address added successfully'),
                backgroundColor: Colors.green,
              ),
            );
          }
          
          // Clear all form fields after successful submission
          clearForm();
          
        } catch (e) {
          String errorMessage = 'Failed to add address';
          if (e is DioException) {
            errorMessage = e.response?.data['error'] ?? errorMessage;
          }
          
          if (context.mounted) {
            SnackbarUtil.showsnackbar(message: errorMessage, showretry: true);
          }
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
            decoration: const InputDecoration(
              labelText: 'Street Address',
              hintText: 'Enter your street address',
              border: OutlineInputBorder(),
            ),
            validator: (value) => value?.isEmpty ?? true 
              ? 'Please enter street address' 
              : null,
          ),
          SizedBox(height: context.space.space_200),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value?.isEmpty ?? true 
                    ? 'Please enter city' 
                    : null,
                ),
              ),
              SizedBox(width: context.space.space_200),
              Expanded(
                child: TextFormField(
                  controller: stateController,
                  decoration: const InputDecoration(
                    labelText: 'State/Province',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value?.isEmpty ?? true 
                    ? 'Please enter state' 
                    : null,
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
                  decoration: const InputDecoration(
                    labelText: 'ZIP Code',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value?.isEmpty ?? true 
                    ? 'Please enter ZIP code' 
                    : null,
                ),
              ),
              SizedBox(width: context.space.space_200),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: countryValue.value,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'UAE', child: Text('UAE')),
                    DropdownMenuItem(value: 'Qatar', child: Text('Qatar')),
                    DropdownMenuItem(value: 'Canada', child: Text('Canada')),
                  ],
                  onChanged: (value) {
                    countryValue.value = value;
                  },
                  validator: (value) => value == null 
                    ? 'Please select country' 
                    : null,
                ),
              ),
            ],
          ),
          SizedBox(height: context.space.space_300),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isSubmitting.value ? null : handleSubmit,
              child: isSubmitting.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save Address'),
            ),
          ),
        ],
      ),
    );
  }
}