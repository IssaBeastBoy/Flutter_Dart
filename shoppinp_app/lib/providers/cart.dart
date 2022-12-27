import 'package:flutter/foundation.dart';

// Models
import '../modals/cartItem.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get total {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    notifyListeners();
    return total;
  }

  void addItem(String prodId, double price, String title) {
    if (_items.containsKey(prodId)) {
      _items.update(
          prodId,
          (currItem) => CartItem(
              Id: currItem.Id,
              title: currItem.title,
              quantity: currItem.quantity + 1,
              price: currItem.price));
    } else {
      _items.putIfAbsent(
          prodId,
          () => CartItem(
              Id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id]!.quantity > 1) {
      _items.update(
          id,
          (currItem) => CartItem(
              Id: currItem.Id,
              title: currItem.title,
              quantity: currItem.quantity - 1,
              price: currItem.price));
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
