import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/expense.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'trackme.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE budget(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE expenses(
        id TEXT PRIMARY KEY,
        title TEXT,
        amount REAL,
        date TEXT,
        category TEXT
      )
    ''');

    // Initialize budget with 0
    await db.insert('budget', {'amount': 0.0});
  }

  // Budget Operations
  Future<double> getBudget() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('budget');
    if (maps.isNotEmpty) {
      return maps.first['amount'] as double;
    }
    return 0.0;
  }

  Future<void> updateBudget(double amount) async {
    final db = await database;
    // We only have one row for budget
    await db.update(
      'budget',
      {'amount': amount},
      where: 'id = ?',
      whereArgs: [1], // Assuming the first row has ID 1
    );

    // If update fails (e.g. table was empty/cleared), insert it
    final count = await db.query('budget');
    if (count.isEmpty) {
      await db.insert('budget', {'id': 1, 'amount': amount});
    }
  }

  // Expense Operations
  Future<List<Expense>> getExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  Future<void> insertExpense(Expense expense) async {
    final db = await database;
    await db.insert(
      'expenses',
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateExpense(Expense expense) async {
    final db = await database;
    await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<void> deleteExpense(String id) async {
    final db = await database;
    await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
