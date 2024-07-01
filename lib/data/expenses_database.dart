import 'package:coyote/models/expense_model.dart';
import 'package:coyote/type/date_time_extension.dart';
import 'package:sqflite/sqflite.dart';

class ExpensesDatabase {
  static final ExpensesDatabase instance = ExpensesDatabase._init();
  static Database? _database;

  ExpensesDatabase._init();

  final String table = 'expenses';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('$table.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$filePath';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      description TEXT NOT NULL,
      amount REAL NOT NULL,
      create_at INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
  ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> insert(ExpenseModel client) async {
    final db = await instance.database;
    return await db.insert(table, client.toMap());
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return ExpenseModel(
        id: maps[i]['id'],
        amount: maps[i]['amount'],
        description: maps[i]['description'],
        createAt: DateTime.fromMillisecondsSinceEpoch(maps[i]['create_at']),
      );
    });
  }

  Future<ExpenseModel> getClient(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(table, where: 'id = ?', whereArgs: [id]);
    return ExpenseModel(
      id: maps[0]['id'],
      amount: maps[0]['amount'],
      description: maps[0]['description'],
      createAt: DateTime.fromMillisecondsSinceEpoch(maps[0]['create_at']),
    );
  }

  Future<List<ExpenseModel>> getExpensesByDate(String date) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    final list = List.generate(maps.length, (i) {
      return ExpenseModel(
        id: maps[i]['id'],
        amount: maps[i]['amount'],
        description: maps[i]['description'],
        createAt: DateTime.fromMillisecondsSinceEpoch(maps[i]['create_at']),
      );
    });

    return list.where((element) {
      return DateTimeExtension().toHumanize(element.createAt).contains(date);
    }).toList();
  }
}
