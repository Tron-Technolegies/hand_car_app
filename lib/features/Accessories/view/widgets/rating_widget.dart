// // import 'package:flutter/material.dart';

// // class RatingUI extends StatelessWidget {
// //   final List<Rating> ratings = [
// //     Rating(5, 0.7),
// //     Rating(4, 0.2),
// //     Rating(3, 0.05),
// //     Rating(2, 0.03),
// //     Rating(1, 0.02),
// //   ];

// //    RatingUI({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text('Based on 210 reviews', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// //             SizedBox(height: 20),
// //             ...ratings.map((rating) => Padding(
// //               padding: const EdgeInsets.symmetric(vertical: 4.0),
// //               child: Row(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   Text('${rating.stars} ', style: TextStyle(fontSize: 16)),
// //                   Icon(Icons.star, color: Colors.amber, size: 24),
// //                   SizedBox(width: 10),
// //                   Stack(
// //                     children: [
// //                       Container(
// //                         width: 200,
// //                         height: 10,
// //                         decoration: BoxDecoration(
// //                           color: Colors.grey[300],
// //                           borderRadius: BorderRadius.circular(5),
// //                         ),
// //                       ),
// //                       Container(
// //                         width: 200 * rating.percentage,
// //                         height: 10,
// //                         decoration: BoxDecoration(
// //                           color: Colors.amber,
// //                           borderRadius: BorderRadius.circular(5),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             )).toList(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// // class Rating {
// //   final int stars;
// //   final double percentage;

// //   Rating(this.stars, this.percentage);
// // }
// import 'package:flutter/material.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';

// class ProductRatingsWidget extends StatelessWidget {
//   final double rating;
//   final int totalReviews;
//   final List<int> starCounts;

//   const ProductRatingsWidget({
//     super.key,
//     required this.rating,
//     required this.totalReviews,
//     required this.starCounts,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Product Ratings & Reviews',
//             style: context.typography.h3,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Have a review about this product?',
//             style: context.typography.bodyLargeMedium,
//           ),
//           SizedBox(height: context.space.space_100),
//           GestureDetector(
//             onTap: () {},
//             child: Text(
//               "Write here...",
//               style: context.typography.bodyLargeMedium.copyWith(
//                 color: Color(0xff4069D8),
//               ),
//             ),
//           ),
//           SizedBox(height: context.space.space_100),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 rating.toStringAsFixed(1),
//                 style: context.typography.h1,
//               ),
//               const SizedBox(width: 8),
//               Row(
//                 children: List.generate(
//                   5,
//                   (index) => Icon(
//                     index < rating.floor() ? Icons.star : Icons.star_border,
//                     color: Colors.amber,
//                     size: 24,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             'Based on $totalReviews reviews',
//             style: context.typography.subtitle,
//           ),
//           const SizedBox(height: 16),
//           ...List.generate(
//             5,
//             (index) => _buildStarBar(5 - index, starCounts[4 - index]),
//           ).reversed,
//         ],
//       ),
//     );
//   }

//   Widget _buildStarBar(int stars, int count) {
//     final percentage = count / totalReviews;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 16,
//             child: Text('$stars', style: TextStyle(fontSize: 12)),
//           ),
//           Icon(Icons.star, size: 16, color: Colors.amber),
//           const SizedBox(width: 8),
//           Expanded(
//             child: LinearProgressIndicator(
//               value: percentage,
//               backgroundColor: Colors.grey[300],
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//             ),
//           ),
//           const SizedBox(width: 8),
//           SizedBox(
//             width: 32,
//             child: Text(
//               '${(percentage * 100).toInt()}%',
//               style: TextStyle(fontSize: 12),
//               textAlign: TextAlign.end,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class ProductRatingsWidget extends StatelessWidget {
  final double rating;
  final int totalReviews;
  final List<int> starCounts;

  const ProductRatingsWidget({
    Key? key,
    required this.rating,
    required this.totalReviews,
    required this.starCounts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Ratings & Reviews',
            style: context.typography.h3,
          ),
          SizedBox(height: context.space.space_100),
          Text(
            'Have a review about this product?',
            style: context.typography.bodyLargeMedium,
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "Write here...",
                style: context.typography.bodyLargeMedium.copyWith(
                  color: Color(0xff4069D8),
                ),
              )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: context.typography.h3,
              ),
              const SizedBox(width: 8),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating.floor() ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.space.space_100),
          Text(
            'Based on $totalReviews reviews',
            style: context.typography.subtitle,
          ),
          const SizedBox(height: 16),
          ...List.generate(
            5,
            (index) => _buildStarBar(5 - index, starCounts[4 - index]),
          ),
        ],
      ),
    );
  }

  Widget _buildStarBar(int stars, int count) {
    final percentage = count / totalReviews;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 16,
            child: Text('$stars', style: TextStyle(fontSize: 12)),
          ),
          Icon(Icons.star, size: 16, color: Colors.amber),
          const SizedBox(width: 8),
          Expanded(
            child: CustomPaint(
              size: Size(double.infinity, 8),
              painter: MultiColorProgressPainter(
                percentage: percentage,
                backgroundColor: Colors.grey[300]!,
                progressColor: stars >= 4 ? Colors.green : Colors.orange,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 32,
            child: Text(
              '${(percentage * 100).toInt()}%',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class MultiColorProgressPainter extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;

  MultiColorProgressPainter({
    required this.percentage,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.fill;

    final Radius radius = Radius.circular(size.height / 2);

    // Draw background
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        radius,
      ),
      backgroundPaint,
    );

    // Draw progress
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width * percentage, size.height),
        radius,
      ),
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
