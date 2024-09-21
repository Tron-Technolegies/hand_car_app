import 'package:flutter/material.dart';

class SparesPage extends StatelessWidget {
  static const String routeName = 'spares';
  const SparesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Spares Page'),),
    );
  }
}