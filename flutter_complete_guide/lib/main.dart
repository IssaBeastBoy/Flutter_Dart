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
      "answers": [
        {'text': 'Thulani', 'detail': 'Mr'},
        {'text': 'Litha', 'detail': 'Miss'},
        {'text': 'Kid', 'detail': 'NA'}
      ]
    },
    {
      "questionText": 'Surname',
      'answers': [
        {'text': 'Tshabalala', 'detail': '1997'},
        {'text': 'Hashe', 'detail': '1995'},
        {'text': "NA", 'detail': '>=13'}
      ]
    },
    {
      "questionText": 'Email',
      'answers': [
        {'text': 't@gmal', 'detail': 'Gmail'},
        {'text': 'l@gmail', 'detail': 'Gmail'},
        {'text': 'NA', 'detail': 'NA'}
      ]
    }
  ];

  String _information = '';

  void _resetQuestion() {
    setState(() {
      _information = '';
      _questionIndex = 0;
    });
  }

  void _answerQuestion(String details) {
    _information = _information + ' ' + details;    
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
        body: _questionIndex < _questions.length
            ? Quiz(_questions, _questionIndex, _answerQuestion)
            : Result(_information, _resetQuestion),
      ),
    );
  }
}
