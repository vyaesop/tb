
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transaction.dart' as txn;
import '../models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'telebirr.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL,
        amount REAL NOT NULL,
        type TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phoneNumber TEXT NOT NULL,
        balance REAL NOT NULL
      )
    ''');
  }

  Future<void> addTransaction(txn.Transaction transaction) async {
    final db = await database;
    await db.insert('transactions', transaction.toMap());

    // Update user balance
    User? user = await getUser();
    if (user != null) {
      if (transaction.type == 'receive') {
        user.balance += transaction.amount;
      } else {
        user.balance -= transaction.amount;
      }
      await saveUser(user);
    }
  }

  Future<List<txn.Transaction>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions', orderBy: 'date DESC');
    return List.generate(maps.length, (i) {
      return txn.Transaction.fromMap(maps[i]);
    });
  }
  
  Future<double> getBalance() async {
    User? user = await getUser();
    return user?.balance ?? 0;
  }

  Future<void> saveUser(User user) async {
    final db = await database;
    if (user.id != null) {
      await db.update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
    } else {
      await db.insert('users', user.toMap());
    }
  }

  Future<User?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      // Create a default user if none exists
      User defaultUser = User(name: 'John Doe', phoneNumber: '+251912345678', balance: 1000.0);
      await saveUser(defaultUser);
      return defaultUser;
    }
  }
}
