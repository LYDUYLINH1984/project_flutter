import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_app_sale_25042023/data/api/api_request.dart';
import 'package:flutter_app_sale_25042023/data/api/app_response.dart';
import 'package:flutter_app_sale_25042023/data/api/dto/order_dto.dart';
import 'package:flutter_app_sale_25042023/utils/exception_utils.dart';

class OrderHistoryRepository {
  ApiRequest? _apiRequest;

  void setApiRequest(ApiRequest apiRequest) {
    _apiRequest = apiRequest;
  }
  
  Future<OrderDTO> getOrderHistoryService()  async {
    Completer<OrderDTO> completer = Completer();
    try {
      Response<dynamic> response = await _apiRequest?.fetchOrder();
      AppResponse<OrderDTO> appResponse = AppResponse.fromJson(response.data, OrderDTO.fromJson);
      completer.complete(appResponse.data);
    }on DioException catch(dioException){
      var message = ExceptionUtils.getErrorMessage(dioException.response?.data);
      completer.completeError(message);
    } catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }
  
}