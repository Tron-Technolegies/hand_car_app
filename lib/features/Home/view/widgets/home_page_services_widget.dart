// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';
// import 'package:hand_car/features/car_service/controller/car_service_controller.dart';
// import 'package:hand_car/features/car_service/model/service_model.dart';

// class HomePageServicesContainerWidget extends ConsumerWidget {
//   const HomePageServicesContainerWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final servicesAsync = ref.watch(carServiceControllerProvider);

//     return servicesAsync.when(
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (error, _) => Center(child: Text('Error: $error')),
//       data: (services) {
//         return CarouselSlider.builder(
//           options: CarouselOptions(
//             height: 300,
//             viewportFraction: 0.8,
//             autoPlay: true,
//             enableInfiniteScroll: true,
//             reverse: true,
//             autoPlayInterval: const Duration(seconds: 3),
//           ),
//           itemCount: services.length,
//           itemBuilder: (context, index, realIndex) {
//             final service = services[index];
//             return _buildServiceCard(context, service);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildServiceCard(BuildContext context, ServiceModel service) {
//     return Padding(
//       padding: EdgeInsets.all(context.space.space_100),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: context.colors.white,
//         ),
//         padding: EdgeInsets.all(context.space.space_100),
//         child: Column(
//           children: [
//             // Display multiple images in a row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: service.images.take(3).map((imageUrl) {
//                 return Flexible(
//                   child: Padding(
//                     padding: EdgeInsets.all(context.space.space_50),
//                     child: Image.network(
//                       height: 150,
//                       imageUrl,
//                       fit: BoxFit.cover,
//                       loadingBuilder: (context, child, progress) {
//                         return progress == null
//                             ? child
//                             : const CircularProgressIndicator();
//                       },
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           color: Colors.grey[200],
//                           height: 120,
//                           child: const Icon(Icons.broken_image),
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: context.space.space_100),
//             Text(
//               service.serviceCategory!,
//               style: context.typography.h3,
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: context.space.space_50),
//             // if (service. != null)
//             //   Text(
//             //     service.description!,
//             //     style: context.typography.body,
//             //     maxLines: 2,
//             //     overflow: TextOverflow.ellipsis,
//             //   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';

class HomePageServicesContainerWidget extends ConsumerWidget {
  const HomePageServicesContainerWidget({super.key});

  // Mock data for testing
  static final List<DummyServiceModel> mockServices = [
    DummyServiceModel(
      serviceCategory: "Premium Oil Change",
      images: [
        "https://media.istockphoto.com/id/1325588832/photo/pouring-motor-oil-for-motor-vehicles-from-a-gray-bottle-into-the-engine.jpg?s=612x612&w=0&k=20&c=8El-cOoOpGSDz-dOjozJn5ijlFOuE1WGQA1hsZvyyMk=",
      ],
    ),
    DummyServiceModel(
      serviceCategory: "Brake System Repair",
      images: [
      "https://media.istockphoto.com/id/522394158/photo/car-service-procedure.jpg?s=612x612&w=0&k=20&c=SXPyg7yMw0Uc4LuI59lchMouvjJ3z6r5oNKO7mdnHCc="
      ],
    ),
    DummyServiceModel(
      serviceCategory: "Tire Rotation & Alignment",
      images: [
        "https://media.istockphoto.com/id/1003774910/photo/tire-changing-at-car-service.jpg?s=612x612&w=0&k=20&c=SHCtCPD12va3chxY_sE9-g2WR47ZgVpu14WiU0YXjEA="
      ],
    ),
    DummyServiceModel(
      serviceCategory: "Full Car Detailing",
      images: [
"https://media.istockphoto.com/id/984269174/photo/car-detailing-concept-auto-cleaning-and-polish.jpg?s=612x612&w=0&k=20&c=7jnBe8KO-5g7xlQVPF8oMYRN00X__haX5vWK3Jr9o08="
      ],
    ),
    DummyServiceModel(
      serviceCategory: "Engine Diagnostic & Tune-Up",
      images: [
        "https://media.istockphoto.com/id/1367581969/photo/mechanic-using-laptop-during-car-engine-diagnostic.jpg?s=612x612&w=0&k=20&c=Qn8i9uNXzIxRMv74KTQDdpAR-J7zGyh9RT5xP5h4sLU=",
      ],
    ),
    
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use mock data directly for testing
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 300,
        viewportFraction: 0.8,
        autoPlay: true,
        enableInfiniteScroll: true,
        reverse: true,
        autoPlayInterval: const Duration(seconds: 3),
      ),
      itemCount: mockServices.length,
      itemBuilder: (context, index, realIndex) {
        final service = mockServices[index];
        return _buildServiceCard(context, service);
      },
    );
  }

  Widget _buildServiceCard(BuildContext context, DummyServiceModel service) {
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
              children: service.images!.take(3).map((imageUrl) {
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
            // Uncomment and adjust if description is added to ServiceModel
            // if (service.description != null)
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

class DummyServiceModel {
  String? serviceCategory;
  List<String>? images;

  DummyServiceModel({this.serviceCategory, this.images});
}
