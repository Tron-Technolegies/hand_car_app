
import 'dart:async';

import 'package:hand_car/features/car_service/controller/location/location_list/location_list.dart';
import 'package:hand_car/features/car_service/model/location/search_location/search_location.dart';
import 'package:hand_car/features/car_service/service/location/search/location_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_search_controller.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
   Timer? _debounceTimer;
  final LocationSearchService _searchService = LocationSearchService();

  @override
  AsyncValue<List<LocationSearchResult>> build() {
    return const AsyncValue.data([]);
  }

  Future<void> searchLocation(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      _debounceTimer?.cancel();
      return;
    }

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      state = const AsyncValue.loading();
      
      try {
        final results = await _searchService.searchLocation(query);
        state = AsyncValue.data(results);
        
        // If we have results, update services for the first result
        if (results.isNotEmpty) {
          final firstResult = results.first;
          await ref.read(servicesNotifierProvider.notifier).fetchNearbyServices(
            firstResult.latLng.latitude,
            firstResult.latLng.longitude,
          );
        }
      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    });

  void dispose() {
    _debounceTimer?.cancel();
  }
}
}