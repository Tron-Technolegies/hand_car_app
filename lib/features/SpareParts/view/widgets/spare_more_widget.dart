import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/outline_button_widget.dart';
import 'package:hand_car/features/SpareParts/view/widgets/spare_brands_container_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';

class SpareMoreWidget extends HookWidget {
  final List<String> initialBrands = [
    Assets.icons.bremboLogo.path,
    Assets.icons.fuchsLogo.path,
    Assets.icons.elringLogo.path,
  ];
  final List<String> moreBrands = [
    Assets.icons.densoLogo.path,
    Assets.icons.totalLogo.path,
    Assets.icons.kybLogo.path,
    Assets.icons.mannLogo.path,
    Assets.icons.motulLogo.path,
  ];

  SpareMoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final showMoreBrands = useState(false);

    return Column(
      children: [
        Text(
          'Find spare parts from top brands',
          style: context.typography.h3,
        ),
        SizedBox(height: context.space.space_200),
        ...initialBrands.map((brand) => Padding(
              padding: EdgeInsets.all(context.space.space_100),
              child: SpareBrandsContainerWidget(brandImage: brand),
            )),
        if (showMoreBrands.value)
          ...moreBrands.map((brand) => Padding(
                padding: EdgeInsets.all(context.space.space_100),
                child: SpareBrandsContainerWidget(brandImage: brand),
              )),
        SizedBox(height: context.space.space_200),
        if (!showMoreBrands.value)
          OutlineButtonWidget(
              label: "Show more brands",
              onTap: () {
                showMoreBrands.value = true;
              })
      ],
    );
  }
}
