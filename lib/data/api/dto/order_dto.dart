import 'package:flutter_app_sale_25042023/data/api/dto/product_dto.dart';
import 'package:flutter_app_sale_25042023/data/model/order_history_value_object.dart';

class OrderDTO {
  String? id;
  List<ProductDTO>? listProductDTO;
  String? idUser;
  num? price;
  bool? status;
  DateTime? dateCreate;
  
  OrderDTO.fromJson(Map<String, dynamic> json) 
  {
    id = json["_id"];
    listProductDTO = ProductDTO.convertJson(json["products"]).toList();
    idUser = json["id_user"];
    price = json["price"];
    status = json["status"];
    dateCreate = json["date_created"];
  }

  static List<OrderDTO> convertJson(dynamic json) {
    return (json as List).map((e) => OrderDTO.fromJson(e)).toList();
  }
}