import 'package:coyote/models/loan_model.dart';
import 'package:sqflite/sqflite.dart';

class LoanDatabase {
  static final LoanDatabase instance = LoanDatabase._init();
  static Database? _database;

  LoanDatabase._init();

  final String table = 'loans';

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
      position INTEGER,
      user_id TEXT NOT NULL,
      amount REAL NOT NULL,
      quotas INTEGER NOT NULL
    )
  ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> insert(LoanModel client) async {
    final db = await instance.database;
    return await db.insert(table, client.toMap());
  }

  Future<List<LoanModel>> getAllLoans() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return LoanModel(
        id: maps[i]['id'],
        position: maps[i]['position'],
        userId: maps[i]['user_id'],
        amount: maps[i]['amount'],
        quotas: maps[i]['quotas'],
      );
    });
  }
}
