import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Modals

// Widget
import '../widget/badge.dart';
import '../widget/product_gridview.dart';
import '../widget/drawer.dart';

// Provider
import '../providers/cart.dart';
import '../providers/products_provider.dart';

// Screens
import '../screens/cart.dart';

enum filterOption {
  Favorites,
  All;
}

class ProductOverView extends StatefulWidget {
  static const routeName = '/shop';
  @override
  State<ProductOverView> createState() => _ProductOverViewState();
}

class _ProductOverViewState extends State<ProductOverView> {
  var _showFavorites = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGridView(_showFavorites),
    );
  }
}
