// import 'package:carousel_slider/carousel_options.dart';
// import 'package:flutter/material.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';

// class ProductSlidingWidget extends StatelessWidget {
//   const ProductSlidingWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider.builder(
//       itemCount: 3, // Number of containers in the carousel
//       itemBuilder: (context, index, realIndex) {
//         // List of gradient colors for each container
//         List<List<Color>> gradientColors = [
//           [const Color(0xff0069E4), const Color(0xff0053A1)], // Blue gradient
//           [const Color(0xff5ea249), const Color(0xff3b8c2a)], // Green gradient
//           [const Color(0xffdd605e), const Color(0xffba4b49)], // Red gradient
//         ];

//         // Return the CouponContainer with different gradient based on index
//         return CouponContainer(
//           couponName: "WEEKEND",
//           couponDescription: "10% off on all spare parts",
//           couponCode: "FLAT100",
//           couponImage: 'assets/images/accessories.png',
//           gradient: LinearGradient(
//             colors: gradientColors[index], // Pick the gradient colors by index
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           couponName2: "OFFER",
//         );
//       },
//       options: CarouselOptions(
//         height: context.space.space_100 * 25,
//         viewportFraction: 0.9,
//         autoPlay: true,
//         enableInfiniteScroll: true,
//         autoPlayInterval: const Duration(seconds: 4),
//       ),
//     );;
//   }
// }