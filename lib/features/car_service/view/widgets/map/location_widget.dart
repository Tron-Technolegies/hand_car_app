
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/controller/location/location_notifier/location_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocationWidget extends HookConsumerWidget {
  final VoidCallback onLocationReceived;
  const LocationWidget(this.onLocationReceived, {super.key});

  @override
  Widget build(BuildContext context,ref) {
       final locationState = ref.watch(locationNotifierProvider);
    // Use useState hook to manage address state
    // final currentAddress = useState('Tap to get location');

    // // Use useCallback to memoize the location fetching function
    // final getCurrentLocation = useCallback(() async {
    //   try {
    //     // Check location permissions
    //     LocationPermission permission = await Geolocator.checkPermission();
    //     if (permission == LocationPermission.denied) {
    //       permission = await Geolocator.requestPermission();
    //     }

    //     if (permission == LocationPermission.whileInUse ||
    //         permission == LocationPermission.always) {
    //       // Get current position
    //       Position position = await Geolocator.getCurrentPosition(
    //         desiredAccuracy: LocationAccuracy.high,
    //       );

    //       // Convert coordinates to address
    //       List<Placemark> placemarks = await placemarkFromCoordinates(
    //           position.latitude, position.longitude);

    //       if (placemarks.isNotEmpty) {
    //         Placemark place = placemarks[0];
    //         currentAddress.value =
    //             '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
    //       }
    //     } else {
    //       // Handle permission denied
    //       currentAddress.value = 'Location permission denied';
    //     }
    //   } catch (e) {
    //     // Handle any errors
    //     currentAddress.value = 'Unable to get location';
    //     log('Error getting location: $e');
    //   }
    // }, []);

    return InkWell(
      onTap: () async{
         await ref.read(locationNotifierProvider.notifier).getCurrentLocation();
            if (locationState.position != null) {
              onLocationReceived();
            }
      },
      child: Row(
        children: [
          const Icon(FontAwesomeIcons.locationArrow),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Tap to get nearest location',
              style: context.typography.bodySemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
