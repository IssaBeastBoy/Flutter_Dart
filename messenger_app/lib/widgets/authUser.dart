import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// widgets
import '../widgets/set_image.dart';

class AuthUser extends StatefulWidget {
  final void Function(
    String email,
    String username,
    String password,
    File selectedImage,
    bool isLogin,
    BuildContext context,
  ) setUser;

  const AuthUser(this.setUser);

  @override
  State<AuthUser> createState() => _AuthUserState();
}

class _AuthUserState extends State<AuthUser> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  String _userComfirm = '';
  File? _userImage;

  bool _isLogin = true;

  void _pickedImage(File image) {
    _userImage = image;
  }

  void _onSubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.setUser(_userEmail.trim(), _userName.trim(), _userPassword.trim(),
          _userImage!, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: EdgeInsets.all(25),
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) SetProfilePicture(_pickedImage),
                TextFormField(
                  key: ValueKey('email'),
                  onSaved: (newValue) {
                    _userEmail = newValue.toString();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email address';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter valid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email address',
                  ),
                ),
                if (!_isLogin)
                  TextFormField(
                      onSaved: (newValue) {
                        _userName = newValue.toString();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter user name';
                        }
                        if (value.length < 3) {
                          return 'User name too short';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'User Name')),
                TextFormField(
                    key: ValueKey('password'),
                    onSaved: (newValue) {
                      _userPassword = newValue.toString();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value.length < 5) {
                        return 'Password too short';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password')),
                if (!_isLogin)
                  TextFormField(
                      onSaved: (newValue) {
                        _userComfirm = newValue.toString();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        if (value.length < 5) {
                          return 'Password too short';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration:
                          InputDecoration(labelText: 'Confirm Password')),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: _onSubmit,
                    child: Text(_isLogin ? 'Login' : "SignUp")),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create Acount'
                        : "I already have an account")),
              ],
            )),
      )),
    ));
  }
}
