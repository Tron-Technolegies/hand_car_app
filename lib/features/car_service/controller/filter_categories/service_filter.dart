
import 'package:hand_car/features/car_service/controller/car_service_controller.dart';
import 'package:hand_car/features/car_service/controller/service_category/service_category.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_filter.g.dart';




@riverpod
class FilteredServices extends _$FilteredServices {
  @override
  AsyncValue<List<ServiceModel>> build() {
    final selectedCategory = ref.watch(serviceCategoryFilterProvider);
    final servicesAsyncValue = ref.watch(carServiceControllerProvider);

    return servicesAsyncValue.when(
      data: (services) {
        if (selectedCategory.isEmpty) {
          return AsyncValue.data(services);
        } else {
          final filteredServices = services
              .where((service) => service.serviceCategory == selectedCategory)
              .toList();
          return AsyncValue.data(filteredServices);
        }
      },
      error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
      loading: () => const AsyncValue.loading(),
    );
  }

  void filterByCategory(String category) {
    ref.read(serviceCategoryFilterProvider.notifier).state = category;
  }
}
