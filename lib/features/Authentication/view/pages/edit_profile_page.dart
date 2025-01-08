import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/controller/image_picker_controller.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Authentication/view/widgets/profile_pic.dart';
import 'package:hand_car/features/Authentication/view/widgets/user_info_edit_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditProfileScreen extends HookConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isVisible = useState(false);
    final image = ref.watch(imagePickerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: context.colors.primary,
        foregroundColor: Colors.white,
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            ProfilePic(
              image: image?.path ??
                  "https://preview.redd.it/heres-an-edit-i-made-for-a-photo-of-lionel-messi-with-the-v0-vwdxofg2z77a1.png?auto=webp&s=4a900d4a5ce375edb3f943d9c3928d8537aa1880",
              imageUploadBtnPress: () {
                ref.read(imagePickerProvider.notifier).pickImage();
              },
            ),
            const Divider(),
            Form(
              child: Column(
                children: [
                  UserInfoEditField(
                    text: "Name",
                    child: TextFormField(
                      initialValue: "Leo messi",
                      decoration: InputDecoration(
                        filled: true,
                        // ignore: deprecated_member_use
                        fillColor:
                            Color.fromARGB(255, 226, 87, 83).withValues(alpha:0.05),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0 * 1.5, vertical: 16.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                  UserInfoEditField(
                    text: "Email",
                    child: TextFormField(
                      initialValue: "Tron@example.com",
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 226, 87, 83)
                            .withValues(alpha: 0.05),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0 * 1.5, vertical: 16.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                  UserInfoEditField(
                    text: "Phone",
                    child: TextFormField(
                      initialValue: "+971 50 000 0000",
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            Color.fromARGB(255, 226, 87, 83).withValues(alpha:0.05),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0 * 1.5, vertical: 16.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                  UserInfoEditField(
                    text: "Address",
                    child: TextFormField(
                      initialValue: "Abudhabi, Dubai, UAE",
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            Color.fromARGB(255, 226, 87, 83).withValues(alpha:0.05),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0 * 1.5, vertical: 16.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                  UserInfoEditField(
                    text: "Old Password",
                    child: TextFormField(
                      obscureText: isVisible.value,
                      initialValue: "demopass",
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(isVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            isVisible.value = !isVisible.value;
                          },
                        ),
                        filled: true,
                        fillColor:
                            Color.fromARGB(255, 226, 87, 83).withValues(alpha:0.05),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0 * 1.5, vertical: 16.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                  UserInfoEditField(
                    text: "New Password",
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "New Password",
                        filled: true,
                        fillColor:
                            // ignore: deprecated_member_use
                            Color.fromARGB(255, 226, 87, 83).withValues(alpha:0.05),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0 * 1.5, vertical: 16.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          // ignore: deprecated_member_use
                          .withValues(alpha:0.08),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 16.0),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.primaryTxt,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text("Save Update"),
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
