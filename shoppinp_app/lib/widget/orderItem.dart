import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

// Provider
import '../modals/orderItem.dart' as data;

class OrderItem extends StatefulWidget {
  final data.OrderItem orderInfo;

  OrderItem({required this.orderInfo});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('Orders Total: ${widget.orderInfo.amount}'),
              subtitle: Text(
                  DateFormat('dd/MM/yyyy').format(widget.orderInfo.orderDate)),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  icon: _expanded
                      ? Icon(Icons.expand_less)
                      : Icon(Icons.expand_more)),
            ),
            if (_expanded)
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(10),
                height: min(widget.orderInfo.products.length * 20 + 100, 100),
                child: ListView(
                  children: widget.orderInfo.products
                      .map((prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${prod.title} x ${prod.quantity}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Text('R ${prod.price}',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                            ],
                          ))
                      .toList(),
                ),
              )
          ],
        ));
  }
}
