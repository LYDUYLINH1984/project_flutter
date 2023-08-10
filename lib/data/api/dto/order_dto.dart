import 'package:flutter_app_sale_25042023/data/api/dto/product_dto.dart';

class OrderDTO {
  String? id;
  List<ProductDTO>? listProductDTO;
  String? idUser;
  num? price;
  bool? status;
  
  OrderDTO.fromJson(Map<String, dynamic> json) 
  {
    id = json["_id"];
    listProductDTO = ProductDTO.convertJson(json["products"]);
    idUser = json["id_user"];
    price = json["price"];
    status = json["status"];
  }
}