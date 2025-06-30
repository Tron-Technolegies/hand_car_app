import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/controller/car_service_controller.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';

class HomePageServicesContainerWidget extends ConsumerWidget {
  const HomePageServicesContainerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(carServiceControllerProvider);

    return servicesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
      data: (services) {
        return CarouselSlider.builder(
          options: CarouselOptions(
            height: 300,
            viewportFraction: 0.8,
            autoPlay: true,
            enableInfiniteScroll: true,
            reverse: true,
            autoPlayInterval: const Duration(seconds: 3),
          ),
          itemCount: services.length,
          itemBuilder: (context, index, realIndex) {
            final service = services[index];
            return _buildServiceCard(context, service);
          },
        );
      },
    );
  }

  Widget _buildServiceCard(BuildContext context, ServiceModel service) {
    return Padding(
      padding: EdgeInsets.all(context.space.space_100),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colors.white,
        ),
        padding: EdgeInsets.all(context.space.space_100),
        child: Column(
          children: [
            // Display multiple images in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: service.images.take(3).map((imageUrl) {
                return Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(context.space.space_50),
                    child: Image.network(
                      height: 150,
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        return progress == null
                            ? child
                            : const CircularProgressIndicator();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          height: 120,
                          child: const Icon(Icons.broken_image),
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: context.space.space_100),
            Text(
              service.serviceCategory!,
              style: context.typography.h3,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.space.space_50),
            // if (service. != null)
            //   Text(
            //     service.description!,
            //     style: context.typography.body,
            //     maxLines: 2,
            //     overflow: TextOverflow.ellipsis,
            //   ),
          ],
        ),
      ),
    );
  }
}
