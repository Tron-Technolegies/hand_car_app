import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/controller/location/location_list/location_list.dart';
import 'package:hand_car/features/car_service/controller/location/search/location_search_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocationSearchWidget extends HookConsumerWidget {
  const LocationSearchWidget({super.key});

  static const int minSearchLength = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final showSearchResults = useState(false);
    final showNearbyServices = useState(false);
    final selectedLocation = useState<String?>(null);
    final isTyping = useState(false);

    final searchResults = ref.watch(searchNotifierProvider);
    final servicesState = ref.watch(servicesNotifierProvider);

    // Setup debounce timer
    final debounceTimer = useState<Timer?>(null);

    useEffect(() {
      return () {
        debounceTimer.value?.cancel();
      };
    }, []);

    void handleSearch(String value) {
      isTyping.value = true;
      debounceTimer.value?.cancel();

      if (value.length < minSearchLength) {
        showSearchResults.value = false;
        return;
      }

      debounceTimer.value = Timer(const Duration(milliseconds: 500), () {
        isTyping.value = false;
        showSearchResults.value = true;
        ref.read(searchNotifierProvider.notifier).searchLocation(value);
      });
    }

    void resetSearch() {
      searchController.clear();
      showSearchResults.value = false;
      showNearbyServices.value = false;
      selectedLocation.value = null;
      debounceTimer.value?.cancel();
      ref.read(servicesNotifierProvider.notifier).clearServices();
    }

    Widget buildSearchHint() {
      if (searchController.text.isEmpty) {
        return const SizedBox.shrink();
      }
      
      if (searchController.text.length < minSearchLength) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Please enter at least $minSearchLength characters to search',
            style: context.typography.bodyMedium.copyWith(
              color: context.colors.primaryTxt,
            ),
          ),
        );
      }

      if (isTyping.value) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      }

      return const SizedBox.shrink();
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
                onChanged: handleSearch,
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
              buildSearchHint(),
              if (showSearchResults.value)
                Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: searchResults.when(
                    data: (results) {
                      if (results.isEmpty && !isTyping.value) {
                        return ListTile(
                          leading: const Icon(Icons.info_outline),
                          title: Text(
                            'No locations found',
                            style: context.typography.bodyMedium,
                          ),
                        );
                      }
                      return ListView.builder(
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
                      );
                    },
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (error, _) => ListTile(
                      leading: const Icon(Icons.error, color: Colors.red),
                      title: Text(
                        'Error searching locations',
                        style: context.typography.bodyMedium.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (servicesState.services.isEmpty &&
            !servicesState.isLoading &&
            showNearbyServices.value)
          buildNoServicesMessage(),
      ],
    );
  }
}