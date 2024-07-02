import 'package:coyote/models/loan_model.dart';
import 'package:coyote/type/date_time_extension.dart';
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
      client_id INTEGER NOT NULL,
      amount REAL NOT NULL,
      quotas INTEGER NOT NULL,
      work_days TEXT NOT NULL,
      create_at INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
  ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> insert(LoanModel client) async {
    final db = await instance.database;
    final index = await db.insert(table, client.toMap());
    await updatePosition(index, client.position!);
    return index;
  }

  Future<List<LoanModel>> getAllLoans() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      table,
      orderBy: 'position ASC',
    );
    return List.generate(maps.length, (i) {
      return LoanModel(
        id: maps[i]['id'],
        position: maps[i]['position'],
        clientId: maps[i]['client_id'],
        amount: maps[i]['amount'],
        quotas: maps[i]['quotas'],
        workDays: maps[i]['work_days'],
        createAt: DateTime.fromMillisecondsSinceEpoch(maps[i]['create_at']),
      );
    });
  }

  Future<LoanModel> getLoanById(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      orderBy: 'create_at DESC',
    );
    return LoanModel(
      id: maps[0]['id'],
      position: maps[0]['position'],
      clientId: maps[0]['client_id'],
      amount: maps[0]['amount'],
      quotas: maps[0]['quotas'],
      workDays: maps[0]['work_days'],
      createAt: DateTime.fromMillisecondsSinceEpoch(maps[0]['create_at']),
    );
  }

  Future<List<LoanModel>> getLoansByDate(String date) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(table, orderBy: 'create_at DESC');
    final list = List.generate(maps.length, (i) {
      return LoanModel(
        id: maps[i]['id'],
        position: maps[i]['position'],
        clientId: maps[i]['client_id'],
        amount: maps[i]['amount'],
        quotas: maps[i]['quotas'],
        workDays: maps[i]['work_days'],
        createAt: DateTime.fromMillisecondsSinceEpoch(maps[i]['create_at']),
      );
    });
    return list.where((element) {
      return DateTimeExtension().toHumanize(element.createAt).contains(date);
    }).toList();
  }

  Future<void> updatePosition(int id, int newPosition) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> existingItem = await db.query(
      table,
      where: 'position = ?',
      whereArgs: [newPosition],
    );

    if (existingItem.isNotEmpty) {
      await updatePosition(existingItem.first['id'], newPosition + 1);
    }

    await db.update(
      table,
      {'position': newPosition},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(LoanModel client) async {
    final db = await instance.database;
    return await db.update(
      table,
      client.toMap(),
      where: 'id = ?',
      whereArgs: [client.id],
    );
  }
}
