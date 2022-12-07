import 'package:flutter/material.dart';

import './question.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppSate();
  }
}

class MyAppSate extends State<MyApp> {
  var _questionIndex = 0;

  void _answerQuestion() {
    setState(() {      
      _questionIndex = _questionIndex + 1;
      if (_questionIndex == 3) {
        _questionIndex = 0;
      }
    });
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      "Name",
      "Surname",
      "Email",
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Changing State"),
        ),
        body: Column(
          children: [
            Question(questions[_questionIndex]),
            ElevatedButton(
              child: Text("Answer 1"),
              onPressed: _answerQuestion,
            ),
            ElevatedButton(
              child: Text("Answer 2"),
              onPressed: _answerQuestion,
            ),
          ],
        ),
      ),
    );
  }
}
