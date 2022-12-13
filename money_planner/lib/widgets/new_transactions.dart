import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;

  NewTransaction(this.newTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInput = TextEditingController();

  final amountInpit = TextEditingController();

  void submitData() {
    final enteredTitle = titleInput.text;
    final enteredAmount = double.parse(amountInpit.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      widget.newTransaction(enteredTitle, enteredAmount);
      return;
    }
    widget.newTransaction(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
          margin: EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              decoration: InputDecoration(label: Text('Title')),
              controller: titleInput,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(label: Text('Amount')),
              controller: amountInpit,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
              ),
              onPressed: submitData,
              child: Text('Add transaction'),
            )
          ])),
    );
  }
}
