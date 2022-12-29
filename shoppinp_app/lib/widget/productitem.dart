import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screen
import '../screens/productdetail.dart';

// Provider
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/products_provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final productInfo = Provider.of<Product>(context, listen: false);
    final snackbar = ScaffoldMessenger.of(context);
    final products = Provider.of<Products>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetail.routeName, arguments: productInfo.id);
          },
          child: Image.network(
            productInfo.imageUrl as String,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          leading: IconButton(
            icon: Icon(productInfo.isFavorite
                ? Icons.favorite
                : Icons.favorite_border),
            color: Theme.of(context).accentColor,
            onPressed: () async {
              try {
                await products.setFavorite(
                    productInfo.id, !productInfo.isFavorite);
                //productInfo.toggleFavoriteStatus();
              } catch (error) {
                snackbar.showSnackBar(SnackBar(
                    content: Text(
                  'Failed to set Favorite',
                  textAlign: TextAlign.center,
                )));
              }
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(
                  productInfo.id, productInfo.price, productInfo.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Item add to cart',
                  textAlign: TextAlign.center,
                ),
                duration: Duration(seconds: 1),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    cart.removeSingleItem(productInfo.id);
                  },
                ),
              ));
            },
          ),
          title: Text(
            productInfo.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
