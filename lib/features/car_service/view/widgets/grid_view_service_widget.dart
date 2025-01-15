import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/model/location/location_model.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:hand_car/features/car_service/view/widgets/service_info_container_widget.dart';

// class GridViewServicesWidget extends StatelessWidget {
//   final List<ServiceModel> services;

//   const GridViewServicesWidget({
//     super.key,
//     required this.services,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       physics: const ClampingScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 340,
//         mainAxisSpacing: 0.5,
//         mainAxisExtent: 330,
//         crossAxisSpacing: 1.8,
//       ),
//       itemCount: services.length,
//       itemBuilder: (context, index) {
//         final service = services[index];
//         return Padding(
//           padding: EdgeInsets.all(context.space.space_100),
//           child: ServiceCardWidget(
//             service: service,
//           ),
//         );
//       },
//     );
//   }
// }

class GridViewServicesWidget extends StatelessWidget {
  final List<ServiceModel> services;
  final List<ServiceLocation> locationServices;

  const GridViewServicesWidget({
    super.key,
    required this.services,
    this.locationServices = const [],
  });

  String? _getDistance(String vendorName) {
    if (locationServices.isEmpty) return null;

    final locationService = locationServices.firstWhere(
      (service) => service.name == vendorName,
      orElse: () => const ServiceLocation(
        name: '',
        distance: double.infinity,
        latitude: 0,
        longitude: 0,
      ),
    );

    if (locationService.distance == double.infinity) return null;
    return '${locationService.distance.toStringAsFixed(1)} km';
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 340,
        mainAxisSpacing: 0.5,
        mainAxisExtent: 330,
        crossAxisSpacing: 1.8,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        final distance = _getDistance(service.vendorName);

        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your existing service card content
              // ...
              Padding(
                padding: EdgeInsets.all(context.space.space_100),
                child: ServiceCardWidget(
                  service: service,
                ),
              ),
              // Add distance if available
              if (distance != null)
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.space.space_200),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        distance,
                        style: context.typography.bodySmall,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
