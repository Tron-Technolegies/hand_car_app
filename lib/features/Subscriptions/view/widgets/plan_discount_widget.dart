import 'package:flutter/material.dart';

class PlanDiscountWidget extends StatelessWidget {
  final String number;
  final String plan;
  final String price;
  final Color color;
  const PlanDiscountWidget({
    super.key, required this.number, required this.plan, required this.price, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(plan)),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
