import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/controller/location/location_list/location_list.dart';
import 'package:hand_car/features/car_service/controller/location/search/location_search_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';




class LocationSearchWidget extends HookConsumerWidget {
  const LocationSearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final showSearchResults = useState(false);
    final showNearbyServices = useState(false);
    final selectedLocation = useState<String?>(null);

    final searchResults = ref.watch(searchNotifierProvider);
    final servicesState = ref.watch(servicesNotifierProvider);

    void resetSearch() {
      searchController.clear();
      showSearchResults.value = false;
      showNearbyServices.value = false;
      selectedLocation.value = null;
      ref.read(servicesNotifierProvider.notifier).clearServices();
    }

    Widget buildNoServicesMessage() {
      if (!showNearbyServices.value || selectedLocation.value == null) {
        return const SizedBox.shrink();
      }

      return Container(
        margin: EdgeInsets.symmetric(vertical: context.space.space_100),
        padding: EdgeInsets.all(context.space.space_200),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.orange.shade800),
            SizedBox(width: context.space.space_100),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No Services Available',
                    style: context.typography.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'No services found near ${selectedLocation.value}. Try searching in a different area.',
                    style: context.typography.bodyMedium.copyWith(
                      color: Colors.orange.shade900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Container(
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
                          onPressed: resetSearch,
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
                            selectedLocation.value = result.displayName;

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
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, _) => ListTile(
                      leading: const Icon(Icons.error, color: Colors.red),
                      title: Text('Error: $error'),
                    ),
                  ),
                ),
            ],
          ),
        ),
        // Show "No services" message when appropriate
        if (servicesState.services.isEmpty &&
            !servicesState.isLoading &&
            showNearbyServices.value)
          buildNoServicesMessage(),
      ],
    );
  }
}
 