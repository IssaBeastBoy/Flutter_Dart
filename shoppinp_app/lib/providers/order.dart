import 'package:flutter/foundation.dart';

// Modal
import '../modals/orderItem.dart';
import '../modals/cartItem.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _order = [];

  List<OrderItem> get orders {
    return [..._order];
  }

  void addOrder(List<CartItem> items, double total) {
    _order.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            products: items,
            orderDate: DateTime.now()));
    notifyListeners();
  }
}
