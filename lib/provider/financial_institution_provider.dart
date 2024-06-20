import 'dart:async';

import 'package:mobis/provider/transaction_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/financial_institution.dart';

const _tableName = 'financial_institution';
const _columnId = 'id';
const _columnName = 'name';
const _columnSlogan = 'slogan';
const _columnPhoneNumber = 'phoneNumber';

class FinancialInstitutionProvider {
  final Database db;
  final TransactionProvider transactionProvider;

  FinancialInstitutionProvider(
      {required this.transactionProvider, required this.db});

  static Future createDatabaseTable({required Database db}) async {
    await db.execute('''
create table $_tableName ( 
  $_columnId integer primary key autoincrement, 
  $_columnName text not null,
  $_columnSlogan text not null,
  $_columnPhoneNumber text not null)
''');
  }

  Future<FinancialInstitution?> insert(
      FinancialInstitution financialInstitution) async {
    final id = await db.insert(_tableName, financialInstitution.toJson()) ?? 0;
    return await getFinancialInstitution(id);
  }

  Future insertFinancialInstitutions(
    List<FinancialInstitution> financialInstitutions,
  ) async {
    await Future.wait(financialInstitutions.map((institution) async {
      final rawInstitution = institution.toJson();
      rawInstitution.remove('transactions');
      await db.insert(_tableName, rawInstitution);
      await transactionProvider.insertTransactions(institution.transactions);
    }));
  }

  Future<FinancialInstitution?> getFinancialInstitution(int id) async {
    List<Map> maps = await db.query(_tableName,
        columns: [_columnId, _columnName, _columnSlogan, _columnPhoneNumber],
        where: '$_columnId = ?',
        whereArgs: [id]);
    List<Map> financialInstitution = await Future.wait(maps.map((item) async {
      item['transactions'] = (await transactionProvider
              .getTransactionForFinancialInstitutions(item['id'] ?? 0))
          .map((item) => item.toJson());
      return item;
    }));

    if (financialInstitution.isNotEmpty) {
      return FinancialInstitution.fromJson(
          financialInstitution.first as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<FinancialInstitution>> getFinancialInstitutions(
    String userPhoneNumber,
  ) async {
    List<Map> maps = await db.query(_tableName,
        columns: [_columnId, _columnName, _columnSlogan, _columnPhoneNumber],
        where: '$_columnPhoneNumber = ?',
        whereArgs: [userPhoneNumber]);

    List<Map> financialInstitution = await Future.wait(maps.map((item) async {
      item['transactions'] = (await transactionProvider
              .getTransactionForFinancialInstitutions(item['id'] ?? 0))
          .map((item) => item.toJson());
      return item;
    }));

    return financialInstitution
        .map((item) =>
            FinancialInstitution.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<int> delete(int id) async {
    return await db
            .delete(_tableName, where: '$_columnId = ?', whereArgs: [id]) ??
        0;
  }

  Future<int> update(FinancialInstitution financialInstitution) async {
    return await db.update(_tableName, financialInstitution.toJson(),
            where: '$_columnId = ?', whereArgs: [financialInstitution.id]) ??
        0;
  }
}
