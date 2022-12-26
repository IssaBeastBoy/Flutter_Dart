// Models
import './cartItem.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime orderDate;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.orderDate});
}
