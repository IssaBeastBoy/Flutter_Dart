import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import './screens/product_overview.dart';
import './screens/productdetail.dart';
import './screens/cart.dart';
import './screens/orders.dart';
import './screens/user_products.dart';
import './screens/product_setting.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

// Providers
import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/order.dart';
import './providers/auth.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products('', '', []),
          update: (ctx, auth, previous) =>
              Products(auth.token, auth.userId, previous!.items),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders('', '', []),
          update: (context, auth, orders) =>
              Orders(auth.token, auth.userId, orders!.orders),
        ),
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        routes: {
                  '/': (ctx) => auth.userAuth
                      ? ProductOverView()
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: ((context, snapshot) =>
                              snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? SplashScreen()
                                  : AuthScreen())),
          ProductDetail.routeName: ((ctx) => ProductDetail()),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          UserProducts.routeName: (ctx) => UserProducts(),
          ProductSetting.routeName: (ctx) => ProductSetting(),
        },
              )
        
      ),
    );
  }
}
