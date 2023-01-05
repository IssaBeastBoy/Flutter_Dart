import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger_app/widgets/authUser.dart';

// Widget
import './messageDesign.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('sentOn', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapShot) {
        if (chatSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (chatSnapShot.data == null) {
          return Center(
            child: Text('No messages'),
          );
        }
        final chatDoc = chatSnapShot.data!.docs;
        final user = FirebaseAuth.instance;
        return ListView.builder(
            reverse: true,
            itemCount: chatDoc.length,
            itemBuilder: (ctx, i) => MessageDesign(
                chatDoc[i]['text'],
                chatDoc[i]['userId'] == user.currentUser!.uid,
                chatDoc[i]['userId'],
                chatDoc[i]['userImage'],
                key: ValueKey(chatDoc[i].id)));
      },
    );
  }
}
