import 'dart:io';

import 'package:image_picker/image_picker.dart' as ip;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_picker_controller.g.dart';

/// Image Picker Controller
@riverpod
class ImagePicker extends _$ImagePicker {
  @override
  File? build() {
    return null;
  }

  final _picker = ip.ImagePicker();

/// Picks an image from the gallery.
  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ip.ImageSource.gallery);

    if (pickedFile != null) {
      state = File(pickedFile.path);
    }
    return null;
  }


  /// Clears the selected image.
 

}
