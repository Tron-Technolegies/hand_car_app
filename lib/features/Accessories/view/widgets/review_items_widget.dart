import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class ReviewItemsWidget extends StatelessWidget {
  final String username;
  final int rating;
  final String date;
  final String comment;
  final String review;
  final List<String> images;

  const ReviewItemsWidget({
    super.key,
    required this.username,
    required this.rating,
    required this.date,
    required this.comment,
    required this.review,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(child: Text(username[0])),
              SizedBox(width: context.space.space_100),
              Text(username),
              const Spacer(),
              SizedBox(width: context.space.space_100),
            ],
          ),
          SizedBox(height: context.space.space_100),
          Text(date),
          SizedBox(height: context.space.space_100),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: index < rating ? Colors.amber : Colors.grey,
              ),
            ),
          ),
          SizedBox(height: context.space.space_100),
          Text(
            comment,
            style: context.typography.bodySemiBold,
          ),
          SizedBox(height: context.space.space_100),
          Text(review, style: context.typography.body),
          SizedBox(height: context.space.space_200),
          // Grid view for multiple images
          if (images.isNotEmpty)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.file(
                  File(images[index]),
                  fit: BoxFit.cover,
                );
              },
            ),
        ],
      ),
    );
  }
}