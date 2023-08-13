import 'package:flutter/material.dart';
import 'package:flutter_app_sale_25042023/common/app_constants.dart';
import 'package:flutter_app_sale_25042023/data/local/app_sharepreference.dart';
import 'package:flutter_app_sale_25042023/presentation/page/product/product_page.dart';
import 'package:flutter_app_sale_25042023/presentation/page/order/order_history_page.dart';
import 'package:flutter_app_sale_25042023/presentation/page/cart/cart_page.dart';
import 'package:flutter_app_sale_25042023/presentation/page/sign_in/sign_in_page.dart';
import 'package:flutter_app_sale_25042023/presentation/page/sign_up/sign_up_page.dart';
import 'package:flutter_app_sale_25042023/presentation/page/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
  AppSharePreference.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        AppConstants.SIGN_IN_ROUTE_NAME: (context) => SignInPage(),
        AppConstants.SIGN_UP_ROUTE_NAME: (context) => SignUpPage(),
        AppConstants.PRODUCT_ROUTE_NAME: (context) => ProductPage(),
        AppConstants.SPLASH_ROUTE_NAME: (context) => SplashPage(),
        AppConstants.ORDER_ROUTE_NAME: (context) => OrderHistoryPage(),
        AppConstants.CART_ROUTE_NAME: (context) => CartPage()
      },
      initialRoute: AppConstants.SPLASH_ROUTE_NAME,
    );
  }
}
