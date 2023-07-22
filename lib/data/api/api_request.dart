import 'package:dio/dio.dart';
import 'package:flutter_app_sale_25042023/common/app_constants.dart';
import 'package:flutter_app_sale_25042023/data/api/dio_client.dart';

class ApiRequest {
  late Dio _dio;

  ApiRequest(){
    _dio = DioClient.createDio();
  }

  Future signIn(String email, String password) {
    return _dio.post(AppConstants.SIGN_IN_URL, data: {
      "email" : email,
      "password": password
    });
  }

  Future signUp(
      String email,
      String password,
      String name,
      String phone,
      String address
  ) {
    return _dio.post(AppConstants.SIGN_UP_URL, data: {
      "email" : email,
      "password": password,
      "name": name,
      "phone": phone,
      "address": address
    });
  }
}