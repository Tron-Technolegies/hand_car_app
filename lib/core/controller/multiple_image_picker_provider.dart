import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'multiple_image_picker_provider.freezed.dart';

part 'multiple_image_picker_provider.g.dart';

//MultipleImagePicker

@freezed
class MultipleImagePickerState with _$MultipleImagePickerState {
  const factory MultipleImagePickerState({
    required List<XFile> selectedImages,
  }) = _MultipleImagePickerState;
}

@riverpod
//multiple image picker
class MultipleImagePicker extends _$MultipleImagePicker {
  @override
  MultipleImagePickerState build() {
    return const MultipleImagePickerState(selectedImages: []);
  }

  void pickImages() async {
    final List<XFile> images = await ImagePicker().pickMultiImage();
    if (images.isNotEmpty) {
      state = MultipleImagePickerState(selectedImages: images);
    }
  }
}
