import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../providers/order.dart';

// Widgets
import '../widget/orderItem.dart';
import '../widget/drawer.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false)
          .fetchOrders()
          .then((_) {});
      setState(() {
        _isLoading = false;
      });
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Oders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemBuilder: (ctx, index) =>
            OrderItem(orderInfo: ordersData.orders[index]),
        itemCount: ordersData.orders.length,
      ),
    );
  }
}
