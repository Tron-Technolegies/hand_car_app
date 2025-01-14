import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/service/location/location_service.dart';

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


class FullScreenMap extends HookWidget {
  const FullScreenMap({super.key});

  @override
  Widget build(BuildContext context) {
    final locationService = useMemoized(() => LocationService());
    final currentPosition = useState<Position?>(null);
    final currentAddress = useState('');
    final searchController = useTextEditingController();

    // Define getCurrentLocation function using hooks
    final getCurrentLocation = useCallback(() async {
      try {
        final position = await locationService.getCurrentLocation();
        currentPosition.value = position;
        
        // Get address from coordinates
        final address = await locationService.getAddressFromCoordinates(
          position.latitude,
          position.longitude
        );
        currentAddress.value = address;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
        );
      }
    }, [locationService]);

    // Define searchLocation function using hooks
    final searchLocation = useCallback((String address) async {
      try {
        final position = await locationService.getCoordinatesFromAddress(address);
        if (position != null) {
          currentPosition.value = position;
          // Update map position here
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
        );
      }
    }, [locationService]);

    // Use effect for initialization
    useEffect(() {
      getCurrentLocation();
      return null;
    }, []);

    return Scaffold(
      body: Stack(
        children: [
          // Map Container
          Container(
            color: Colors.grey[200],
            child: Center(
              child: currentPosition.value != null
                ? Text('Lat: ${currentPosition.value!.latitude}, Long: ${currentPosition.value!.longitude}')
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
                            color: Colors.black.withValues(alpha: 0.1),
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
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: searchController,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'Search for service centers',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                searchController.clear();
                              },
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: context.space.space_200,
                              vertical: context.space.space_150),
                          ),
                          onSubmitted: searchLocation,
                        ),
                      ),
                    ),
                  ],
                ),

                // Location info and recent searches
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Ink(
                        child: InkWell(
                          onTap: getCurrentLocation,
                          child: ListTile(
                            leading: Icon(FontAwesomeIcons.locationArrow),
                            title: Text(currentAddress.value.isEmpty 
                              ? "Choose Your Location"
                              : currentAddress.value),
                          ),
                        ),
                      ),
                      // Rest of your existing ListTiles...
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Action Buttons
          Positioned(
            right: 16,
            bottom: 340,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'myLocation',
                  onPressed: getCurrentLocation,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.my_location, color: context.colors.primary),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'layers',
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: Icon(Icons.layers, color: context.colors.primary),
                ),
              ],
            ),
          ),

          // Your existing bottom sheet...
        ],
      ),
    );
  }
}