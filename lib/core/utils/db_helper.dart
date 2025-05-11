import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zpay/core/utils/constants.dart';

class DatabaseHelper {
  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  Future<Database> get database async {
    final Database _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), AppConstants.databaseName);
    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      readOnly: false,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE ${AppConstants.table} (
            ${AppConstants.columnId} TEXT PRIMARY KEY,
            ${AppConstants.columnAmount} REAL NOT NULL,
            ${AppConstants.columnTime} INTEGER NOT NULL,
            ${AppConstants.columnDesc} TEXT NOT NULL
          )
          ''');
      },
    );
  }
}
