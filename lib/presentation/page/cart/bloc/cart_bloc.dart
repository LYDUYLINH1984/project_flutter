import 'dart:async';

import 'package:flutter_app_sale_25042023/common/base/base_bloc.dart';
import 'package:flutter_app_sale_25042023/common/base/base_event.dart';
import 'package:flutter_app_sale_25042023/data/model/cart_value_object.dart';
import 'package:flutter_app_sale_25042023/data/model/product_value_object.dart';
import 'package:flutter_app_sale_25042023/data/parser/cart_value_object_parser.dart';
import 'package:flutter_app_sale_25042023/data/repository/cart_repository.dart';
import 'package:flutter_app_sale_25042023/data/repository/product_repository.dart';
import 'package:flutter_app_sale_25042023/presentation/page/cart/bloc/cart_bloc.dart';
import 'package:flutter_app_sale_25042023/presentation/page/cart/bloc/cart_event.dart';

class CartBloc extends BaseBloc{
  final StreamController<List<ProductValueObject>> _productController = StreamController();
  final StreamController<CartValueObject> _cartController = StreamController();

  Stream<List<ProductValueObject>> productStream() => _productController.stream;
  Stream<CartValueObject> cartStream() => _cartController.stream;

  ProductRepository? _productRepository;
  CartRepository? _cartRepository;
  
    void setCartRepository(CartRepository repository)
    {
      _cartRepository = repository;
    }
    
    @override
  void dispatch(BaseEvent event) {
    // TODO: implement dispatch
      switch (event.runtimeType){
        case FetchCartDetailEvent:
          executeGetCarts();
          break;
        case UpdateCartEvent:
          executeUpdateCart(event as UpdateCartEvent);
          break;
      }
  }

  void executeGetCarts() async {
    loadingSink.add(true);
    try {
      var cartDTO = await _cartRepository?.getCartService();
      var cartValueObject = CartValueObjectParser.parseFromCartDTO(cartDTO);
      _cartController.sink.add(cartValueObject);
    } catch (e) {
      messageSink.add(e.toString());
    } finally {
      loadingSink.add(false);
    }
  }
  
  void executeUpdateCart(UpdateCartEvent event) async
  {
    loadingSink.add(true);
    try{
      //var cartDTO = await _cartRepository.addCartService(idProduct)
    }catch(e){
      messageSink.add(e.toString());
    }finally{
        loadingSink.add(false);
    }
  }
  
}