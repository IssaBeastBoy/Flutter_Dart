import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

// Modals
import '../modals/http_exception.dart';

class Auth with ChangeNotifier {
  String _token = '';
  DateTime? _expiryDate = null;
  String _userId = '';
  Timer? _timer;

  bool get userAuth {
    return !token.isEmpty;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (!_token.isEmpty &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return '';
  }

  Future<void> signUp(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAjPCSJw_uRVMRdMBQfb-tmUzZ4qMEbJ7Y';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _userId = responseData['localId'];
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'expiryDate': _expiryDate!.toIso8601String(),
        'userId': userId,
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAjPCSJw_uRVMRdMBQfb-tmUzZ4qMEbJ7Y';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _userId = responseData['localId'];
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'expiryDate': _expiryDate!.toIso8601String(),
        'userId': userId,
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    } else {
      final storeUserData = json.decode(prefs.getString('userData').toString())
          as Map<String, Object>;
      final expiryDate = DateTime.parse(storeUserData['expiryDate'].toString());
      if (expiryDate.isBefore(DateTime.now())) {
        return false;
      } else {
        _token = storeUserData['token'] as String;
        _expiryDate = storeUserData['expiryDate'] as DateTime;
        _userId = storeUserData['userId'] as String;
        notifyListeners();
        _autoLogout();
        return true;
      }
    }
  }

  Future<void> logout() async {
    _token = '';
    _expiryDate = null;
    _userId = '';
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  void _autoLogout() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    final endSession = _expiryDate!.difference(DateTime.now()).inSeconds;
    _timer = Timer(Duration(seconds: endSession), logout);
  }
}
