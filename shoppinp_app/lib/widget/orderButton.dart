import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider
import '../providers/cart.dart';
import '../providers/order.dart';

class OrderButton extends StatefulWidget {
  final Cart cart;

  OrderButton({required this.cart});

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: _isLoading ? CircularProgressIndicator() : Text('Order'),
        onPressed: widget.cart.total <= 0 || _isLoading
            ? null
            : (() async {
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrder(
                    widget.cart.items.values.toList(), widget.cart.total);
                setState(() {
                  _isLoading = false;
                });
                widget.cart.clear();
              }));
  }
}
