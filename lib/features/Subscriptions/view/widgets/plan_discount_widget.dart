import 'package:flutter/material.dart';

class PlanDiscountWidget extends StatelessWidget {
  final String number;
  final String plan;
  final String price;
  const PlanDiscountWidget({
    super.key, required this.number, required this.plan, required this.price,
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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
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
