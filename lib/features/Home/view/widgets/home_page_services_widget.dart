import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/gen/assets.gen.dart';

class HomePageServicesContainerWidget extends StatelessWidget {
  const HomePageServicesContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
          height: 300,
          viewportFraction: 0.8,
          autoPlay: true,
          enableInfiniteScroll: true,
          reverse: true),
      itemCount: 3,
      itemBuilder: (context, index, realIndex) => Padding(
        padding: EdgeInsets.all(context.space.space_100),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: context.colors.white,
            ),
            padding: EdgeInsets.all(context.space.space_100),
            child: Column(children: [
              Image.asset(
                Assets.images.carTyreService.path,
                height: 180,
                width: 280,
              ),
              SizedBox(height: context.space.space_100),
              Text(
                'Car Tyre Services',
                style: context.typography.h3,
              )
            ])),
      ),
    );
  }
}
