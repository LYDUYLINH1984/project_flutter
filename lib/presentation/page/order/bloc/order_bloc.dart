import 'dart:async';
import 'package:flutter_app_sale_25042023/common/base/base_bloc.dart';
import 'package:flutter_app_sale_25042023/common/base/base_event.dart';
import 'package:flutter_app_sale_25042023/data/model/order_history_value_object.dart';
import 'package:flutter_app_sale_25042023/data/model/product_value_object.dart';
import 'package:flutter_app_sale_25042023/data/parser/order_history_value_object_parser.dart';
import 'package:flutter_app_sale_25042023/data/repository/order_history_repository.dart';
import 'package:flutter_app_sale_25042023/data/repository/product_repository.dart';
import 'package:flutter_app_sale_25042023/presentation/page/order/bloc/order_event.dart';

class OrderBloc extends BaseBloc{
  final StreamController<List<ProductValueObject>> _productController = StreamController();
  final StreamController<List<OrderHistoryValueObject>> _orderController = StreamController();

  Stream<List<ProductValueObject>> productStream() => _productController.stream;
  Stream<List<OrderHistoryValueObject>> orderStream() => _orderController.stream;

  ProductRepository? _productRepository;
  OrderHistoryRepository? _orderHistoryRepository;
  
  void setOrderHistoryRepository(OrderHistoryRepository repository)
  {
    _orderHistoryRepository = repository;
  }

  void setProductRepository(ProductRepository repository) {
    _productRepository = repository;
  }
  
  @override
  void dispatch(BaseEvent event) {
    // TODO: implement dispatch
    switch (event.runtimeType){
        case FetchOrderEvent:
            executeGetOrderHistory();
            break;
    }
  }
  void executeGetOrderHistory() async {
    loadingSink.add(true);
    try {
      var listOrderDTO = await _orderHistoryRepository?.getOrderHistoryService();
      var listOrderValueObject = listOrderDTO?.map((orderDTO){
        return OrderHistoryValueObjectParser.parseFromOrderDTO(orderDTO);
      }).toList();

      if (listOrderValueObject != null) {
        _orderController.sink.add(listOrderValueObject);
      } 
    } catch (e) {
      messageSink.add(e.toString());
    } finally {
      loadingSink.add(false);
    }
  }
  
}