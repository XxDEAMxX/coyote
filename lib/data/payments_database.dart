import 'package:coyote/models/payment_model.dart';
import 'package:coyote/type/date_time_extension.dart';
import 'package:sqflite/sqflite.dart';

class PaymentsDatabase {
  static final PaymentsDatabase instance = PaymentsDatabase._init();
  static Database? _database;

  PaymentsDatabase._init();

  final String table = 'payments';

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
      loan_id INTEGER NOT NULL,
      quota_number INTEGER NOT NULL,
      date_payment INTEGER NOT NULL,
      amount_paid REAL NOT NULL,
      amount_to_be_paid REAL NOT NULL,
      updated_at INTEGER,
      FOREIGN KEY (loan_id) REFERENCES loans (id)
    )
  ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> insert(PaymentModel payment) async {
    final db = await instance.database;
    return await db.insert(table, payment.toMap());
  }

  Future<void> insertAll(
      PaymentModel payment, int quotas, String workDays) async {
    final db = await instance.database;
    DateTime date = DateTime.now().add(Duration(days: 1));

    for (int i = 0; i < quotas; i++) {
      if (workDays.contains('Lunes a Viernes')) {
        if (date.weekday == DateTime.saturday) {
          date = date.add(Duration(days: 2));
        } else if (date.weekday == DateTime.sunday) {
          date = date.add(Duration(days: 1));
        }
      } else if (workDays.contains('Lunes a Sabado')) {
        if (date.weekday == DateTime.sunday) {
          date = date.add(Duration(days: 1));
        }
      }
      await db.insert(table, payment.toMapAll(i + 1, date));
      date = date.add(Duration(days: 1));
    }
  }

  Future<List<PaymentModel>> getAllPayments() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return PaymentModel(
        id: maps[i]['id'],
        amountPaid: maps[i]['amount_paid'],
        amountToBePaid: maps[i]['amount_to_be_paid'],
        datePayment:
            DateTime.fromMillisecondsSinceEpoch(maps[i]['date_payment']),
        loanId: maps[i]['loan_id'],
        quotaNumber: maps[i]['quota_number'],
        updatedAt: maps[i]['updated_at'] != null
            ? DateTime.fromMillisecondsSinceEpoch(maps[i]['updated_at'])
            : null,
      );
    });
  }

  Future<PaymentModel> getPaymentById(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return PaymentModel(
      id: maps[0]['id'],
      amountPaid: maps[0]['amount_paid'],
      amountToBePaid: maps[0]['amount_to_be_paid'],
      datePayment: DateTime.fromMillisecondsSinceEpoch(maps[0]['date_payment']),
      loanId: maps[0]['loan_id'],
      quotaNumber: maps[0]['quota_number'],
      updatedAt: maps[0]['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(maps[0]['updated_at'])
          : null,
    );
  }

  Future<List<PaymentModel>> getPaymentByLoanId(int loanId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      table,
      where: 'loan_id = ?',
      whereArgs: [loanId],
    );
    return List.generate(maps.length, (i) {
      return PaymentModel(
        id: maps[i]['id'],
        amountPaid: maps[i]['amount_paid'],
        amountToBePaid: maps[i]['amount_to_be_paid'],
        datePayment:
            DateTime.fromMillisecondsSinceEpoch(maps[i]['date_payment']),
        loanId: maps[i]['loan_id'],
        quotaNumber: maps[i]['quota_number'],
        updatedAt: maps[i]['updated_at'] != null
            ? DateTime.fromMillisecondsSinceEpoch(maps[i]['updated_at'])
            : null,
      );
    });
  }

  Future<List<PaymentModel>> getPaymentsByDate(String date) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    final list = List.generate(maps.length, (i) {
      return PaymentModel(
        id: maps[i]['id'],
        amountPaid: maps[i]['amount_paid'],
        amountToBePaid: maps[i]['amount_to_be_paid'],
        datePayment:
            DateTime.fromMillisecondsSinceEpoch(maps[i]['date_payment']),
        loanId: maps[i]['loan_id'],
        quotaNumber: maps[i]['quota_number'],
        updatedAt: maps[i]['updated_at'] != null
            ? DateTime.fromMillisecondsSinceEpoch(maps[i]['updated_at'])
            : null,
      );
    });
    return list.where((element) {
      return DateTimeExtension().toHumanize(element.datePayment).contains(date);
    }).toList();
  }

  Future<int> update(PaymentModel payment, int id) async {
    final db = await instance.database;
    return await db.update(
      table,
      payment.toMapPaid(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateDateFail() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> payments = await db.query('payments');

    for (var payment in payments) {
      final updatedAt =
          DateTime.fromMillisecondsSinceEpoch(payment['date_payment']);
      final newDate = updatedAt.add(Duration(days: 1)).millisecondsSinceEpoch;

      await db.update(
        table,
        {'date_payment': newDate},
        where: 'id = ?',
        whereArgs: [payment['id']],
      );
    }
  }
}
