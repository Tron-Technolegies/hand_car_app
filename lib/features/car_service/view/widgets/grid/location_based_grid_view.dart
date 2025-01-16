

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/controller/location/location_list/location_list.dart';
import 'package:hand_car/features/car_service/model/location/location_model.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:hand_car/features/car_service/view/widgets/grid_view_service_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocationBasedGridView extends HookConsumerWidget {
  final List<ServiceModel>services;
  final String categoryName;
  const LocationBasedGridView({super.key, required this.services, required this.categoryName});

  @override
  Widget build(BuildContext context,ref) {
    final servicesState = ref.watch(servicesNotifierProvider);
    final showNearbyServices = useState(false);


  if (servicesState.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (servicesState.error != null) {
        return Center(
          child: Text(
            servicesState.error!,
            style: context.typography.bodyLarge,
          ),
        );
      }

      final filteredByCategory = services
          .where((service) => service.serviceCategory == categoryName)
          .toList();

      if (filteredByCategory.isEmpty) {
        return Center(
          child: Text(
            'No $categoryName services available',
            style: context.typography.bodyLarge,
            textAlign: TextAlign.center,
          ),
        );
      }

      if (showNearbyServices.value && servicesState.services.isNotEmpty) {
        final nearbyServices = filteredByCategory.where((service) {
          return servicesState.services.any((nearbyService) =>
              nearbyService.name == service.vendorName &&
              nearbyService.distance <= 50);
        }).toList();

        if (nearbyServices.isEmpty) {
          return Center(
            child: Text(
              'No $categoryName services available in the selected location',
              style: context.typography.bodyLarge,
              textAlign: TextAlign.center,
            ),
          );
        }

        nearbyServices.sort((a, b) {
          final distanceA = servicesState.services
              .firstWhere(
                (s) => s.name == a.vendorName,
                orElse: () => const ServiceLocation(
                  name: '',
                  distance: double.infinity,
                  latitude: 0,
                  longitude: 0,
                ),
              )
              .distance;

          final distanceB = servicesState.services
              .firstWhere(
                (s) => s.name == b.vendorName,
                orElse: () => const ServiceLocation(
                  name: '',
                  distance: double.infinity,
                  latitude: 0,
                  longitude: 0,
                ),
              )
              .distance;

          return distanceA.compareTo(distanceB);
        });

        return GridViewServicesWidget(
          services: nearbyServices,
          locationServices: servicesState.services,
        );
      }

      return GridViewServicesWidget(
        services: filteredByCategory,
        locationServices: const [],
      );
  }
}

