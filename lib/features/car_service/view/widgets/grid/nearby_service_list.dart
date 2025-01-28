import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/controller/location/location_list/location_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// lib/features/car_service/view/widgets/nearby_services_list.dart


class NearbyServiceList extends HookConsumerWidget {
  final double radius;

  const NearbyServiceList({
    super.key,
    this.radius = 20.0, // Default radius in kilometers
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showNearbyServices = useState(false);
    final servicesState = ref.watch(servicesNotifierProvider);

    if (servicesState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Get services within radius
    final nearbyServices = ref
        .read(servicesNotifierProvider.notifier)
        .getServicesWithinRadius(radius);

    if (nearbyServices.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'No services found within ${radius.toStringAsFixed(0)} km',
          style: context.typography.bodyMedium,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nearby Services (within ${radius.toStringAsFixed(0)} km)',
                style: context.typography.bodyLarge,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => showNearbyServices.value = false,
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: nearbyServices.length,
          itemBuilder: (context, index) {
            final service = nearbyServices[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                leading: const Icon(Icons.store),
                title: Text(service.vendorName),
                subtitle: service.distance != null
                    ? Text('${service.distance!.toStringAsFixed(1)} km away')
                    : null,
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Handle service selection
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

