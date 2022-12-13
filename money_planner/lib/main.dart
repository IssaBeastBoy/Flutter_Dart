import 'package:flutter/material.dart';

import '../widgets/new_transactions.dart';
import '../widgets/transaction_list.dart';
import '../model/transaction.dart';

import '../widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money tracker',
      theme: ThemeData(
          // primarySwatch: Colors.cyan,
          // fontFamily: 'Quicksand',
          ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> _userTransactions = [
    // Transactions(
    //     id: "t1", title: "New Shoes", amount: 1200, date: DateTime.now()),
    // Transactions(id: "t1", title: "Weekly", amount: 250, date: DateTime.now())
  ];

  Iterable<Transactions> get _currWeekTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    });
  }

  void _addNewTransaction(String titleItem, double amountItem) {
    final newTransItem = new Transactions(
        title: titleItem,
        amount: amountItem,
        date: DateTime.now(),
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTransItem);
    });
  }

  void _startAddNewTrans(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Money Tracker'),
          actions: [
            IconButton(
                onPressed: () => _startAddNewTrans(context),
                icon: Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            Chart(_currWeekTransactions.toList()),
            TransactionList(_userTransactions),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _startAddNewTrans(context),
            child: Icon(Icons.add)));
  }
}
