import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationWidget extends HookWidget {
  final VoidCallback onTap;
  const LocationWidget(this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    // Use useState hook to manage address state
    final currentAddress = useState('Tap to get location');

    // Use useCallback to memoize the location fetching function
    final getCurrentLocation = useCallback(() async {
      try {
        // Check location permissions
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }

        if (permission == LocationPermission.whileInUse || 
            permission == LocationPermission.always) {
          // Get current position
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );

          // Convert coordinates to address
          List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, 
            position.longitude
          );

          if (placemarks.isNotEmpty) {
            Placemark place = placemarks[0];
            currentAddress.value = 
              '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
          }
        } else {
          // Handle permission denied
          currentAddress.value = 'Location permission denied';
        }
      } catch (e) {
        // Handle any errors
        currentAddress.value = 'Unable to get location';
        print('Error getting location: $e');
      }
    }, []);

    return InkWell(
      onTap:onTap ,
      child: Row(
        children: [
          const Icon(FontAwesomeIcons.locationArrow),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              currentAddress.value,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}