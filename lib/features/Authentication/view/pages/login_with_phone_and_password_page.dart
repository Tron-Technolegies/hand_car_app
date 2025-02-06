// import 'dart:developer';
// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hand_car/core/router/router.dart';
// import 'package:hand_car/core/widgets/outline_button_widget.dart';
// import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
// import 'package:hand_car/features/Authentication/view/pages/forgot_password_page.dart';
// import 'package:hand_car/features/Authentication/view/pages/login_page.dart';
// import 'package:hand_car/features/Authentication/view/pages/signup_page.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';
// import 'package:hand_car/core/utils/snackbar.dart';
// import 'package:hand_car/core/widgets/button_widget.dart';
// import 'package:hand_car/gen/assets.gen.dart';

// /// LoginWithPhoneAndPasswordPage handles user authentication using phone number and password
// /// It also provides options to switch to OTP-based login, reset password, and sign up
// class LoginWithPhoneAndPasswordPage extends HookConsumerWidget {
//   static const route = '/LoginWithPhoneAndPasswordPage';

//   const LoginWithPhoneAndPasswordPage({super.key});

//   /// Validates phone number based on country code
//   /// Returns error message string if validation fails, null otherwise
//   String? validatePhoneNumber(String? value, String countryCode) {
//     if (value == null || value.isEmpty) {
//       return 'Phone number is required';
//     }

//     // Remove any non-digit characters
//     final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

//     // Check if the number has the correct length based on country
//     switch (countryCode) {
//       case '+91': // India
//         if (digitsOnly.length != 10) {
//           return 'Phone number must be 10 digits';
//         }
//         if (!digitsOnly.startsWith(RegExp(r'[6-9]'))) {
//           return 'Phone number must start with 6-9';
//         }
//         break;
//       case '+1': // USA/Canada
//         if (digitsOnly.length != 10) {
//           return 'Phone number must be 10 digits';
//         }
//         break;
//       default:
//         if (digitsOnly.length < 8 || digitsOnly.length > 15) {
//           return 'Invalid phone number length';
//         }
//     }

//     return null;
//   }

//   /// Validates password
//   /// Returns error message string if validation fails, null otherwise
//   String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password is required';
//     }
//     if (value.length < 6) {
//       return 'Password must be at least 6 characters';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Form controllers and state
//     final phoneController = useTextEditingController();
//     final passwordController = useTextEditingController();
//     final formKey = useState(GlobalKey<FormState>());
//     final isPasswordVisible = useState(false);

//     // Default country selection (India)
//     final selectedCountry = useState<Country>(Country(
//       phoneCode: '91',
//       countryCode: 'IN',
//       e164Sc: 0,
//       geographic: true,
//       level: 1,
//       name: 'India',
//       example: '9123456789',
//       displayName: 'India (IN) [+91]',
//       displayNameNoCountryCode: 'India (IN)',
//       e164Key: '',
//     ));

//     // Watch auth state for loading and errors
//     final loginState = ref.watch(authControllerProvider);

//     /// Handles switching to OTP login
//     void switchToOtpLogin() async {
//       // Update login preference in storage
//       final storage = ref.read(storageProvider);
//       await storage.write('preferredLoginMethod', LoginPage.route);

//       // Update login preference state
//       ref.read(loginPreferenceProvider.notifier).state = LoginPage.route;

//       // Navigate to OTP login page
//       if (context.mounted) {
//         context.go(LoginPage.route);
//       }
//     }

//     /// Handles the login process
//     Future<void> handleLogin() async {
//       // Validate form fields
//       if (formKey.value.currentState?.validate() ?? false) {
//         // Combine country code with phone number
//         final fullPhoneNumber =
//             '+${selectedCountry.value.phoneCode}${phoneController.text}';

//         try {
//           // Attempt login
//           await ref.read(authControllerProvider.notifier).login(
//                 fullPhoneNumber,
//                 passwordController.text,
//               );

//           // Handle specific error states
//           final authState = ref.read(authControllerProvider);
//           authState.whenOrNull(
//             error: (error, stackTrace) {
//               if (error.toString().contains('Invalid login credentials')) {
//                 SnackbarUtil.showsnackbar(
//                   message: "Account doesn't exist. Please sign up first.",
//                   showretry: true,
//                 );
//               } else if (error.toString().contains('Invalid password')) {
//                 SnackbarUtil.showsnackbar(
//                   message: "Invalid password. Please try again.",
//                   showretry: false,
//                 );
//               } else {
//                 SnackbarUtil.showsnackbar(
//                   message: "Login failed. Please try again.",
//                   showretry: false,
//                 );
//               }
//               log('Login error: $error');
//               log('Stack trace: $stackTrace');
//             },
//             data: (_) {
//               SnackbarUtil.showsnackbar(
//                 message: "Login Successful",
//                 showretry: false,
//               );
//             },
//           );
//         } catch (e) {
//           log('Unexpected error during login: $e');
//         }
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Login"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 400),
//             child: Padding(
//               padding: EdgeInsets.all(context.space.space_200),
//               child: Form(
//                 key: formKey.value,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Logo
//                     Center(
//                       child: SvgPicture.asset(Assets.icons.handCarIcon),
//                     ),
//                     SizedBox(height: context.space.space_200),

//                     // Quick OTP Login Option

//                     SizedBox(height: context.space.space_200),

//                     // Phone Number Section
//                     Padding(
//                       padding: EdgeInsets.only(left: context.space.space_200),
//                       child: Text(
//                         "Enter Your Phone Number",
//                         style: context.typography.h3,
//                       ),
//                     ),
//                     SizedBox(height: context.space.space_200),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: context.space.space_200),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Country Code Selector
//                           Container(
//                             height: 60,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             child: InkWell(
//                               onTap: () {
//                                 showCountryPicker(
//                                   context: context,
//                                   showPhoneCode: true,
//                                   onSelect: (Country country) {
//                                     selectedCountry.value = country;
//                                   },
//                                 );
//                               },
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 8.0),
//                                 child: Center(
//                                   child: Text(
//                                     '+${selectedCountry.value.phoneCode}',
//                                     style: const TextStyle(fontSize: 16),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: context.space.space_100),

//                           // Phone Number Input
//                           Expanded(
//                             child: TextFormField(
//                               controller: phoneController,
//                               keyboardType: TextInputType.phone,
//                               decoration: InputDecoration(
//                                 border: const OutlineInputBorder(),
//                                 labelText: 'Enter Number',
//                                 prefixIcon: const Icon(Icons.phone),
//                                 hintText: selectedCountry.value.example,
//                               ),
//                               validator: (value) => validatePhoneNumber(
//                                 value,
//                                 '+${selectedCountry.value.phoneCode}',
//                               ),
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Password Section
//                     SizedBox(height: context.space.space_200),
//                     Padding(
//                       padding: EdgeInsets.only(left: context.space.space_200),
//                       child: Text(
//                         "Enter Password",
//                         style: context.typography.h3,
//                       ),
//                     ),
//                     SizedBox(height: context.space.space_200),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: context.space.space_200),
//                       child: TextFormField(
//                         controller: passwordController,
//                         obscureText: !isPasswordVisible.value,
//                         decoration: InputDecoration(
//                           border: const OutlineInputBorder(),
//                           labelText: 'Enter Password',
//                           prefixIcon: const Icon(Icons.lock),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               isPasswordVisible.value
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                             ),
//                             onPressed: () {
//                               isPasswordVisible.value =
//                                   !isPasswordVisible.value;
//                             },
//                           ),
//                           hintText:
//                               'Min. 6 characters with number and capital letter',
//                         ),
//                         validator: validatePassword,
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                       ),
//                     ),

//                     // Action Buttons
//                     SizedBox(height: context.space.space_200),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: context.space.space_200),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           OutlineButtonWidget(
//                             label: 'Cancel',
//                             onTap: () {
//                               formKey.value.currentState?.reset();
//                               phoneController.clear();
//                               passwordController.clear();
//                             },
//                           ),
//                           ButtonWidget(
//                             label: loginState.isLoading
//                                 ? "Logging in..."
//                                 : "Login",
//                             onTap: () {
//                               if (!loginState.isLoading) {
//                                 handleLogin();
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Additional Options
//                     SizedBox(height: context.space.space_200),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: context.space.space_200),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           TextButton(
//                             onPressed: () =>
//                                 context.push(ForgotPasswordPage.route),
//                             child: Text(
//                               "Forgot Password?",
//                               style: context.typography.bodyMedium.copyWith(
//                                 color: context.colors.primaryTxt,
//                               ),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () => context.push(SignupPage.route),
//                             child: Text(
//                               "Sign Up",
//                               style: context.typography.bodyMedium.copyWith(
//                                 color: context.colors.primaryTxt,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Alternative Login Option
//                     SizedBox(height: context.space.space_200),
//                     Row(
//                       children: [
//                         const Expanded(child: Divider()),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: context.space.space_200),
//                           child: Text(
//                             'OR',
//                             style: context.typography.bodyMedium.copyWith(
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                         const Expanded(child: Divider()),
//                       ],
//                     ),
//                     SizedBox(height: context.space.space_200),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: context.space.space_200),
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: OutlineButtonWidget(
//                           label: 'Login with OTP',
//                           onTap: switchToOtpLogin,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/router/router.dart';
import 'package:hand_car/core/widgets/outline_button_widget.dart';
import 'package:hand_car/core/widgets/auth_field_widget.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/view/pages/forgot_password_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_page.dart';
import 'package:hand_car/features/Authentication/view/pages/signup_page.dart';
import 'package:hand_car/features/Authentication/view/widgets/phone_auth_widget.dart';
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

    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length < 8 || digitsOnly.length > 15) {
      return 'Invalid phone number length';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useState(GlobalKey<FormState>());
    final isPasswordVisible = useState(false);
    final selectedCountryCode = useState('971'); // Default to UAE

    final loginState = ref.watch(authControllerProvider);

    void switchToOtpLogin() async {
      final storage = ref.read(storageProvider);
      await storage.write('preferredLoginMethod', LoginPage.route);
      ref.read(loginPreferenceProvider.notifier).state = LoginPage.route;
      if (context.mounted) {
        context.go(LoginPage.route);
      }
    }

    Future<void> handleLogin() async {
      if (formKey.value.currentState?.validate() ?? false) {
        try {
          final cleanPhoneNumber =
              phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
          final fullPhoneNumber =
              '${selectedCountryCode.value}$cleanPhoneNumber';

          await ref.read(authControllerProvider.notifier).login(
                fullPhoneNumber,
                passwordController.text,
              );

          final authState = ref.read(authControllerProvider);
          authState.whenOrNull(
            error: (error, stackTrace) {
              if (error.toString().contains('Invalid login credentials')) {
                SnackbarUtil.showsnackbar(
                  message: "Account doesn't exist. Please sign up first.",
                  showretry: true,
                );
              } else if (error.toString().contains('Invalid password')) {
                SnackbarUtil.showsnackbar(
                  message: "Invalid password. Please try again.",
                  showretry: false,
                );
              } else {
                SnackbarUtil.showsnackbar(
                  message: "Login failed. Please try again.",
                  showretry: false,
                );
              }
              log('Login error: $error');
              log('Stack trace: $stackTrace');
            },
            data: (_) {
              SnackbarUtil.showsnackbar(
                message: "Login Successful",
                showretry: false,
              );
            },
          );
        } catch (e) {
          log('Unexpected error during login: $e');
        }
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        // Center the entire content
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.symmetric(
              horizontal: context.space.space_200,
              vertical: context.space.space_300,
            ),
            child: Form(
              key: formKey.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo section
                  Center(
                    child: SvgPicture.asset(
                      Assets.icons.handCarIcon,
                      height: 80, // Fixed height for consistency
                    ),
                  ),
                  SizedBox(height: context.space.space_300),

                  // Welcome text
                  Center(
                    child: Text(
                      "Welcome to Hand Car",
                      style: context.typography.h2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: context.space.space_200),
                  Center(
                    child: Text(
                      "Let’s Sign you in",
                      style: context.typography.h3,
                    ),
                  ),
                  SizedBox(height: context.space.space_300),

                  // Phone number section
                  Text(
                    "Phone Number",
                    style: context.typography.bodyLarge
                        .copyWith(color: context.colors.primaryTxt),
                  ),
                  SizedBox(height: context.space.space_150),
                  PhoneAuthField(
                    controller: phoneController,
                    onCountryChanged: (countryCode) {
                      selectedCountryCode.value = countryCode;
                    },
                    validator: (value) => validatePhoneNumber(
                      value,
                      selectedCountryCode.value,
                    ),
                  ),
                  SizedBox(height: context.space.space_250),

                  // Password section
                  Text(
                    "Password",
                    style: context.typography.bodyLarge
                        .copyWith(color: context.colors.primaryTxt),
                  ),
                  SizedBox(height: context.space.space_150),
                  AuthField(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.space.space_200,
                      vertical: context.space.space_150,
                    ),
                    controller: passwordController,
                    hintText: "Enter Your Password",
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: !isPasswordVisible.value,
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
                    validator: validatePassword,
                  ),
                  SizedBox(height: context.space.space_300),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Changed from spaceAround
                    children: [
                      Expanded(
                        // Added Expanded
                        child: OutlineButtonWidget(
                          label: 'Cancel',
                          onTap: () {
                            formKey.value.currentState?.reset();
                            phoneController.clear();
                            passwordController.clear();
                          },
                        ),
                      ),
                      SizedBox(width: context.space.space_200),
                      Expanded(
                        // Added Expanded
                        child: ButtonWidget(
                          label:
                              loginState.isLoading ? "Logging in..." : "Login",
                          onTap: () {
                            if (!loginState.isLoading) {
                              handleLogin();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.space.space_250),

                  // Additional options
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end, // Changed from spaceAround
                    children: [
                      TextButton(
                        onPressed: () => context.push(ForgotPasswordPage.route),
                        child: Text(
                          "Forgot Password?",
                          style: context.typography.bodyMedium.copyWith(
                            color: context.colors.primaryTxt,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.space.space_250),

                  // Divider section
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.space.space_200,
                        ),
                        child: Text(
                          'OR',
                          style: context.typography.bodyMedium.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: context.space.space_250),

                  // OTP login button
                  SizedBox(
                    width: double.infinity,
                    child: OutlineButtonWidget(
                      label: 'Login with OTP',
                      onTap: switchToOtpLogin,
                    ),
                  ),
                  SizedBox(height: context.space.space_250),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () => context.push(SignupPage.route),
                        child: Text("Sign Up",
                            style: context.typography.bodyMedium
                                .copyWith(color: context.colors.warning)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
