import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/controller/location/location_list/location_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NearbyServiceList extends HookConsumerWidget {
  const NearbyServiceList({super.key});

  @override
  Widget build(BuildContext context,ref) {

    final showNearbyServices = useState(false);
    final servicesState = ref.watch(servicesNotifierProvider);


      if (servicesState.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (servicesState.services.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No services found nearby',
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
                  'Nearby Services',
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
            itemCount: servicesState.services.length,
            itemBuilder: (context, index) {
              final service = servicesState.services[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  leading: const Icon(Icons.store),
                  title: Text(service.name),
                  subtitle: Text(
                    '${service.distance.toStringAsFixed(1)} km away',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Handle service selection
                    // You might want to navigate to service details page
                  },
                ),
              );
            },
          ),
        ],
      );
  }
}

 

