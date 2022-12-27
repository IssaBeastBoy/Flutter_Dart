import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screen
import '../screens/productdetail.dart';

// Provider
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final productInfo = Provider.of<Product>(context);
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
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(productInfo.isFavorite
                ? Icons.favorite
                : Icons.favorite_border),
            color: Theme.of(context).accentColor,
            onPressed: () {
              productInfo.toggleFavoriteStatus();
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
                  'Item add tp cart',
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
