import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import '../screens/user_products.dart';
import '../screens/product_setting.dart';

// Provider
import '../providers/products_provider.dart';

class UserItems extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;

  UserItems(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.price});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      subtitle: Text('Price: R ${price}'),
      trailing: Column(
        children: [
          Container(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ProductSetting.routeName, arguments: id);
                  },
                  icon: Icon(Icons.edit),
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  onPressed: () {
                    products.removeProduct(id);
                  },
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
