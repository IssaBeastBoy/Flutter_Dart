import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Models
import '../widgets/authUser.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _submitUserForm(String email, String username, String password,
      File selectedIamge, bool isLogin, BuildContext ctx) async {
    UserCredential results;
    await Firebase.initializeApp();
    final _auth = FirebaseAuth.instance;
    String message = 'Please check your credentials. Error occured.';
    try {
      if (isLogin) {
        results = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        results = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(results.user!.uid + '.jpg');

        await ref.putFile(selectedIamge);

        final imageURL = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(results.user!.uid)
            .set({
          'username': username,
          'email': email,
          'password': password,
          'userImage': imageURL,
        });
      }
    } catch (err) {
      print(err.toString());
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Center(child: Text(message))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthUser(_submitUserForm),
    );
  }
}
