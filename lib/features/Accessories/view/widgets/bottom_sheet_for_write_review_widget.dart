import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hand_car/core/controller/image_picker_controller.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomSheetForWriteReview extends ConsumerWidget {
  const BottomSheetForWriteReview({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          SizedBox(
            height: context.space.space_200,
          ),
          Center(
            child: Text(
              'Write a review',
              style: context.typography.h3
                  .copyWith(color: context.colors.primaryTxt),
            ),
          ),
          SizedBox(height: context.space.space_200),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: context.colors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: context.space.space_200,
                vertical: context.space.space_200),
            child: const TextField(
                maxLines: null,
                minLines: null,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                  hintText: 'Write your review here..',
                  border: InputBorder.none,
                )),
          ),
          TextButton.icon(
              onPressed: () {
                ref.read(imagePickerProvider.notifier).pickImage();
              },
              icon: const Icon(
                Icons.attachment_outlined,
                color: Color(0xff005DCB),
                size: 25,
              ),
              label: Text(
                "Add images",
                style: context.typography.bodyMedium
                    .copyWith(color: const Color(0xff005DCB)),
              )),
          SizedBox(
            height: context.space.space_200,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
            child: SizedBox(
                width: double.infinity,
                child: ButtonWidget(label: "Submit Review", onTap: () {})),
          ),
          SizedBox(
            height: context.space.space_200,
          )
        ]));
  }
}
