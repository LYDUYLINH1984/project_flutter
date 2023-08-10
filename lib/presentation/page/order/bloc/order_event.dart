import 'package:flutter_app_sale_25042023/common/base/base_event.dart';

class FetchOrderEvent extends BaseEvent {

  @override
  List<Object?> get props => [];
}

class FetchProductOrderEvent extends BaseEvent {
  String idCart, idProduct;
  
  FetchProductOrderEvent({required this.idCart, required this.idProduct});
  
  @override
  List<Object?> get props => [];
}

