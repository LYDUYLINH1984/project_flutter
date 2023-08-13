import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_app_sale_25042023/common/app_constants.dart';
import 'package:flutter_app_sale_25042023/common/base/base_widget.dart';
import 'package:flutter_app_sale_25042023/common/widget/loading_widget.dart';
import 'package:flutter_app_sale_25042023/data/api/api_request.dart';
import 'package:flutter_app_sale_25042023/data/model/cart_value_object.dart';
import 'package:flutter_app_sale_25042023/data/model/cart_value_object.dart';
import 'package:flutter_app_sale_25042023/data/repository/cart_repository.dart';
import 'package:flutter_app_sale_25042023/data/repository/product_repository.dart';
import 'package:flutter_app_sale_25042023/presentation/page/cart/bloc/cart_bloc.dart';
import 'package:flutter_app_sale_25042023/presentation/page/cart/bloc/cart_bloc.dart';
import 'package:flutter_app_sale_25042023/presentation/page/cart/bloc/cart_event.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        providers: [
          Provider(create: (context) => ApiRequest()),
          ProxyProvider<ApiRequest, ProductRepository>(
            create: (context) => ProductRepository(),
            update: (_, request, repository) {
              repository ??= ProductRepository();
              repository.setApiRequest(request);
              return repository;
            },
          ),
          ProxyProvider<ApiRequest, CartRepository>(
            create: (context) => CartRepository(),
            update: (_, request, repository){
              repository ??= CartRepository();
              repository.setApiRequest(request);
              return repository;
            }
          ),
          ProxyProvider2<ProductRepository, CartRepository, CartBloc>(
            create: (context) => CartBloc(),
            update: (_, productRepo, cartRepo, bloc) {
              bloc ??= CartBloc();
              bloc.setProductRepository(productRepo);
              bloc.setCartRepository(cartRepo);
              return bloc;
            },
          )
        ],
        appBar: AppBar(
          title: const Text("Cart Details")
        ),
        child: CartContainer(),
    );
  }
}

class CartContainer extends StatefulWidget {
  const CartContainer({Key? key}) : super(key: key);

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  CartBloc? _bloc;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = context.read();
    _bloc?.eventSink.add(FetchCartDetailEvent());
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          SafeArea(
            child: StreamBuilder<CartValueObject>(
              initialData: null,
              stream: _bloc?.cartStream(),
              builder: (context, snapshot){
                if (snapshot.hasError || snapshot.data?.listProduct.isEmpty == true) {
                  return Container(
                    child: Center(child: Text("Data empty")),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data?.listProduct.length ?? 0,
                  itemBuilder: (context, index){
                  }
                );
              }
            ),
          ),
          LoadingWidget(bloc: _bloc),
        ],
    );
  }
  
  Widget _buildItemFood(CartValueObject? cart, Function()? eventUpdateCart, Function()? eventCartConfirm){
    if(cart == null) return Container();
    return SizedBox(
      
    );
  }
}


