import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../providers/products_provider.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/productDetail';
  // final String title;

  // ProductDetail(this.title);

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context)!.settings.arguments as String;
    final product =
        Provider.of<Products>(context, listen: false).findById(productID);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Center(child: Text('Product')),
    );
  }
}
