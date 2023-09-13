import 'package:flutter_app_sale_25042023/common/base/base_event.dart';

class FetchOrderEvent extends BaseEvent {

  @override
  List<Object?> get props => [];
}

class FetchProductEvent extends BaseEvent {

  @override
  List<Object?> get props => [];
}

class FetchOrderDetailsEvent extends BaseEvent {
  String idOrder;

  FetchOrderDetailsEvent({required this.idOrder});
  
  @override
  List<Object?> get props => [];
}

