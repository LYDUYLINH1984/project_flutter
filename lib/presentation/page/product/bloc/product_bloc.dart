import 'dart:async';

import 'package:flutter_app_sale_25042023/common/base/base_bloc.dart';
import 'package:flutter_app_sale_25042023/common/base/base_event.dart';
import 'package:flutter_app_sale_25042023/data/api/dto/cart_dto.dart';
import 'package:flutter_app_sale_25042023/data/model/cart_value_object.dart';
import 'package:flutter_app_sale_25042023/data/model/product_value_object.dart';
import 'package:flutter_app_sale_25042023/data/parser/cart_value_object_parser.dart';
import 'package:flutter_app_sale_25042023/data/parser/product_value_object_parser.dart';
import 'package:flutter_app_sale_25042023/data/repository/cart_repository.dart';
import 'package:flutter_app_sale_25042023/data/repository/product_repository.dart';
import 'package:flutter_app_sale_25042023/presentation/page/product/bloc/product_event.dart';

class ProductBloc extends BaseBloc {

  final StreamController<List<ProductValueObject>> _productController = StreamController();
  final StreamController<CartValueObject> _cartController = StreamController();

  Stream<List<ProductValueObject>> productStream() => _productController.stream;
  Stream<CartValueObject> cartStream() => _cartController.stream;

  ProductRepository? _productRepository;
  CartRepository? _cartRepository;

  void setProductRepository(ProductRepository repository) {
    _productRepository = repository;
  }

  void setCartRepository(CartRepository repository) {
    _cartRepository = repository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch (event.runtimeType) {
      case FetchProductsEvent:
        executeGetProducts();
        break;
      case FetchCartEvent:
        executeGetCart();
        break;
      case AddCartEvent:
        executeAddCart(event as AddCartEvent);
        break;
      case FetchOrderHistoryEvent:
        executeGetOrderHistory(event as FetchOrderHistoryEvent);
        break;
    }
  }

  void executeGetOrderHistory(FetchOrderHistoryEvent event){
    loadingSink.add(true);
    try{
      messageSink.add("Order History");
    }catch(e){
      messageSink.add(e.toString());
    }finally{
      loadingSink.add(false);
    }
  }

  void executeGetProducts() async {
    loadingSink.add(true);
    try {
      var listProductDTO = await _productRepository?.getProductsService();
      var listProductValueObject = listProductDTO?.map((productDTO) {
        return ProductValueObjectParser.parseFromProductDTO(productDTO);
      }).toList();
      
      if (listProductValueObject != null) {
        _productController.sink.add(listProductValueObject);
      }

    } catch (e) {
      messageSink.add(e.toString());
    } finally {
      loadingSink.add(false);
    }
  }
  
  void executeGetCart() async {
    loadingSink.add(true);
    try {
      var cartDTO = await _cartRepository?.getCartService();
      var cartValueObject = CartValueObjectParser.parseFromCartDTO(cartDTO as CartDTO?);
      _cartController.sink.add(cartValueObject);
    } catch (e) {
      messageSink.add(e.toString());
    } finally {
      loadingSink.add(false);
    }
  }

  void executeAddCart(AddCartEvent event) async {
    loadingSink.add(true);
    try {
      var cartDTO = await _cartRepository?.addCartService(event.idProduct);
      var cartValueObject = CartValueObjectParser.parseFromCartDTO(cartDTO);
      _cartController.sink.add(cartValueObject);
    } catch (e) {
      messageSink.add(e.toString());
    } finally {
      loadingSink.add(false);
    }
  }
}