import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class ReviewItemsWidget extends StatelessWidget {
  final String username;
  final int rating;
  final String date;
  final String comment;
  final String review;

  const ReviewItemsWidget(
      {super.key,
      required this.username,
      required this.rating,
      required this.date,
      required this.comment,
      required this.review});

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
              Spacer(),
              SizedBox(width: context.space.space_100),
            ],
          ),
          SizedBox(height: context.space.space_100),
          Text(date),
          
          Row(
              children: List.generate(
                  5,
                  (index) => Icon(Icons.star,
                      color: index < rating ? Colors.amber : Colors.grey))),
          SizedBox(height: context.space.space_100),
          Text(
            comment,
            style: context.typography.bodySemiBold,
          ),
          SizedBox(height: context.space.space_100),
          Text(review, style: context.typography.body),
        ],
      ),
    );
  }
}
