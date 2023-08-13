import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_app_sale_25042023/common/app_constants.dart';
import 'package:flutter_app_sale_25042023/common/base/base_widget.dart';
import 'package:flutter_app_sale_25042023/common/widget/loading_widget.dart';
import 'package:flutter_app_sale_25042023/data/api/api_request.dart';
import 'package:flutter_app_sale_25042023/data/model/order_history_value_object.dart';
import 'package:flutter_app_sale_25042023/data/repository/order_history_repository.dart';
import 'package:flutter_app_sale_25042023/presentation/page/order/bloc/order_bloc.dart';
import 'package:flutter_app_sale_25042023/presentation/page/order/bloc/order_event.dart';
import 'package:flutter_app_sale_25042023/presentation/page/product/bloc/product_event.dart';
import 'package:flutter_app_sale_25042023/utils/message_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        title: const Text("Order History"),
      ),
      providers: [
        Provider(create: (context) => ApiRequest()),
        ProxyProvider<ApiRequest, OrderHistoryRepository>(
          create: (context) => OrderHistoryRepository(),
          update: (_, request, repository) {
            repository ??= OrderHistoryRepository();
            repository.setApiRequest(request);
            return repository;
          },
        ),
      ],
      child: OrderHistoryContainer(),
    );
  }
}

class OrderHistoryContainer extends StatefulWidget {
  const OrderHistoryContainer({super.key});

  @override
  State<OrderHistoryContainer> createState() => _OrderHistoryContainerState();
}

class _OrderHistoryContainerState extends State<OrderHistoryContainer> {
  OrderBloc? _bloc;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = context.read();
    _bloc?.eventSink.add(FetchOrderEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
     LoadingWidget(bloc: _bloc),
      SafeArea(
        child: StreamBuilder<List<OrderHistoryValueObject>>(
          initialData: const [],
          stream: _bloc?.orderStream(),
          builder: (context, snapshot) {
            print(context);
            if (snapshot.hasError || snapshot.data?.isEmpty == true) {
              return Container(
                child: Center(child: Text("Data empty")),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return _buildItemFood(snapshot.data?[index]);
                }
            );
          }
        ),
      ),
      ],
    );
  }

  Widget _buildItemFood(OrderHistoryValueObject? orderHistory) {
    if (orderHistory == null) return Container();
    return SizedBox(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(orderHistory.dateCreated.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16)),
                  )
                  ],
                )
              ),
            )
            ],
          ),
        )
      ),
    );
  }
  
  
  
  
  
  /*
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text("Abc"),
            leading: Icon(Icons.add_call, color: Colors.blue),
            trailing: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text( "Click vào trailing")));
                },
                child: Icon(Icons.add)
            ),
          ),
        );
      },
    );
  }
   */
}

