import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Modal
import '../modals/orderItem.dart';
import '../modals/cartItem.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _order = [];

  List<OrderItem> get orders {
    return [..._order];
  }

  Future<void> fetchOrders() async {
    const url =
        'https://fluttercourse-15292-default-rtdb.firebaseio.com/orders.json';
    final response = await http.get(Uri.parse(url));
    List<OrderItem> tempList = [];
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    if (responseData == null) {
      return;
    }
    responseData.forEach((orderId, orderInfo) {
      tempList.add(OrderItem(
          id: orderId,
          amount: orderInfo['amount'],
          products: (orderInfo['products'] as List<dynamic>)
              .map((prodInfo) => CartItem(
                  Id: prodInfo['Id'],
                  title: prodInfo['title'],
                  quantity: prodInfo['quantity'],
                  price: prodInfo['price']))
              .toList(),
          orderDate: DateTime.parse(orderInfo['orderDate'])));
    });
    _order = tempList.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> items, double total) async {
    const url =
        'https://fluttercourse-15292-default-rtdb.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          'amount': total,
          'orderDate': timestamp.toIso8601String(),
          'products': items
              .map((cartData) => {
                    'Id': cartData.Id,
                    'title': cartData.title,
                    'quantity': cartData.quantity,
                    'price': cartData.price,
                  })
              .toList(),
        }));

    _order.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: items,
            orderDate: timestamp));
    notifyListeners();
  }
}
