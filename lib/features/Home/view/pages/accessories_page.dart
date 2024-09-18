import 'package:flutter/material.dart';

class AccessoriesPage extends StatelessWidget {
  const AccessoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessories'),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),   )))
    );
  }
}
