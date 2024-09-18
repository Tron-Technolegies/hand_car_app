import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class ServiceListWidget extends StatelessWidget {
  // A list of services that can be reused
  final List<String> services;

  const ServiceListWidget({
    super.key,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Allow the ListView to fit within its parent
      physics:
          const NeverScrollableScrollPhysics(), // Disable scrolling since it's wrapped
      itemCount: services.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: context.space.space_100),
          child: Row(
            children: [
              Icon(Icons.circle, color: context.colors.primaryTxt, size: 10),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  services[index],
                  style: context.typography.bodyMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
