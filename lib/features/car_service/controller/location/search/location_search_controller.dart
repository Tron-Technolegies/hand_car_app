import 'package:hand_car/features/car_service/model/location/search_location/search_location.dart';
import 'package:hand_car/features/car_service/service/location/search/location_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_search_controller.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
  final _searchService = LocationSearchService();

  @override
  AsyncValue<List<LocationSearchResult>> build() {
    return const AsyncValue.data([]);
  }

  Future<void> searchLocation(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();

    try {
      final results = await _searchService.searchLocation(
        query,
        (isLoading) {
          if (isLoading) {
            state = const AsyncValue.loading();
          }
        },
      );
      state = AsyncValue.data(results);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  @override
  void dispose() {
    _searchService.dispose();

  }
}