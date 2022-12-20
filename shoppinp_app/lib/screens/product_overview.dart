import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Modals

// Widget
import '../widget/badge.dart';
import '../widget/product_gridview.dart';

// Provider
import '../providers/cart.dart';

// Screens
import '../screens/cart.dart';

enum filterOption {
  Favorites,
  All;
}

class ProductOverView extends StatefulWidget {
  @override
  State<ProductOverView> createState() => _ProductOverViewState();
}

class _ProductOverViewState extends State<ProductOverView> {
  var _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    //final products = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
              onSelected: (filterOption value) {
                setState(() {
                  if (value == filterOption.Favorites) {
                    _showFavorites = true;
                  } else {
                    _showFavorites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only Favorites'),
                      value: filterOption.Favorites,
                    ),
                    PopupMenuItem(
                        child: Text('Show All'), value: filterOption.All),
                  ]),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              value: cart.itemCount.toString(),
              child: child as Widget,
            ),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                }),
          ),
        ],
      ),
      body: ProductGridView(_showFavorites),
    );
  }
}