import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/controller/location/location_list/location_list.dart';
import 'package:hand_car/features/car_service/controller/rating/rating_filter/rating_filter.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:hand_car/features/car_service/view/widgets/grid_view_service_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// class LocationBasedGridView extends HookConsumerWidget {
//   final List<ServiceModel> services;
//   final String categoryName;

//   const LocationBasedGridView({
//     super.key,
//     required this.services,
//     required this.categoryName,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final servicesState = ref.watch(servicesNotifierProvider);
//     // final showNearbyServices = useState(false);

//     // Filter services by category
//     final filteredByCategory = services
//         .where((service) => service.serviceCategory == categoryName)
//         .toList();

//     if (servicesState.isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (servicesState.error != null) {
//       return Center(
//         child: Text(
//           servicesState.error!,
//           style: context.typography.bodyLarge,
//         ),
//       );
//     }

//     // If we have nearby services, filter and sort them
//     if (servicesState.services.isNotEmpty) {
//       final nearbyServices = filteredByCategory.where((service) {
//         final matchingService = servicesState.services.firstWhere(
//           (nearbyService) => nearbyService.vendorName == service.vendorName,
//           orElse: () => service,
//         );
//         return matchingService.distance != null;
//       }).toList();

//       // Sort by distance
//       nearbyServices.sort((a, b) {
//         final distanceA = servicesState.services
//                 .firstWhere(
//                   (s) => s.vendorName == a.vendorName,
//                   orElse: () => a,
//                 )
//                 .distance ??
//             double.infinity;

//         final distanceB = servicesState.services
//                 .firstWhere(
//                   (s) => s.vendorName == b.vendorName,
//                   orElse: () => b,
//                 )
//                 .distance ??
//             double.infinity;

//         return distanceA.compareTo(distanceB);
//       });

//       if (nearbyServices.isEmpty) {
//         return Center(
//           child: Text(
//             'No $categoryName services available in the selected location',
//             style: context.typography.bodyLarge,
//             textAlign: TextAlign.center,
//           ),
//         );
//       }

//       return GridViewServicesWidget(
//         services: nearbyServices,
//         locationServices: servicesState.services,
//       );
//     }

//     // If no location selected or no nearby services, show all services
//     if (filteredByCategory.isEmpty) {
//       return Center(
//         child: Text(
//           'No $categoryName services available',
//           style: context.typography.bodyLarge,
//           textAlign: TextAlign.center,
//         ),
//       );
//     }

//     return GridViewServicesWidget(
//       services: filteredByCategory,
//       locationServices: const [],
//     );
//   }
// }

class LocationBasedGridView extends HookConsumerWidget {
  final List<ServiceModel> services;
  final String categoryName;

  const LocationBasedGridView({
    super.key,
    required this.services,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesState = ref.watch(servicesNotifierProvider);
    final selectedRating = ref.watch(ratingFilterControllerProvider);

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

    // Filter services by category and rating
    List<ServiceModel> filteredServices = services
        .where((service) => service.serviceCategory == categoryName)
        .where((service) {
          if (selectedRating == null) return true;
          if (service.rate == null) return false;
          double normalizedRate = service.rate! > 5 ? service.rate! / 1000 : service.rate!;
          return normalizedRate >= selectedRating;
        }).toList();

    // Handle nearby services
    if (servicesState.services.isNotEmpty) {
      final nearbyServices = filteredServices.where((service) {
        return servicesState.services.any((s) => 
          s.vendorName == service.vendorName && s.distance != null);
      }).toList();

      nearbyServices.sort((a, b) {
        if (selectedRating != null) {
          final rateA = (a.rate ?? 0) > 5 ? (a.rate ?? 0) / 1000 : (a.rate ?? 0);
          final rateB = (b.rate ?? 0) > 5 ? (b.rate ?? 0) / 1000 : (b.rate ?? 0);
          final rateComparison = rateB.compareTo(rateA);
          if (rateComparison != 0) return rateComparison;
        }

        final distanceA = _getServiceDistance(a, servicesState.services);
        final distanceB = _getServiceDistance(b, servicesState.services);
        return distanceA.compareTo(distanceB);
      });

      if (nearbyServices.isEmpty) {
        return Center(
          child: Text(
            selectedRating != null 
              ? 'No $categoryName services with ${selectedRating.toInt()}+ stars nearby'
              : 'No $categoryName services available nearby',
            style: context.typography.bodyLarge,
            textAlign: TextAlign.center,
          ),
        );
      }

      return GridViewServicesWidget(
        services: nearbyServices,
        locationServices: servicesState.services,
      );
    }

    // Handle non-nearby services
    filteredServices.sort((a, b) {
      final rateA = (a.rate ?? 0) > 5 ? (a.rate ?? 0) / 1000 : (a.rate ?? 0);
      final rateB = (b.rate ?? 0) > 5 ? (b.rate ?? 0) / 1000 : (b.rate ?? 0);
      return rateB.compareTo(rateA);
    });

    if (filteredServices.isEmpty) {
      return Center(
        child: Text(
          selectedRating != null 
            ? 'No $categoryName services with ${selectedRating.toInt()}+ stars available'
            : 'No $categoryName services available',
          style: context.typography.bodyLarge,
          textAlign: TextAlign.center,
        ),
      );
    }

    return GridViewServicesWidget(
      services: filteredServices,
      locationServices: const [],
    );
  }

  double _getServiceDistance(ServiceModel service, List<ServiceModel> locationServices) {
    return locationServices
        .firstWhere(
          (s) => s.vendorName == service.vendorName,
          orElse: () => service,
        )
        .distance ?? double.infinity;
  }
}