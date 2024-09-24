import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/gen/assets.gen.dart';

class SpareBrandsWidget extends StatelessWidget {
  const SpareBrandsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: EdgeInsets.all(context.space.space_100),
            child:
                Image.asset(Assets.icons.boschLogo.path, height: 50, width: 80),
          ),
          Padding(
            padding: EdgeInsets.all(context.space.space_100),
            child:
                Image.asset(Assets.icons.pwrLogo.path, height: 50, width: 80),
          ),
          Padding(
            padding: EdgeInsets.all(context.space.space_100),
            child: Image.asset(Assets.icons.nissensLogo.path,
                height: 50, width: 80),
          ),
          Padding(
            padding: EdgeInsets.all(context.space.space_100),
            child:
                Image.asset(Assets.icons.densoLogo.path, height: 50, width: 80),
          ),
          Padding(
            padding: EdgeInsets.all(context.space.space_100),
            child:
                Image.asset(Assets.icons.mahleLogo.path, height: 50, width: 80),
          ),
        ],
      ),
    );
  }
}
