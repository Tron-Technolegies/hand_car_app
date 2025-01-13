import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class MapUIMockup extends StatelessWidget {
  const MapUIMockup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Map Container
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha:0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Map placeholder
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage('assets/images/map_placeholder.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Location input fields
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    // Start location field
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha:0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: context.colors.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: 'Enter pickup location',
                                border: InputBorder.none,
                                hintStyle: context.typography.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // End location field
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: context.colors.warning),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: 'Enter destination',
                                border: InputBorder.none,
                                hintStyle: context.typography.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Action buttons
              Positioned(
                right: 16,
                bottom: 16,
                child: Column(
                  children: [
                    FloatingActionButton(
                      heroTag: 'currentLocation',
                      onPressed: () {},
                      child: const Icon(Icons.my_location),
                    ),
                    const SizedBox(height: 8),
                    FloatingActionButton(
                      heroTag: 'confirm',
                      onPressed: () {},
                      backgroundColor: context.colors.primary,
                      child: const Icon(Icons.check),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Trip details card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Estimated Distance', 
                    style: context.typography.bodyMedium),
                  Text('0.0 km', 
                    style: context.typography.bodySemiBold),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Estimated Time', 
                    style: context.typography.bodyMedium),
                  Text('0 min', 
                    style: context.typography.bodySemiBold),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}