import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/new_transactions.dart';
import '../widgets/transaction_list.dart';
import '../model/transaction.dart';

import '../widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transactions> _userTransactions = [
    // Transactions(
    //     id: "t1", title: "New Shoes", amount: 1200, date: DateTime.now()),
    // Transactions(id: "t1", title: "Weekly", amount: 250, date: DateTime.now())
  ];

  bool _showChart = false;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  Iterable<Transactions> get _currWeekTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    });
  }

  void _addNewTransaction(
      String titleItem, double amountItem, DateTime chosenDate) {
    final newTransItem = new Transactions(
        title: titleItem,
        amount: amountItem,
        date: chosenDate,
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

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Money Tracker'),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTrans(context), icon: Icon(Icons.add))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final orientationType =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final transList = Container(
      height: (MediaQuery.of(context).size.height -
              _buildAppBar().preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    return Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: [
            if (orientationType)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = !_showChart;
                        });
                      })
                ],
              ),
            if (!orientationType)
              Container(
                height: (MediaQuery.of(context).size.height -
                        _buildAppBar().preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_currWeekTransactions.toList()),
              ),
            if (!orientationType) transList,
            if (orientationType)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              _buildAppBar().preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_currWeekTransactions.toList()),
                    )
                  : transList,
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _startAddNewTrans(context),
            child: Icon(Icons.add)));
  }
}
