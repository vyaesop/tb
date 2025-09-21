
import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  User? _user;

  User? get user => _user;

  UserProvider() {
    loadUser();
  }

  Future<void> loadUser() async {
    _user = await _dbHelper.getUser();
    notifyListeners();
  }

  Future<void> saveUser(User user) async {
    await _dbHelper.saveUser(user);
    await loadUser();
  }
}
