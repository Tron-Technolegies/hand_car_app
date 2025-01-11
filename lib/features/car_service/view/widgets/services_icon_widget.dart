import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

// Services Icon for Service Page Widget for Services Page
class ServicesIconsWidget extends StatelessWidget {
  final String image;
  final String title;
  final int selectedIndex;
  final Function(int) onSelectService;
  final bool isSelected;
  const ServicesIconsWidget({
    super.key,
    required this.image,
    required this.title,
    required this.selectedIndex,
    required this.onSelectService,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelectService(selectedIndex),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: context.space.space_50),
            decoration: BoxDecoration(
                color: isSelected
                    ? context.colors.primary
                    : context.colors.background,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.space.space_200,
                      vertical: context.space.space_150),
                  child: CircleAvatar(
                    backgroundColor: isSelected
                        ? context.colors.background
                        : context.colors.primary,
                    radius: 30,
                    child: SvgPicture.asset(
                      image,
                      colorFilter: ColorFilter.mode(
                        isSelected
                            ? context.colors.primary
                            : context.colors.background,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.space.space_200),
                  child: Text(
                    title,
                    style: isSelected
                        ? context.typography.bodyMedium.copyWith(
                            color: isSelected
                                ? context.colors.white
                                : context.colors.primaryTxt,
                          )
                        : context.typography.body.copyWith(
                            color: isSelected
                                ? context.colors.white
                                : context.colors.primaryTxt,
                          ),
                  ),
                ),
                SizedBox(height: context.space.space_150),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
