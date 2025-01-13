import 'package:flutter/material.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:hand_car/features/car_service/view/widgets/service_info_container_widget.dart';

class GridViewServicesWidget extends StatelessWidget {
  final List<ServiceModel> services;

  const GridViewServicesWidget({
    super.key,
    required this.services,
  });

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
        return ServiceCardWidget(
          service: service,
        );
      },
    );
  }
}

// Example usage in your page:
/*
Consumer(
  builder: (context, ref, child) {
    final servicesAsync = ref.watch(carServiceControllerProvider);
    
    return servicesAsync.when(
      data: (services) => services.isEmpty
          ? const Center(child: Text('No services available'))
          : GridViewServicesWidget(services: services),
      error: (error, stack) => Center(
        child: Text('Error: ${error.toString()}'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  },
)
*/
