
import 'dart:async';

import 'package:hand_car/features/car_service/model/location/search_location/search_location.dart';
import 'package:hand_car/features/car_service/service/location/search/location_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_search_controller.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
  Timer? _debounceTimer;

  @override
  AsyncValue<List<LocationSearchResult>> build() {
    return const AsyncValue.data([]);
  }

  Future<void> searchLocation(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    // Cancel previous timer if exists
    _debounceTimer?.cancel();

    // Set new timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      state = const AsyncValue.loading();
      try {
        final results = await LocationSearchService().searchLocation(query);
        state = AsyncValue.data(results);
      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    });
  }
}