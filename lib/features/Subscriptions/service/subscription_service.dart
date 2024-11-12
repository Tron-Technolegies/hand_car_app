import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Subscriptions/controller/model/subscription_model.dart';

class SubscriptionService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    validateStatus: (status) => status! < 500, // Accept all status codes less than 500
  ));

   Future<SubscriptionModel> getSubscription() async {
    final response = await dio.get('/subscribe/');
    return SubscriptionModel.fromJson(response.data);
  }

 
}
