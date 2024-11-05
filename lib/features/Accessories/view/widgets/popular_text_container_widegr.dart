import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/gen/assets.gen.dart';

class PopularTextConainerWidget extends StatelessWidget {
  const PopularTextConainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.space.space_100),
      decoration: BoxDecoration(
        color: context.colors.yellow,
        borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            Assets.icons.icStars,
            height: context.space.space_200,
            width: context.space.space_200,
          ),
          SizedBox(
            width: context.space.space_100,
          ),
          Text(
            'Popular',
            style: context.typography.bodySemiBold
                .copyWith(color: const Color(0xff775600)),
          ),
        ],
      ),
    );
  }
}
