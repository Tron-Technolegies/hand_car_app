import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

// A list of services that can be reused
class ServiceListWidget extends StatelessWidget {

  final List<String> services;

  const ServiceListWidget({
    super.key,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, 
      physics:
          const NeverScrollableScrollPhysics(), 
      itemCount: services.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: context.space.space_100),
          child: Row(
            children: [
              Icon(Icons.circle, color: context.colors.primaryTxt, size: 10),
               SizedBox(width: context.space.space_100),
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
