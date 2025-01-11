import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';

class CarServiceApiService {
  static final Dio _dio=Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),

  );

  Future<List<ServiceModel>>getService()async{
    try {
       final response=await _dio.get('/view_service_user');
       if(response.statusCode==200){
        final List<dynamic>serviceList=response.data['services'];
        return serviceList.map((service) => ServiceModel.fromJson(service)).toList();
       }
       throw Exception('Failed to fetch services');
    } catch (e) {
      throw Exception('Failed to fetch services: $e');
    }
  }

}