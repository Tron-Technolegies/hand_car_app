import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/gen/assets.gen.dart';

class DockingBar extends HookWidget {
  final int currentIndex;
  final Function(int) onTap;
  final BuildContext context;

  const DockingBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final animationCompleted = useState(false);
    final tweenController = useState(Tween<double>(begin: 1.0, end: 1.2));

    void handleTap(int index) {
      animationCompleted.value = false;
      tweenController.value = Tween(begin: 1.0, end: 1.2);
      onTap(index);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
          ],
        ),
        child: TweenAnimationBuilder(
          key: ValueKey(currentIndex),
          tween: tweenController.value,
          duration:
              Duration(milliseconds: animationCompleted.value ? 2000 : 200),
          curve: animationCompleted.value ? Curves.elasticOut : Curves.easeOut,
          onEnd: () {
            animationCompleted.value = true;
            tweenController.value = Tween(begin: 1.5, end: 1.0);
          },
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // _buildNavItem(
                //     'ic_car_seat', 'Accessories', 1, value, handleTap),
                _buildNavItem('ic_home', 'Home', 0, value, handleTap),
                _buildNavItem('ic_car_service', 'Service', 1, value, handleTap),
                _buildNavItem('ic_spare', 'Auto Parts', 2, value, handleTap),
                _buildNavItem('profile', 'Profile', 3, value, handleTap),

                // _buildNavItem(
                //     'ic_subscription', 'Subscription', 4, value, handleTap),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconName, String label, int index, double value,
      Function(int) onTapItem) {
    bool isSelected = currentIndex == index;
    String iconPath = isSelected
        ? 'assets/icons/${iconName}_filled.svg'
        : 'assets/icons/${iconName}_outline.svg';

    if (iconName == 'garage') {
      iconPath = isSelected ? Assets.icons.garageFilled : Assets.icons.garage;
    }

    return Transform(
      alignment: Alignment.bottomCenter,
      transform: Matrix4.identity()
        ..scale(isSelected ? value : 1.0)
        ..translate(0.0, isSelected ? 80.0 * (1 - value) : 0.0),
      child: GestureDetector(
        onTap: () => onTapItem(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    isSelected ? Colors.white : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 5)
                      ]
                    : null,
              ),
              child: SvgPicture.asset(
                iconPath,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isSelected
                      ? context.colors.primary
                      : context.colors.containerShadow,
                  BlendMode.srcIn,
                ),
              ),
            ),
            if (isSelected) const SizedBox(height: 4),
            Text(
              label,
              style: isSelected == true
                  ? context.typography.body.copyWith(
                      color: context.colors.primary,
                    )
                  : context.typography.body.copyWith(
                      color: context.colors.primaryTxt,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
