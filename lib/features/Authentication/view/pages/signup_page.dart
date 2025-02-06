// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';
// import 'package:hand_car/core/utils/snackbar.dart';
// import 'package:hand_car/core/widgets/auth_field_widget.dart';
// import 'package:hand_car/core/widgets/button_widget.dart';
// import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
// import 'package:hand_car/features/Authentication/model/user_model.dart';
// import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
// import 'package:hand_car/gen/assets.gen.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class SignupPage extends HookConsumerWidget {
//   static const route = '/signup_page';
//   const SignupPage({super.key});

//   /// Function to validate phone number
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

//   /// Function to validate email

//   String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email is required';
//     }
//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     if (!emailRegex.hasMatch(value)) {
//       return 'Please enter a valid email address';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final nameController = useTextEditingController();
//     final emailController = useTextEditingController();
//     final phoneController = useTextEditingController();
//     final passwordController = useTextEditingController();
//     final formKey = useState(GlobalKey<FormState>());
//     final isLoading = useState(false);
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

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sign Up"),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => context.pop(),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(context.space.space_200),
//           child: Form(
//             key: formKey.value,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: SvgPicture.asset(Assets.icons.handCarIcon),
//                 ),
//                 SizedBox(height: context.space.space_200),
//                 // Name Input
//                 // _buildTextInput(
//                 //   context,
//                 //   controller: nameController,
//                 //   label: "Enter Your Name",
//                 //   icon: Icons.person,
//                 //   keyboardType: TextInputType.name,
//                 //   validator: (value) {
//                 //     if (value == null || value.isEmpty) {
//                 //       return 'Name is required';
//                 //     }
//                 //     return null;
//                 //   },
//                 // ),
//                 Text(" Name",
//                     style: context.typography.bodyLarge
//                         .copyWith(color: context.colors.primaryTxt)),
//                 SizedBox(height: context.space.space_100),
//                 AuthField(
//                     padding: EdgeInsets.all(context.space.space_200),
//                     controller: nameController,
//                     hintText: "Enter Your Name",
//                     keyboardType: TextInputType.name),
//                 SizedBox(height: context.space.space_200),
//                 // Email Input
//                 // _buildTextInput(
//                 //   context,
//                 //   controller: emailController,
//                 //   label: "Enter Your Email",
//                 //   icon: Icons.email,
//                 //   keyboardType: TextInputType.emailAddress,
//                 //   validator: validateEmail,
//                 // ),
//                 Text(" Email",
//                     style: context.typography.bodyLarge
//                         .copyWith(color: context.colors.primaryTxt)),
//                 SizedBox(height: context.space.space_100),
//                 AuthField(
//                   padding: EdgeInsets.all(context.space.space_200),
//                   controller: emailController,
//                   hintText: "Enter Your Email",
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 SizedBox(height: context.space.space_200),
//                 // Phone Input with Country Code
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
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
//                           // Phone Number Field
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
//                   ],
//                 ),
//                 SizedBox(height: context.space.space_200),
//                 // Password Input
//                 _buildTextInput(
//                   context,
//                   controller: passwordController,
//                   label: "Enter Password",
//                   icon: Icons.lock,
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Password is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: context.space.space_200),
//                 // Signup Button
//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: context.space.space_200),
//                   child: ButtonWidget(
//                     label: isLoading.value ? "Signing up..." : "Sign Up",
//                     onTap: () async {
//                       if (formKey.value.currentState?.validate() ?? false) {
//                         isLoading.value = true;
//                         FocusScope.of(context).unfocus();

//                         try {
//                           final fullPhoneNumber =
//                               '+${selectedCountry.value.phoneCode}${phoneController.text}';

//                           await ref
//                               .read(authControllerProvider.notifier)
//                               .signup(UserModel(
//                                   name: nameController.text,
//                                   email: emailController.text,
//                                   phone: fullPhoneNumber,
//                                   password: passwordController.text));

//                           if (context.mounted) {
//                             context.push(LoginWithPhoneAndPasswordPage.route);
//                           }
//                         } catch (error) {
//                           SnackbarUtil.showsnackbar(
//                             message: "Signup failed: $error",
//                             showretry: false,
//                           );
//                         } finally {}
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextInput(
//     BuildContext context, {
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     bool obscureText = false,
//     TextInputType keyboardType = TextInputType.text,
//     String? Function(String?)? validator,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(left: context.space.space_200),
//           child: Text(
//             label,
//             style: context.typography.h3,
//           ),
//         ),
//         SizedBox(height: context.space.space_200),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
//           child: TextFormField(
//             controller: controller,
//             keyboardType: keyboardType,
//             obscureText: obscureText,
//             decoration: InputDecoration(
//               border: const OutlineInputBorder(),
//               labelText: label,
//               prefixIcon: Icon(icon),
//             ),
//             validator: validator,
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/auth_field_widget.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hand_car/features/Authentication/view/widgets/phone_auth_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupPage extends HookConsumerWidget {
  static const route = '/signup_page';
  const SignupPage({super.key});

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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useState(GlobalKey<FormState>());
    final authState = ref.watch(authControllerProvider);
    final selectedCountryCode = useState('971');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.space.space_200),
          child: Form(
            key: formKey.value,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.space.space_200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child:
                        SvgPicture.asset(Assets.icons.handCarIcon, height: 70),
                  ),
                  SizedBox(height: context.space.space_200),
                  Center(
                      child: Text("Register Yourself",
                          style: context.typography.h2)),
                  SizedBox(height: context.space.space_500 * 2),
                  Text(
                    " Name",
                    style: context.typography.bodyLarge
                        .copyWith(color: context.colors.primaryTxt),
                  ),
                  SizedBox(height: context.space.space_200),
                  AuthField(
                    padding: EdgeInsets.all(context.space.space_200),
                    controller: nameController,
                    hintText: "Enter Your Name",
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: context.space.space_200),
                  Text(
                    " Email",
                    style: context.typography.bodyLarge
                        .copyWith(color: context.colors.primaryTxt),
                  ),
                  SizedBox(height: context.space.space_200),
                  AuthField(
                    padding: EdgeInsets.all(context.space.space_200),
                    controller: emailController,
                    hintText: "Enter Your Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                  ),
                  SizedBox(height: context.space.space_200),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " Phone Number",
                        style: context.typography.bodyLarge,
                      ),
                      SizedBox(height: context.space.space_200),
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
                    ],
                  ),
                  SizedBox(height: context.space.space_200),
                  Text(
                    " Password",
                    style: context.typography.bodyLarge
                        .copyWith(color: context.colors.primaryTxt),
                  ),
                  SizedBox(height: context.space.space_200),
                  AuthField(
                    controller: passwordController,
                    hintText: "Enter Your Password",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: context.space.space_200),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonWidget(
                      label: authState.isLoading
                          ? "Creating Account..."
                          : "Create Account",
                      onTap: () async {
                        // Inside your signup button onTap handler:
                        if (formKey.value.currentState?.validate() ?? false) {
                          try {
                            // Clean phone number
                            final cleanPhoneNumber = phoneController.text
                                .replaceAll(RegExp(r'[^\d]'), '');
                            final fullPhoneNumber =
                                '${selectedCountryCode.value}$cleanPhoneNumber';

                            ref.read(authControllerProvider.notifier).signup(
                                  UserModel(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    phone: fullPhoneNumber,
                                    password: passwordController.text,
                                  ),
                                );

                            if (context.mounted) {
                              SnackbarUtil.showsnackbar(
                                message: "Signup successful! Please login.",
                                showretry: false,
                              );
                              context.push(LoginWithPhoneAndPasswordPage.route);
                            }
                          } catch (error) {
                            SnackbarUtil.showsnackbar(
                              message: error.toString(),
                              showretry: false,
                            );
                          }
                        }
                      },
                    ),
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
