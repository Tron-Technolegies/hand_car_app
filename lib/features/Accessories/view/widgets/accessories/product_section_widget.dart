import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class ProductSection extends StatelessWidget {
  final String title;
  final List<Widget> content;

  const ProductSection({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.space.space_100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.typography.h2),
          SizedBox(height: context.space.space_100),
          ...content,
        ],
      ),
    );
  }
}
