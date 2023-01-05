import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Widget
import '../widgets/messages.dart';
import '../widgets/sendMessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

// No implementation of push messages due to Firebase Subscription requirement

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Let\sTalk'),
          actions: [
            DropdownButton(
              items: [
                DropdownMenuItem(
                    value: 'Logout',
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Logout'),
                        ],
                      ),
                    ))
              ],
              onChanged: (selected) {
                if (selected == 'Logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
              icon: Icon(Icons.more_vert),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [Expanded(child: Messages()), SendMessage()],
          ),
        ));
  }
}
