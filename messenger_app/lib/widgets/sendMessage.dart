import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({super.key});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  final _messageTextController = new TextEditingController();
  String _message = '';

  void _sendMesssage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser!;
    final userInfo = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _message,
      'sentOn': Timestamp.now(),
      'userId': user.uid,
      'userImage': userInfo['userImage']
    });
    _messageTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageTextController,
              decoration: InputDecoration(label: Text('Write message..')),
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            ),
          ),
          Expanded(
              child: IconButton(
            onPressed: _message.trim().isEmpty ? null : _sendMesssage,
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          ))
        ],
      ),
    );
  }
}
