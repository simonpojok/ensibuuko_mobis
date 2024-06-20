import 'package:sqflite/sqflite.dart' as database;

import '../models/transaction.dart';

const _tableName = 'transactions';
const _columnId = 'id';
const _columnInstitutionId = 'institutionId';
const _columnTimestamp = 'timestamp';
const _columnNarration = 'narration';
const _columnAmount = 'amount';
const _columnPhoneNumber = 'phoneNumber';

class TransactionProvider {
  final database.Database db;

  const TransactionProvider({required this.db});

  static Future createDatabaseTable({required database.Database db}) async {
    await db.execute('''
create table $_tableName ( 
  $_columnId integer primary key autoincrement, 
  $_columnTimestamp integer not null,
  $_columnAmount integer not null,
  $_columnInstitutionId integer not null,
  $_columnNarration text not null,
  $_columnPhoneNumber text not null
  )
''');
  }

  Future<Transaction?> insert(Transaction transaction) async {
    final id = await db.insert(_tableName, transaction.toJson()) ?? 0;
    return await getTransactions(id);
  }

  Future insertTransactions(List<Transaction> transactions) async {
    await Future.wait(transactions.map((transaction) async {
      await db.insert(_tableName, transaction.toJson()) ?? 0;
    }));
  }

  Future<Transaction?> getTransactions(int id) async {
    List<Map> maps = await db.query(_tableName, columns: [
      _columnId,
      _columnTimestamp,
      _columnAmount,
      _columnNarration,
      _columnInstitutionId
    ]);

    if (maps.isNotEmpty) {
      return Transaction.fromJson(maps.first as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<Transaction>> getTransactionForFinancialInstitutions(
      int id) async {
    List<Map> maps = await db.query(_tableName, columns: [
      _columnId,
      _columnTimestamp,
      _columnAmount,
      _columnNarration,
      _columnInstitutionId
    ]);
    return maps
        .map((item) => Transaction.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<int> delete(int id) async {
    return await db
            .delete(_tableName, where: '$_columnId = ?', whereArgs: [id]) ??
        0;
  }

  Future<int> update(Transaction transaction) async {
    return await db.update(_tableName, transaction.toJson(),
            where: '$_columnId = ?', whereArgs: [transaction.id]) ??
        0;
  }
}
