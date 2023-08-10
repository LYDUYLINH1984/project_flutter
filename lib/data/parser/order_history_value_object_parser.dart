import 'package:flutter_app_sale_25042023/data/api/dto/order_dto.dart';
import 'package:flutter_app_sale_25042023/data/model/order_history_value_object.dart';
import 'package:flutter_app_sale_25042023/data/parser/product_value_object_parser.dart';

class OrderHistoryValueObjectParser {
  static OrderHistoryValueObject parseFromCartDTO(OrderDTO? orderDTO) {
    if (orderDTO == null) return OrderHistoryValueObject();
    final OrderHistoryValueObject orderHistoryValueObject = OrderHistoryValueObject();
    orderHistoryValueObject.id = orderDTO.id ?? "";
    orderHistoryValueObject.idUser = orderDTO.idUser ?? "";
    orderHistoryValueObject.listProduct = orderDTO.listProductDTO?.map((e) {
      return ProductValueObjectParser.parseFromProductDTO(e);
    }).toList() ?? List.empty();
    orderHistoryValueObject.price = orderDTO.price ?? 0;
    return orderHistoryValueObject;
  }
}