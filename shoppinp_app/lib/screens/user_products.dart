import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../providers/products_provider.dart';

// Widget
import '../widget/user_product.dart';
import '../widget/drawer.dart';

// Screen
import '../screens/product_setting.dart';

class UserProducts extends StatelessWidget {
  static const routeName = '/userProducts';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ProductSetting.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: ((ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<Products>(
                      builder: (ctx, products, _) => Padding(
                        padding: EdgeInsets.all(10),
                        child: ListView.builder(
                          itemBuilder: (_, index) => UserItems(
                              id: products.items[index].id,
                              title: products.items[index].title,
                              imageUrl: products.items[index].imageUrl,
                              price: products.items[index].price),
                          itemCount: products.items.length,
                        ),
                      ),
                    ),
                  )),
      ),
    );
  }
}
