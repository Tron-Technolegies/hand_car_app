// // full_screen_map.dart
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';
// import 'package:hand_car/features/car_service/controller/location/location_list/location_list.dart';
// import 'package:hand_car/features/car_service/controller/location/location_notifier/location_notifier.dart';
// import 'package:hand_car/features/car_service/controller/location/search/location_search_controller.dart';
// import 'package:hand_car/features/car_service/model/service_model.dart';
// import 'package:hand_car/features/car_service/view/widgets/map/location_widget.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

// class FullScreenMap extends HookConsumerWidget {
//   final ServiceModel serviceModel;
//   const FullScreenMap({required this.serviceModel,super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final locationState = ref.watch(locationNotifierProvider);
//     final servicesState = ref.watch(servicesNotifierProvider);
//     final searchResults = ref.watch(searchNotifierProvider);
//     final searchController = useTextEditingController();
//     final mapController = useRef(MapController());
//     final showSearchResults = useState(false);

//     // Initialize location on first build
//     useEffect(() {
//       Future.microtask(() async {
//         try {
//           // Get current location
//           await ref
//               .read(locationNotifierProvider.notifier)
//               .getCurrentLocation();

//           // Check if location was obtained successfully
//           if (locationState.position != null) {
//             log(
//                 'Location obtained: ${locationState.position!.latitude}, ${locationState.position!.longitude}');

//             // Fetch nearby services
//             await ref
//                 .read(servicesNotifierProvider.notifier)
//                 .fetchNearbyServices(
//                   locationState.position!.latitude,
//                   locationState.position!.longitude,
//                 );

//             // Move map to current location
//             mapController.value.move(
//               LatLng(
//                 locationState.position!.latitude,
//                 locationState.position!.longitude,
//               ),
//               15,
//             );
//           } else {
//             log('Failed to get location');
//           }
//         } catch (e) {
//           log('Error initializing map: $e');
//         }
//       });
//       return null;
//     }, const []);

//     // Handle my location button press
//     Future<void> moveToMyLocation() async {
//       if (locationState.position != null) {
//         try {
//           log('Moving to location: ${locationState.position!.latitude}, ${locationState.position!.longitude}');

//           // Move map to location
//           mapController.value.move(
//             LatLng(
//               locationState.position!.latitude,
//               locationState.position!.longitude,
//             ),
//             15,
//           );

//           // Refresh nearby services
//           await ref.read(servicesNotifierProvider.notifier).fetchNearbyServices(
//                 locationState.position!.latitude,
//                 locationState.position!.longitude,
//               );
//         } catch (e) {
//           log('Error moving to location: $e');
//         }
//       } else {
//         // Try to get location if not available
//         await ref.read(locationNotifierProvider.notifier).getCurrentLocation();
//         if (locationState.position != null) {
//           moveToMyLocation();
//         }
//       }
//     }

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Map Container
//           FlutterMap(
//             mapController: mapController.value,
//             options: MapOptions(
//               initialCenter: locationState.position != null
//                   ? LatLng(
//                       locationState.position!.latitude,
//                       locationState.position!.longitude,
//                     )
//                   : const LatLng(0, 0),
//               initialZoom: 13,
//               minZoom: 5,
//               maxZoom: 18,
//               onTap: (_, __) {
//                 // Hide search results on map tap
//                 showSearchResults.value = false;
//               },
//             ),
//             children: [
//               // Base map layer
//               TileLayer(
//                 urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 userAgentPackageName: 'com.hand_car.app',
//               ),
//               // Markers layer
//               MarkerLayer(
//                 markers: [
//                   if (locationState.position != null)
//                     Marker(
//                       point: LatLng(
//                         locationState.position!.latitude,
//                         locationState.position!.longitude,
//                       ),
//                       width: 40,
//                       height: 40,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color:
//                               Theme.of(context).primaryColor.withValues(alpha:0.9),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.my_location,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   // Service location markers
//                   ...servicesState.services.map(
//                     (service) => Marker(
//                       point: LatLng(service.latitude, service.longitude),
//                       width: 40,
//                       height: 40,
//                       child: GestureDetector(
//                         onTap: () {
//                           mapController.value.move(
//                             LatLng(service.latitude, service.longitude),
//                             15,
//                           );
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withValues(alpha:0.2),
//                                 blurRadius: 4,
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.car_repair,
//                             color: Theme.of(context).primaryColor,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           // Search Bar and Results
//           Positioned(
//             top: MediaQuery.of(context).padding.top + 10,
//             left: context.space.space_200,
//             right: context.space.space_200,
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withValues(alpha:0.1),
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
//                      SizedBox(width: context.space.space_100),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withValues(alpha:0.1),
//                               blurRadius: 8,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: TextField(
//                           controller: searchController,
//                           onChanged: (value) {
//                             showSearchResults.value = value.isNotEmpty;
//                             ref
//                                 .read(searchNotifierProvider.notifier)
//                                 .searchLocation(value);
//                           },
//                           decoration: InputDecoration(
//                             hintText: 'Search for locations',
//                             prefixIcon: const Icon(Icons.search),
//                             suffixIcon: IconButton(
//                               icon: const Icon(Icons.close),
//                               onPressed: () {
//                                 searchController.clear();
//                                 showSearchResults.value = false;
//                               },
//                             ),
//                             border: InputBorder.none,
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 12,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 // Search Results
//                 if (showSearchResults.value)
//                   Container(
//                     margin:  EdgeInsets.only(top: context.space.space_100),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(context.space.space_100),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withValues(alpha:0.1),
//                           blurRadius: 8,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: searchResults.when(
//                       data: (results) => Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: results
//                             .map((result) => ListTile(
//                                   leading: const Icon(Icons.location_on),
//                                   title: Text(result.displayName),
//                                   subtitle: Text(result.address ?? ''),
//                                   onTap: () {
//                                     mapController.value.move(
//                                       result.latLng,
//                                       15,
//                                     );
//                                     showSearchResults.value = false;
//                                     searchController.clear();
//                                     ref
//                                         .read(servicesNotifierProvider.notifier)
//                                         .fetchNearbyServices(
//                                           result.latLng.latitude,
//                                           result.latLng.longitude,
//                                         );
//                                   },
//                                 ))
//                             .toList(),
//                       ),
//                       loading: () =>  Padding(
//                         padding: EdgeInsets.all(context.space.space_200),
//                         child: Center(child: CircularProgressIndicator()),
//                       ),
//                       error: (error, _) => ListTile(
//                         leading: const Icon(Icons.error, color: Colors.red),
//                         title: Text('Error: $error'),
//                       ),
//                     ),
//                   ),

//                 // Current Location Display
//                 if (locationState.address.isNotEmpty &&
//                     !showSearchResults.value)
//                   Container(
//                       margin: const EdgeInsets.only(top: 8),
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withValues(alpha:0.1),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: LocationWidget(() => moveToMyLocation())),
//               ],
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
//                   onPressed: () {
//                     if (locationState.position != null) {
//                       mapController.value.move(
//                         LatLng(
//                           locationState.position!.latitude,
//                           locationState.position!.longitude,
//                         ),
//                         15,
//                       );
//                     }
//                   },
//                   backgroundColor: Colors.white,
//                   child: Icon(Icons.my_location,
//                       color: Theme.of(context).primaryColor),
//                 ),
//                 const SizedBox(height: 8),
//                 FloatingActionButton(
//                   heroTag: 'layers',
//                   onPressed: () {
//                     // Handle layers button
//                   },
//                   backgroundColor: Colors.white,
//                   child:
//                       Icon(Icons.layers, color: Theme.of(context).primaryColor),
//                 ),
//               ],
//             ),
//           ),

//           // Services List
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     margin:  EdgeInsets.symmetric(vertical: context.space.space_150),
//                     width: 40,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                   if (servicesState.isLoading)
//                     const Center(child: CircularProgressIndicator())
//                   else if (servicesState.error != null)
//                     Padding(
//                       padding:  EdgeInsets.all(context.space.space_200),
//                       child: Text(
//                         servicesState.error!,
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     )
//                   else
//                     Container(
//                       constraints: const BoxConstraints(maxHeight: 300),
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: servicesState.services.length,
//                         itemBuilder: (context, index) {
//                           final service = servicesState.services[index];
//                           return ListTile(
//                             title: Text(service.name),
//                             subtitle: Text(
//                               '${service.distance.toStringAsFixed(1)} km away',
//                             ),
//                             trailing: const Icon(Icons.arrow_forward_ios),
//                             onTap: ()=> _navigateToDetails(context),
//                           );
//                         },
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _navigateToDetails(BuildContext context) {
//     context.push(
//       '/serviceDetailsPage',
//       extra: {'service':serviceModel },
//     );
//   }
// }