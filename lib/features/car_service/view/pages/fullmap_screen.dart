import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hand_car/features/car_service/controller/location/location_list/location_list.dart';
import 'package:hand_car/features/car_service/controller/location/location_notifier/location_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// class FullScreenMap extends StatelessWidget {
//   const FullScreenMap({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Map Container
//           Container(
//             color: Colors.grey[200],
//             child: const Center(
//               child: Text('Map View'),
//             ),
//           ),

//           // Search Bar
//           Positioned(
//             top: MediaQuery.of(context).padding.top + 10,
//             left: 16,
//             right: 16,
//             child: Column(
//               children: [
//                 // Back button and search bar row
//                 Row(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withValues(alpha: 0.1),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: IconButton(
//                         icon: const Icon(Icons.arrow_back),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withValues(alpha: 0.1),
//                               blurRadius: 8,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: TextField(
//                           autofocus: true,
//                           decoration: InputDecoration(
//                             hintText: 'Search for service centers',
//                             prefixIcon: const Icon(Icons.search),
//                             suffixIcon: IconButton(
//                               icon: const Icon(Icons.close),
//                               onPressed: () {},
//                             ),
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: context.space.space_200,
//                                 vertical: context.space.space_150),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 // Recent searches container
//                 Container(
//                   margin: const EdgeInsets.only(top: 8),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: 0.1),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Ink(
//                         child: InkWell(
//                           onTap: () {},
//                           child: ListTile(
//                             leading: Icon(
//                               FontAwesomeIcons.locationArrow,
//                             ),
//                             title: Text(
//                               "Choose Your Location",
//                             ),
//                           ),
//                         ),
//                       ),
//                       ListTile(
//                         leading: const Icon(Icons.history),
//                         title: Text('Tron Digital',
//                             style: context.typography.bodyMedium),
//                         dense: true,
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         leading: const Icon(Icons.history),
//                         title: Text('Dahab Miners',
//                             style: context.typography.bodyMedium),
//                         dense: true,
//                         onTap: () {},
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Bottom Sheet with Service Centers
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(16)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.1),
//                     blurRadius: 8,
//                     offset: const Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Drag handle
//                   Center(
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(vertical: 12),
//                       width: 40,
//                       height: 4,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                   ),

//                   // Service centers list
//                   Container(
//                     constraints: const BoxConstraints(maxHeight: 300),
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: 3,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           leading: Container(
//                             width: 50,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(Icons.car_repair,
//                                 color: context.colors.primary),
//                           ),
//                           title: Text(
//                             'Service Center ${index + 1}',
//                             style: context.typography.bodySemiBold,
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '2.3 km away',
//                                 style: context.typography.bodySmall.copyWith(
//                                   color: context.colors.primary,
//                                 ),
//                               ),
//                               Text(
//                                 'Abu Dhabi, United Arab Emirates',
//                                 style: context.typography.bodySmall,
//                               ),
//                             ],
//                           ),
//                           trailing: CircleAvatar(
//                             backgroundColor:
//                                 context.colors.primary.withValues(alpha: 0.1),
//                             child: Icon(
//                               Icons.arrow_forward,
//                               color: context.colors.primary,
//                               size: 20,
//                             ),
//                           ),
//                           onTap: () {},
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Action Buttons
//           Positioned(
//             right: 16,
//             bottom: 340,
//             child: Column(
//               children: [
//                 FloatingActionButton(
//                   heroTag: 'myLocation',
//                   onPressed: () {},
//                   backgroundColor: Colors.white,
//                   child: Icon(Icons.my_location, color: context.colors.primary),
//                 ),
//                 const SizedBox(height: 8),
//                 FloatingActionButton(
//                   heroTag: 'layers',
//                   onPressed: () {},
//                   backgroundColor: Colors.white,
//                   child: Icon(Icons.layers, color: context.colors.primary),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// screens/full_screen_map.dart



class FullScreenMap extends HookConsumerWidget {
  const FullScreenMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationNotifierProvider);
    final servicesState = ref.watch(servicesNotifierProvider);
    final searchController = useTextEditingController();

    // Initialize location on first build
    useEffect(() {
      Future.microtask(() async {
        await ref.read(locationNotifierProvider.notifier).getCurrentLocation();
        if (locationState.position != null) {
          await ref.read(servicesNotifierProvider.notifier).fetchNearbyServices(
                locationState.position!.latitude,
                locationState.position!.longitude,
              );
        }
      });
      return null;
    }, const []);

    return Scaffold(
      body: Stack(
        children: [
          // Map Container
          Container(
            color: Colors.grey[200],
            child: Center(
              child: locationState.position != null
                  ? Text(
                      'Lat: ${locationState.position!.latitude}, Long: ${locationState.position!.longitude}')
                  : const Text('Loading location...'),
            ),
          ),

          // Search Bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search for service centers',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => searchController.clear(),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Location info
                if (locationState.address.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(FontAwesomeIcons.locationArrow),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            locationState.address,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Services List
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  if (servicesState.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (servicesState.error != null)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        servicesState.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  else
                    Container(
                      constraints: const BoxConstraints(maxHeight: 300),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: servicesState.services.length,
                        itemBuilder: (context, index) {
                          final service = servicesState.services[index];
                          return ListTile(
                            title: Text(service.name),
                            subtitle: Text(
                                '${service.distance.toStringAsFixed(1)} km away'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // Handle service selection
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}