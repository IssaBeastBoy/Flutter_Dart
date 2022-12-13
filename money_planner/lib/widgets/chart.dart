import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get groupTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (int index = 0; index < transactions.length; index++) {
        if (transactions[index].date.day == weekDay.day &&
            transactions[index].date.month == weekDay.month &&
            transactions[index].date.year == weekDay.year) {
          totalSum += transactions[index].amount;
        }
      }
      ;

      //final String formatted = '${DateFormat.E(weekDay)}';

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpent {
    return groupTransactions.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupTransactions);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupTransactions.map((data) {
          return ChartBar('${data['day']}', (data['amount'] as double),
              totalSpent == 0 ? 0.0 : (data['amount'] as double) / totalSpent);
        }).toList(),
      ),
    );
  }
}
