import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/outline_button_widget.dart';
import 'package:hand_car/features/SpareParts/view/widgets/spare_brands_container_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';

class SpareMoreWidget extends HookWidget {
  final List<Map<String, String>> initialBrands = [
    {
      'image': Assets.icons.bremboLogo.path,
      'name': 'Brembo'
    },
    {
      'image': Assets.icons.fuchsLogo.path,
      'name': 'Fuchs'
    },
    {
      'image': Assets.icons.elringLogo.path,
      'name': 'Elring'
    },
  ];

  final List<Map<String, String>> moreBrands = [
    {
      'image': Assets.icons.densoLogo.path,
      'name': 'Denso'
    },
    {
      'image': Assets.icons.totalLogo.path,
      'name': 'Total'
    },
    {
      'image': Assets.icons.kybLogo.path,
      'name': 'KYB'
    },
    {
      'image': Assets.icons.mannLogo.path,
      'name': 'Mann'
    },
    {
      'image': Assets.icons.motulLogo.path,
      'name': 'Motul'
    },
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
              child: SpareBrandsContainerWidget(
                brandImage: brand['image']!,
                brandName: brand['name']!,
              ),
            )),
        if (showMoreBrands.value)
          ...moreBrands.map((brand) => Padding(
                padding: EdgeInsets.all(context.space.space_100),
                child: SpareBrandsContainerWidget(
                  brandImage: brand['image']!,
                  brandName: brand['name']!,
                ),
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