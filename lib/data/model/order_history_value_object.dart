import 'package:flutter_app_sale_25042023/data/model/product_value_object.dart';

class OrderHistoryValueObject{
  String id = "";
  List<ProductValueObject> listProduct = List.empty();
  String idUser = "";
  num price = 0;
  bool status = false;
  DateTime dateCreated = DateTime.now();
}