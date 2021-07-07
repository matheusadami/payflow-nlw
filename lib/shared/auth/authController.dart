import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:payflow/shared/models/userModel.dart';

class AuthController {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel? user) {
    _user = user ?? null;
  }

  Future<void> saveUser(UserModel user) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    await shared.setString('user', user.toJson());
    setUser(user);
  }

  Future<bool> removeUser() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    if (shared.containsKey('user')) {
      await shared.remove('user');
    }
    return true;
  }

  Future<void> currentUser(BuildContext context) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    if (shared.containsKey('user')) {
      String user = shared.get('user') as String;
      setUser(UserModel.fromJson(user));
    } else {
      setUser(null);
    }
  }

  void redirectUser(BuildContext context) {
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home', arguments: user);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
