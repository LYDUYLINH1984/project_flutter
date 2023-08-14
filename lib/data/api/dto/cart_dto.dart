import 'package:flutter_app_sale_25042023/data/api/dto/product_dto.dart';

class CartDTO {
  String? id;
  List<ProductDTO>? listProductDTO;
  String? idUser;
  num? price;

  CartDTO.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    listProductDTO = ProductDTO.convertJson(json["products"]).toList();
    idUser = json["id_user"];
    price = json["price"];
  }

  static List<CartDTO> convertJson(dynamic json) {
    return (json as List).map((e) => CartDTO.fromJson(e)).toList();
  }
  
}