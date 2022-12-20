import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productKey;
  final String title;
  final double price;
  final int qauntity;

  CartItem(
      {required this.id,
      required this.productKey,
      required this.title,
      required this.price,
      required this.qauntity});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: ((direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productKey);
      }),
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete),
        alignment: Alignment.centerRight,
      ),
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: FittedBox(
                child: CircleAvatar(
                  child: Text('R ${price}'),
                ),
              ),
              title: Text(title),
              subtitle: Text('Total ${qauntity * price}'),
              trailing: Text(' Qauntity ${qauntity}'),
            ),
          )),
    );
  }
}
