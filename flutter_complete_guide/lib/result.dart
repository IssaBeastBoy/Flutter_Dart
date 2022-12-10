import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


class Result extends StatelessWidget {
  final String result;
  final Function reset;

  Result(this.result, this.reset);

  String get resultPhrase {
    var resultText = "Gathered information: \n";
    return resultText + this.result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            child: Text(
              "Go to start",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: reset,
            style: ElevatedButton.styleFrom(
                primary: Colors.white, onPrimary: Colors.black),
          ),
        ],
      )),
    );
  }
}
