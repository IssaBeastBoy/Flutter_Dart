import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageDesign extends StatelessWidget {
  final String message;
  final bool currUser;
  final String userId;
  final String userImage;
  final Key key;

  MessageDesign(this.message, this.currUser, this.userId, this.userImage,
      {required this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              !currUser ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: currUser
                    ? Theme.of(context).primaryColor
                    : Colors.grey[400],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft:
                      currUser ? Radius.circular(12) : Radius.circular(0),
                  bottomRight:
                      currUser ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              child: Column(
                crossAxisAlignment: currUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(this.userId)
                          .get(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Loading...');
                        }
                        return Text(
                          snapshot.data!['username'].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        );
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        color: !currUser ? Colors.black : Colors.white),
                    textAlign: currUser ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          right: currUser ? 120 : null,
          left: currUser ? null : 120,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        )
      ],
    );
  }
}
