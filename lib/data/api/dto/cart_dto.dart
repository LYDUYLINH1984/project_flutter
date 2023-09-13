import 'package:flutter_app_sale_25042023/data/api/dto/product_dto.dart';

class CartDTO {
  String? id;
  List<ProductDTO>? listProductDTO;
  String? idUser;
  num? price;

  CartDTO.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    listProductDTO = ProductDTO.convertJson(json["products"]);
    idUser = json["id_user"];
    price = json["price"];
  }

}