import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;

  NewTransaction(this.newTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInput = TextEditingController();

  final _amountInpit = TextEditingController();

  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = _titleInput.text;
    final enteredAmount = double.parse(_amountInpit.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      // widget.newTransaction(enteredTitle, enteredAmount, _selectedDate);
      return;
    }
    widget.newTransaction(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickeddate) {
      if (pickeddate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickeddate;
        });
      }
    });
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
              controller: _titleInput,
              onSubmitted: (_) => _submitData,
            ),
            TextField(
              decoration: InputDecoration(label: Text('Amount')),
              controller: _amountInpit,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen!!'
                        : 'Picked Date: ${DateFormat.yMd().format((_selectedDate as DateTime))}')),
                TextButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ))
              ],
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.cyan)),
              onPressed: _submitData,
              child: Text(
                'Add transaction',
                style: TextStyle(color: Colors.white),
              ),
            )
          ])),
    );
  }
}
