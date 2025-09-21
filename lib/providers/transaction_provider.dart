
import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/transaction.dart' as txn;
import 'user_provider.dart';

class TransactionProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late UserProvider _userProvider;

  List<txn.Transaction> _transactions = [];
  List<txn.Transaction> get transactions => _transactions;

  TransactionProvider(this._userProvider) {
    loadTransactions();
  }

  void update(UserProvider userProvider) {
    _userProvider = userProvider;
  }

  Future<void> loadTransactions() async {
    _transactions = await _dbHelper.getTransactions();
    notifyListeners();
  }

  Future<void> addTransaction(txn.Transaction transaction) async {
    await _dbHelper.addTransaction(transaction);
    await loadTransactions();
    await _userProvider.loadUser();
  }
}
