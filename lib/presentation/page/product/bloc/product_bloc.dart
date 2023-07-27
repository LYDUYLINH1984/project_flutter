import 'dart:async';

import 'package:flutter_app_sale_25042023/common/base/base_bloc.dart';
import 'package:flutter_app_sale_25042023/common/base/base_event.dart';
import 'package:flutter_app_sale_25042023/data/model/product_value_object.dart';
import 'package:flutter_app_sale_25042023/data/parser/product_value_object_parser.dart';
import 'package:flutter_app_sale_25042023/data/repository/product_repository.dart';
import 'package:flutter_app_sale_25042023/presentation/page/product/bloc/product_event.dart';

class ProductBloc extends BaseBloc {

  final StreamController<List<ProductValueObject>> _productController = StreamController();

  Stream<List<ProductValueObject>> productStream() => _productController.stream;

  ProductRepository? _repository;

  void setProductRepository(ProductRepository repository) {
    _repository = repository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch (event.runtimeType) {
      case FetchProductsEvent:
        executeGetProducts();
        break;
    }
  }

  void executeGetProducts() async {
    loadingSink.add(true);
    try {
      var listProductDTO = await _repository?.getProductsService();
      var listProductValueObject = listProductDTO?.map((productDTO) {
        return ProductValueObjectParser.parseFromProductDTO(productDTO);
      }).toList();
      
      if (listProductValueObject != null) {
        _productController.sink.add(listProductValueObject);
      }

    } catch (e) {
      messageSink.add(e.toString());
    }
    loadingSink.add(false);
  }
}