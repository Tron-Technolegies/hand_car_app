import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/controller/location/location_list/location_list.dart';
import 'package:hand_car/features/car_service/controller/location/search/location_search_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocationSearchWidget extends HookConsumerWidget {
  const LocationSearchWidget({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final searchController = useTextEditingController();
    final showSearchResults = useState(false);
    final showNearbyServices = useState(false);

    final searchResults = ref.watch(searchNotifierProvider);



    return Container(
        margin: EdgeInsets.symmetric(horizontal: context.space.space_200),
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
            TextField(
              controller: searchController,
              onChanged: (value) {
                showSearchResults.value = value.isNotEmpty;
                ref.read(searchNotifierProvider.notifier).searchLocation(value);
              },
              decoration: InputDecoration(
                hintText: 'Search for locations',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          searchController.clear();
                          showSearchResults.value = false;
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            if (showSearchResults.value)
              Container(
                constraints: const BoxConstraints(maxHeight: 200),
                child: searchResults.when(
                  data: (results) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final result = results[index];
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(result.displayName),
                        subtitle: Text(result.address ?? ''),
                        onTap: () async {
                          showSearchResults.value = false;
                          searchController.text = result.displayName;
                          showNearbyServices.value = true;

                          await ref
                              .read(servicesNotifierProvider.notifier)
                              .fetchNearbyServices(
                                result.latLng.latitude,
                                result.latLng.longitude,
                              );
                        },
                      );
                    },
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => ListTile(
                    leading: const Icon(Icons.error, color: Colors.red),
                    title: Text('Error: $error'),
                  ),
                ),
              ),
          ],
        ),
      ); 
  }
}
 