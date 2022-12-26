import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../providers/order.dart';

// Widgets
import '../widget/orderItem.dart';
import '../widget/drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Oders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) =>
            OrderItem(orderInfo: ordersData.orders[index]),
        itemCount: ordersData.orders.length,
      ),
    );
  }
}
