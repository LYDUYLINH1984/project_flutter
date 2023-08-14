import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_app_sale_25042023/data/model/cart_value_object.dart';
import 'package:flutter_app_sale_25042023/data/repository/cart_repository.dart';
import 'package:flutter_app_sale_25042023/presentation/page/cart/bloc/cart_bloc.dart';
import 'package:flutter_app_sale_25042023/presentation/page/cart/bloc/cart_event.dart';
import 'package:flutter_app_sale_25042023/utils/message_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_sale_25042023/common/app_constants.dart';
import 'package:flutter_app_sale_25042023/common/base/base_widget.dart';
import 'package:flutter_app_sale_25042023/common/widget/loading_widget.dart';
import 'package:flutter_app_sale_25042023/data/api/api_request.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
    appBar: AppBar(
      title: const Text("Cart Information"),
    ), 
      providers: [
        Provider(create: (context) => ApiRequest()),
        ProxyProvider<ApiRequest, CartRepository>(
          create: (context) => CartRepository(),
          update: (_, request, repository) {
            repository ??= CartRepository();
            repository.setApiRequest(request);
            return repository;
          },
        ),
        ProxyProvider<CartRepository, CartBloc>(
          create: (context) => CartBloc(),
          update: (_, cartRepo, bloc) {
            bloc ??= CartBloc();
            bloc.setCartRepository(cartRepo);
            return bloc;
          },
        )
        ],
      child: CartContainer(),
    );
  }
}

class CartContainer extends StatefulWidget {
  const CartContainer({super.key});

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
    _bloc?.eventSink.add(FetchCartEvent());
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
            if (snapshot.hasError || snapshot.data?.id.isEmpty == true) {
              return Container(
                child: Center(child: Text("Data empty")),
              );
              
            }
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return _buildCartItemFood(snapshot.data);
                }
            );
          },
        ),
      ),
        LoadingWidget(bloc: _bloc),
      ],
    );
  }
  Widget _buildCartItemFood(CartValueObject? cart){
    if (cart == null) return Container();
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
                    child: Image.network(AppConstants.BASE_URL + cart.listProduct[1].img,
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
                                child: Text(cart.listProduct[1].name.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 16)),
                              ),
                              Text(
                                  "Giá : ${NumberFormat("#,###", "en_US")
                                      .format(cart.listProduct[1].price)} đ",
                                  style: const TextStyle(fontSize: 12)),
                              Row(
                                  children:[
                                    ElevatedButton(
                                      onPressed: (){
                                        
                                      },
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
                                      const Text("+", style: TextStyle(fontSize: 14)),
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
                                        Text("-", style: const TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                  ]
                              )
                            ],
                          )
                      )
                  ),
                ]
            )
        )
        )
    );
  }
}
