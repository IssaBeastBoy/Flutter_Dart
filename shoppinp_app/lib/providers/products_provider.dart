import 'dart:convert';

// Package
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Modals
import 'product.dart';
import '../modals/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> get favorites {
    return _items.where((products) => products.isFavorite == true).toList();
  }

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> setFavorite(String prodId, bool isFav) async {
    final url =
        'https://fluttercourse-15292-default-rtdb.firebaseio.com/userFavorites/${userId}/${prodId}.json?auth=$authToken';
    final currProductTempIndex = _items.indexWhere((prod) => prod.id == prodId);
    Product? currProduct = _items[currProductTempIndex];
    final updateProd = Product(
        id: currProduct.id,
        title: currProduct.title,
        description: currProduct.description,
        price: currProduct.price,
        imageUrl: currProduct.imageUrl,
        isFavorite: isFav);
    _items[currProductTempIndex] = updateProd;
    notifyListeners();
    final response = await http.put(Uri.parse(url), body: json.encode(isFav));
    if (response.statusCode >= 400) {
      print(response.statusCode);
      _items[currProductTempIndex] = currProduct;
      notifyListeners();
      throw HttpException('Failed to update Favorite');
    }
    currProduct = null;
  }

  Future<void> fetchProducts([bool byUser = false]) async {
    String filter = byUser ? '&orderBy="creatorId"&equalTo="$userId"' : '';
    final url =
        'https://fluttercourse-15292-default-rtdb.firebaseio.com/products.json?auth=$authToken$filter';
    try {
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> tempList = [];
      if (responseData == null) {
        return;
      }
      final isFav =
          'https://fluttercourse-15292-default-rtdb.firebaseio.com/userFavorites/${userId}.json?auth=$authToken';
      final isFavResponse = await http.get(Uri.parse(isFav));
      final isFavData = json.decode(isFavResponse.body);
      responseData.forEach((prodId, prodInfo) async {
        tempList.add(Product(
          id: prodId,
          title: prodInfo['title'],
          description: prodInfo['description'],
          price: prodInfo['price'],
          imageUrl: prodInfo['imageUrl'],
          isFavorite: isFavData == null ? false : isFavData[prodId] ?? false,
        ));
        _items = tempList;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://fluttercourse-15292-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'creatorId': userId,
          }));

      Product newProduct = new Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(Product newProduct) async {
    final index = _items.indexWhere((product) => product.id == newProduct.id);
    if (index >= 0) {
      final url =
          'https://fluttercourse-15292-default-rtdb.firebaseio.com/products/${newProduct.id}.json?auth=$authToken';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
            'isFavorite': newProduct.isFavorite,
          }));
    }
    _items[index] = newProduct;
    notifyListeners();
  }

  Future<void> removeProduct(String productId) async {
    final url =
        'https://fluttercourse-15292-default-rtdb.firebaseio.com/products/${productId}.json?auth=$authToken';

    final selectedProductIndex =
        _items.indexWhere((product) => product.id == productId);
    Product? deletedProductTemp = _items[selectedProductIndex];
    _items.removeWhere((prod) => prod.id == productId);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(selectedProductIndex, deletedProductTemp);
      notifyListeners();
      throw HttpException("Could not delete product");
    }
    deletedProductTemp = null;
  }
}
