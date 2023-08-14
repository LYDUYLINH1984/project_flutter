import 'dart:async';

import 'package:flutter_app_sale_25042023/common/base/base_bloc.dart';
import 'package:flutter_app_sale_25042023/common/base/base_event.dart';
import 'package:flutter_app_sale_25042023/data/model/cart_value_object.dart';
import 'package:flutter_app_sale_25042023/data/model/product_value_object.dart';
import 'package:flutter_app_sale_25042023/data/parser/cart_value_object_parser.dart';
import 'package:flutter_app_sale_25042023/data/repository/cart_repository.dart';
import 'package:flutter_app_sale_25042023/data/repository/product_repository.dart';
import 'package:flutter_app_sale_25042023/presentation/page/cart/bloc/cart_event.dart';
import 'package:flutter_app_sale_25042023/presentation/page/cart/bloc/count_bloc.dart';
import 'package:flutter_app_sale_25042023/presentation/page/cart/bloc/count_event.dart';

class CartBloc extends BaseBloc{
  final StreamController<List<ProductValueObject>> _productController = StreamController();
  final StreamController<CartValueObject> _cartController = StreamController();
  final StreamController<int> _countController = StreamController();
  final StreamController<CountEvent> _eventController = StreamController();
  int _total = 0;

  Stream<List<ProductValueObject>> productStream() => _productController.stream;
  Stream<CartValueObject> cartStream() => _cartController.stream;
  Stream<int> getCountStream() => _countController.stream;
  
  ProductRepository? _productRepository;
  CartRepository? _cartRepository;
  
    void setCartRepository(CartRepository repository)
    {
      _cartRepository = repository;
    }

  void setProductRepository(ProductRepository repository) {
    _productRepository = repository;
  }

  CartBloc(){
    _countController.sink.add(_total);
    _eventController.stream.listen((event) {
      if (event is IncreaseEvent) {
        handleIncreaseEvent(event);
      }
      else if (event is DecreaseEvent){
        handleDecreaseEvent(event);
      }
    });
  }
    
    @override
  void dispatch(BaseEvent event) {
    // TODO: implement dispatch
      switch (event.runtimeType){
        case FetchCartEvent:
          executeGetCarts();
          break;
        case UpdateCartEvent:
          executeUpdateCart(event as UpdateCartEvent);
          break;
        case ConfirmCartEvent:
          executeConfirmCart(event as ConfirmCartEvent);
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
      var cartDTO = await _cartRepository?.updateCartService(event.idCart, event.idProduct, event.quantity);
      var cartValueObject = CartValueObjectParser.parseFromCartDTO(cartDTO);
      _cartController.sink.add(cartValueObject);
    }catch(e){
      messageSink.add(e.toString());
    }finally{
        loadingSink.add(false);
    }
  }
  
  void executeConfirmCart(ConfirmCartEvent event) async {
      loadingSink.add(true);
      try{
        var cartDTO = await _cartRepository?.confirmCartService(event.idCart, event.status);
        var cartValueObject = CartValueObjectParser.parseFromCartDTO(cartDTO);
        _cartController.sink.add(cartValueObject);
      }catch(e){
        messageSink.add(e.toString());
      }finally{
        loadingSink.add(false);
      }
  }

  void addEvent(CountEvent countEvent) {
    _eventController.sink.add(countEvent);
  }

  void handleIncreaseEvent(IncreaseEvent event) {
    _total += event.value;
    _countController.sink.add(_total);
  }

  void handleDecreaseEvent(DecreaseEvent event) {
    _total -= event.value;
    _countController.sink.add(_total);
  }
  
}