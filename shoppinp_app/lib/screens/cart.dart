import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider
import '../providers/cart.dart' show Cart;

// Wdigets
import '../widget/cartItem.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(children: [
        Card(
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                Chip(
                  label: Text(
                    'R ${cart.total}',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                ElevatedButton(child: Text('Order'), onPressed: (() {}))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (ctx, i) => CartItem(
              id: cart.items.values.toList()[i].Id,
              productKey: cart.items.keys.toList()[i],
              title: cart.items.values.toList()[i].title,
              qauntity: cart.items.values.toList()[i].quantity,
              price: cart.items.values.toList()[i].price),
          itemCount: cart.items.length,
        ))
      ]),
    );
  }
}
