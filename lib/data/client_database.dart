import 'package:coyote/models/client_model.dart';
import 'package:sqflite/sqflite.dart';

class ClientDatabase {
  static final ClientDatabase instance = ClientDatabase._init();
  static Database? _database;

  ClientDatabase._init();

  final String table = 'clients';

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
      name TEXT NOT NULL,
      address TEXT NOT NULL,
      phone_number TEXT NOT NULL
    )
  ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> insert(ClientModel client) async {
    final db = await instance.database;
    return await db.insert(table, client.toMap());
  }

  Future<List<ClientModel>> getAllClients() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return ClientModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        address: maps[i]['address'],
        phoneNumber: maps[i]['phone_number'],
      );
    });
  }

  Future<ClientModel> getClient(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(table, where: 'id = ?', whereArgs: [id]);
    return ClientModel(
      id: maps[0]['id'],
      name: maps[0]['name'],
      address: maps[0]['address'],
      phoneNumber: maps[0]['phone_number'],
    );
  }
}
