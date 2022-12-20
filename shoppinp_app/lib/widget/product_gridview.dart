import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../providers/products_provider.dart';

//Modal
import '../providers/product.dart';

// Widget
import './productitem.dart';

class ProductGridView extends StatelessWidget {
  final bool showFavorites;

  ProductGridView(this.showFavorites);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showFavorites ? productsData.favorites : productsData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: products[i], child: ProductItem()),
    );
  }
}
