import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:hand_car/features/car_service/view/widgets/service_info_container_widget.dart';


class GridViewServicesWidget extends StatelessWidget {
  final List<ServiceModel> services;
  final List<ServiceModel> locationServices;

  const GridViewServicesWidget({
    super.key,
    required this.services,
    required this.locationServices,
  });

  String? _getDistance(String vendorName) {
    if (locationServices.isEmpty) return null;

    final locationService = locationServices.firstWhere(
      (service) => service.vendorName == vendorName,
      orElse: () => ServiceModel(
        id: -1,
        vendorName: '',
        phoneNumber: '',
        whatsappNumber: '',
        serviceDetails: '',
        address: '',
        rate: null,
      ),
    );

    if (locationService.distance == null ||
        locationService.distance == double.infinity) return null;
    return '${locationService.distance!.toStringAsFixed(1)} km';
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 340,
        mainAxisSpacing: 0.5,
        mainAxisExtent: 340, // Increased to accommodate distance
        crossAxisSpacing: 1.8,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        // final distance = _getDistance(service.vendorName);

        return Padding(
          padding: EdgeInsets.all(context.space.space_100),
          child: SizedBox(
            height: 340, // Fixed height container
            child: Column(
              children: [
                Expanded(
                  child: ServiceCardWidget(
                    service: service,
                  ),
                ),
                
                
              ],
            ),
          ),
        );
      },
    );
  }
}
