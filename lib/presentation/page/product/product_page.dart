import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_app_sale_25042023/common/app_constants.dart';
import 'package:flutter_app_sale_25042023/common/base/base_widget.dart';
import 'package:flutter_app_sale_25042023/common/widget/loading_widget.dart';
import 'package:flutter_app_sale_25042023/data/api/api_request.dart';
import 'package:flutter_app_sale_25042023/data/model/cart_value_object.dart';
import 'package:flutter_app_sale_25042023/data/model/product_value_object.dart';
import 'package:flutter_app_sale_25042023/data/repository/cart_repository.dart';
import 'package:flutter_app_sale_25042023/data/repository/product_repository.dart';
import 'package:flutter_app_sale_25042023/presentation/page/product/bloc/product_bloc.dart';
import 'package:flutter_app_sale_25042023/presentation/page/product/bloc/product_event.dart';
import 'package:flutter_app_sale_25042023/data/local/app_sharepreference.dart';
import 'package:flutter_app_sale_25042023/utils/message_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        title: const Text("Products"),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            Navigator.pushNamed(context, AppConstants.SIGN_IN_ROUTE_NAME);
            AppSharePreference.setString(
                key: AppConstants.KEY_TOKEN,
                value: ""
            );
          },
        ),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 10, top: 10),
              child: IconButton(
                icon: Icon(Icons.history),
                onPressed: () {
                  Navigator.pushNamed(context, AppConstants.ORDER_ROUTE_NAME);
                  //Navigator.pushNamed(context, AppConstants.SIGN_IN_ROUTE_NAME);
                  //MessageUtils.showMessage(context, "Alert!!", "You have not entered enough information");
                },
              )
             //Icon(Icons.history),
          ),
          SizedBox(width: 10),
          Consumer<ProductBloc>(
            builder: (context, bloc, child){
              return StreamBuilder<CartValueObject>(
                  initialData: null,
                  stream: bloc.cartStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError || snapshot.data == null || snapshot.data?.listProduct.isEmpty == true) {
                      return InkWell(
                        child: Container(
                            margin: EdgeInsets.only(right: 10, top: 10),
                            child: Icon(Icons.shopping_cart_outlined)
                        ),
                      );
                    }
                    int count = 0;
                    snapshot.data?.listProduct.forEach((element) {
                      count += element.quantity.toInt();
                    });
                    return Container(
                      margin: EdgeInsets.only(right: 10, top: 10),
                      child: badges.Badge(
                        badgeContent: Text(count.toString(), style: const TextStyle(color: Colors.white),),
                        child: IconButton(
                          icon: Icon(Icons.shopping_cart_outlined),
                          onPressed: () {
                            Navigator.pushNamed(context, AppConstants.CART_ROUTE_NAME);
                            //MessageUtils.showMessage(context, "Alert!!", "Cart Page");
                          },
                        )
                        //Icon(Icons.shopping_cart_outlined),
                      ),
                    );
                  }
              );
            },
          ),
          SizedBox(width: 10),
        ],
      ),
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
          update: (_, request, repository) {
            repository ??= CartRepository();
            repository.setApiRequest(request);
            return repository;
          },
        ),
        ProxyProvider2<ProductRepository, CartRepository, ProductBloc>(
          create: (context) => ProductBloc(),
          update: (_, productRepo, cartRepo, bloc) {
            bloc ??= ProductBloc();
            bloc.setProductRepository(productRepo);
            bloc.setCartRepository(cartRepo);
            return bloc;
          },
        )
      ],
      child: ProductContainer(),
    );
  }
}

class ProductContainer extends StatefulWidget {

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {

  ProductBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
    _bloc?.eventSink.add(FetchProductsEvent());
    _bloc?.eventSink.add(FetchCartEvent());
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: StreamBuilder<List<ProductValueObject>>(
              initialData: const [],
              stream: _bloc?.productStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError || snapshot.data?.isEmpty == true) {
                  return Container(
                    child: Center(child: Text("Data empty")),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _buildItemFood(snapshot.data?[index], () {
                        _bloc?.eventSink.add(AddCartEvent(idProduct: snapshot.data?[index].id ?? ""));
                      });
                    }
                );
              }
          ),
        ),
        LoadingWidget(bloc: _bloc),
      ],
    );
  }

  Widget _buildItemFood(ProductValueObject? product, Function()? eventAddCart) {
    if (product == null) return Container();
    return SizedBox(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(AppConstants.BASE_URL + product.img,
                    width: 150, height: 120, fit: BoxFit.fill),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(product.name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : ${NumberFormat("#,###", "en_US")
                              .format(product.price)} đ",
                          style: const TextStyle(fontSize: 12)),
                      Row(
                          children:[
                            ElevatedButton(
                              onPressed: eventAddCart,
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return const Color.fromARGB(200, 240, 102, 61);
                                    } else {
                                      return const Color.fromARGB(230, 240, 102, 61);
                                    }
                                  }),
                                  shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))))),
                              child:
                              const Text("Thêm vào giỏ", style: TextStyle(fontSize: 14)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: ElevatedButton(
                                onPressed: (){
                                  
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.pressed)) {
                                        return const Color.fromARGB(200, 11, 22, 142);
                                      } else {
                                        return const Color.fromARGB(230, 11, 22, 142);
                                      }
                                    }),
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))))),
                                child:
                                Text("Chi tiết", style: const TextStyle(fontSize: 14)),
                              ),
                            ),
                          ]
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


