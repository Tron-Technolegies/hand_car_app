import 'package:flutter/material.dart';
import 'package:hand_car/features/service/view/widgets/service_info_container_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';

class AccessoriesPage extends StatelessWidget {
  const AccessoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 10,
        maxCrossAxisExtent: 300,
        mainAxisExtent: 320,
        crossAxisSpacing: 0,
      ),
      itemCount: 2,
      itemBuilder: (context, index) => PaintSolutionCard(
        image: Assets.images.imgPainting1.path,
        title: 'ICON Rocklear ',
        title2: 'Paint Solution',
        rating: '4.0',
        price: '99',
      ),
    ));
  }
}
