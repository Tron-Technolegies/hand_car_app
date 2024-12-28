import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/widgets/outline_button_widget.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/view/pages/signup_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';


class LoginWithPhoneAndPasswordPage extends HookConsumerWidget {
  static const route = '/LoginWithPhoneAndPasswordPage';
  const LoginWithPhoneAndPasswordPage({super.key});

  String? validatePhoneNumber(String? value, String countryCode) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove any non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    // Check if the number has the correct length based on country
    switch (countryCode) {
      case '+91': // India
        if (digitsOnly.length != 10) {
          return 'Phone number must be 10 digits';
        }
        if (!digitsOnly.startsWith(RegExp(r'[6-9]'))) {
          return 'Phone number must start with 6-9';
        }
        break;
      case '+1': // USA/Canada
        if (digitsOnly.length != 10) {
          return 'Phone number must be 10 digits';
        }
        break;
      // Add more country-specific validations as needed
      default:
        if (digitsOnly.length < 8 || digitsOnly.length > 15) {
          return 'Invalid phone number length';
        }
    }
    
    return null;
  }

String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;  // Return null if validation passes
}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useState(GlobalKey<FormState>());
    final isPasswordVisible = useState(false);
    final selectedCountry = useState<Country>(Country(
      phoneCode: '91',
      countryCode: 'IN',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'India',
      example: '9123456789',
      displayName: 'India (IN) [+91]',
      displayNameNoCountryCode: 'India (IN)',
      e164Key: '',
    ));
    
    // Watch the login state
    final loginState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: EdgeInsets.all(context.space.space_200),
              child: Form(
                key: formKey.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SvgPicture.asset(Assets.icons.handCarIcon),
                    ),
                    SizedBox(height: context.space.space_200),
                    Padding(
                      padding: EdgeInsets.only(left: context.space.space_200),
                      child: Text(
                        "Enter Your Phone Number",
                        style: context.typography.h3,
                      ),
                    ),
                    SizedBox(height: context.space.space_200),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.space.space_200),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Country Code Selector
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: InkWell(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: true,
                                  onSelect: (Country country) {
                                    selectedCountry.value = country;
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Center(
                                  child: Text(
                                    '+${selectedCountry.value.phoneCode}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: context.space.space_100),
                          // Phone Number Field
                          Expanded(
                            child: TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Enter Number',
                                prefixIcon: const Icon(Icons.phone),
                                hintText: selectedCountry.value.example,
                              ),
                              validator: (value) => validatePhoneNumber(
                                value,
                                '+${selectedCountry.value.phoneCode}',
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.space.space_200),
                    Padding(
                      padding: EdgeInsets.only(left: context.space.space_200),
                      child: Text(
                        "Enter Password",
                        style: context.typography.h3,
                      ),
                    ),
                    SizedBox(height: context.space.space_200),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.space.space_200),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible.value,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Enter Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              isPasswordVisible.value = !isPasswordVisible.value;
                            },
                          ),
                          hintText: 'Min. 6 characters with number and capital letter',
                        ),
                        validator: validatePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    SizedBox(height: context.space.space_200),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.space.space_200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlineButtonWidget(
                            label: 'Cancel',
                            onTap: () {
                              // Clear form and validation states
                              formKey.value.currentState?.reset();
                              phoneController.clear();
                              passwordController.clear();
                            },
                          ),
                          ButtonWidget(
                            label: loginState.isLoading ? "Logging in..." : "Login",
                            onTap: () async {
                              // Validate all form fields
                              if (formKey.value.currentState?.validate() ?? false) {
                                // Combine country code with phone number
                                final fullPhoneNumber = '+${selectedCountry.value.phoneCode}${phoneController.text}';
                                
                                // Proceed with login
                                await ref
                                    .read(authControllerProvider.notifier)
                                    .login(
                                      fullPhoneNumber,
                                      passwordController.text,
                                    );

                                // Check for specific error states
                                final authState = ref.read(authControllerProvider);
                                authState.whenOrNull(
                                  error: (error, stackTrace) {
                                    SnackbarUtil.showsnackbar(
                                      message: "Login Failed: Invalid Credentials",
                                      showretry: false,
                                    );
                                    log('Login error: $error');
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.space.space_200),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.space.space_200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: context.typography.bodyMedium
                                  .copyWith(color: context.colors.primaryTxt),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.push(SignupPage.route);
                            },
                            child: Text(
                              "Sign Up",
                              style: context.typography.bodyMedium
                                  .copyWith(color: context.colors.primaryTxt),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}