import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screen
import '../screens/orders.dart';
import '../screens/user_products.dart';

// Provider
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello, here\'s your options'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: (() {
              Navigator.of(context).pushReplacementNamed('/');
            }),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: (() {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            }),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: (() {
              Navigator.of(context)
                  .pushReplacementNamed(UserProducts.routeName);
            }),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log out'),
            onTap: (() {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
            }),
          )
        ],
      ),
    );
  }
}
