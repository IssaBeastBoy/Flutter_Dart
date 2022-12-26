import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import './screens/product_overview.dart';
import './screens/productdetail.dart';
import './screens/cart.dart';
import './screens/orders.dart';

// Providers
import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/order.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        routes: {
          '/': (ctx) => ProductOverView(),
          ProductDetail.routeName: ((ctx) => ProductDetail()),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
        },
      ),
    );
  }
}
