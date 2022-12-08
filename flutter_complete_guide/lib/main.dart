import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';
import './quiz.dart';
import './result.dart';

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
  final _questions = const [
    {
      'questionText': 'Name',
      "answers": ['Thulani', 'Litha', 'Kid']
    },
    {
      "questionText": 'Surname',
      'answers': ['Tshabalala', 'Hashe', "NA"]
    },
    {
      "questionText": 'Email',
      'answers': ['t@gmal', 'l@gmail', 'NA']
    }
  ];

  void _answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Changing State"),
        ),
        body: _questionIndex > _questions.length
            ? Quiz(_questions, _questionIndex, _answerQuestion)
            : Result(),
      ),
    );
  }
}
