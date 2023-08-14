import 'package:flutter_app_sale_25042023/common/base/base_event.dart';

class FetchCartEvent extends BaseEvent {

  @override
  List<Object?> get props => [];
}

class UpdateCartEvent extends BaseEvent {
  String idCart, idProduct;
  num quantity;
  
  UpdateCartEvent({required this.idCart, required this.idProduct, required this.quantity});
  @override
  List<Object?> get props => [];
}

class ConfirmCartEvent extends BaseEvent {
  String idCart;
  bool status;

  ConfirmCartEvent({required this.idCart, required this.status});
  @override
  List<Object?> get props => [];
}

