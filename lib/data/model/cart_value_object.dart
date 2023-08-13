import 'package:flutter_app_sale_25042023/data/model/product_value_object.dart';
class CartValueObject {
  String id = "";
  List<ProductValueObject> listProduct = List.empty(growable: true);
  String idUser = "";
  num price = 0;
}