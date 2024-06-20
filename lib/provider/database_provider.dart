import 'package:mobis/provider/financial_institution_provider.dart';
import 'package:mobis/provider/transaction_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static Future<Database> initialDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'mobis_db.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await TransactionProvider.createDatabaseTable(db: db);
      await FinancialInstitutionProvider.createDatabaseTable(db: db);
    });
    return database;
  }
}
