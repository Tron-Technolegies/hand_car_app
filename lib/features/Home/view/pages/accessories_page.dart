import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AccessoriesPage extends StatelessWidget {
  const AccessoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Lottie.asset('assets/animations/car_wash.json'),),
    );
  }
}