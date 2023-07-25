import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_app_sale_25042023/data/api/api_request.dart';
import 'package:flutter_app_sale_25042023/data/api/app_response.dart';
import 'package:flutter_app_sale_25042023/data/api/dto/product_dto.dart';
import 'package:flutter_app_sale_25042023/utils/exception_utils.dart';

class ProductRepository {
  ApiRequest? _apiRequest;

  void setApiRequest(ApiRequest apiRequest) {
    _apiRequest = apiRequest;
  }

  Future<List<ProductDTO>> getProductsService() async {
    Completer<List<ProductDTO>> completer = Completer();
    try {
      Response<dynamic> response = await _apiRequest?.fetchProducts();
      AppResponse<List<ProductDTO>> appResponse = AppResponse.fromJson(response.data, ProductDTO.convertJson);
      completer.complete(appResponse.data);
    } on DioException catch(dioException) {
      var message = ExceptionUtils.getErrorMessage(dioException.response?.data);
      completer.completeError(message);
    } catch(e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}