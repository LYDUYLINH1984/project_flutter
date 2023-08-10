import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_app_sale_25042023/data/api/api_request.dart';
import 'package:flutter_app_sale_25042023/data/api/app_response.dart';
import 'package:flutter_app_sale_25042023/data/api/dto/cart_dto.dart';
import 'package:flutter_app_sale_25042023/utils/exception_utils.dart';

class CartRepository {
  ApiRequest? _apiRequest;

  void setApiRequest(ApiRequest apiRequest) {
    _apiRequest = apiRequest;
  }

  Future<CartDTO> getCartService() async {
    Completer<CartDTO> completer = Completer();
    try {
      Response<dynamic> response = await _apiRequest?.fetchCart();
      AppResponse<CartDTO> appResponse = AppResponse.fromJson(response.data, CartDTO.fromJson);
      completer.complete(appResponse.data);
    } on DioException catch(dioException) {
      var message = ExceptionUtils.getErrorMessage(dioException.response?.data);
      completer.completeError(message);
    } catch(e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<CartDTO> addCartService(String idProduct) async {
    Completer<CartDTO> completer = Completer();
    try {
      Response<dynamic> response = await _apiRequest?.addCart(idProduct);
      AppResponse<CartDTO> appResponse = AppResponse.fromJson(response.data, CartDTO.fromJson);
      completer.complete(appResponse.data);
    } on DioException catch(dioException) {
      var message = ExceptionUtils.getErrorMessage(dioException.response?.data);
      completer.completeError(message);
    } catch(e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
  
  Future<CartDTO> updateCartService(String idCart, String idProduct, num quantity) async {
    Completer<CartDTO> completer = Completer();
    try {
      Response<dynamic> response = await _apiRequest?.updateCart(idCart, idProduct, quantity);
      AppResponse<CartDTO> appResponse = AppResponse.fromJson(response.data, CartDTO.fromJson);
      completer.complete(appResponse.data);
    }on DioException catch(dioException ){
      var message = ExceptionUtils.getErrorMessage(dioException.response?.data);
      completer.completeError(message);
    } catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }
  
  Future<CartDTO> confirmCartService(String idCart, bool status) async {
    Completer<CartDTO> completer = Completer();
    try {
      Response<dynamic> response = await _apiRequest?.cartConform(idCart, status);
      AppResponse<CartDTO> appResponse = AppResponse.fromJson(response.data, CartDTO.fromJson);
      completer.complete(appResponse.data);
    }on DioException catch(dioException){
      var message = ExceptionUtils.getErrorMessage(dioException.response?.data);
      completer.completeError(message);
    }catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}