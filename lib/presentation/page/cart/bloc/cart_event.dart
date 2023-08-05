import 'package:flutter_app_sale_25042023/common/base/base_event.dart';

class FetchCartEvent extends BaseEvent {

  @override
  List<Object?> get props => [];
}

class FetchCartDetailEvent extends BaseEvent {
  String idCart;
  
  FetchCartDetailEvent({required this.idCart});
  
  @override
  List<Object?> get props => [];
}

class UpdateCartEvent extends BaseEvent {
  String idCart, idProduct;
  num idPrice;
  
  UpdateCartEvent({required this.idCart, required this.idProduct, required this.idPrice});
  
  @override
  List<Object?> get props => [];
}

class OrderCartEvent extends BaseEvent {
  String idCart;

  OrderCartEvent({required this.idCart});
  @override
  List<Object?> get props => [];
}