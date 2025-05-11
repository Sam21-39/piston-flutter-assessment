import 'package:sqflite/sqflite.dart';
import 'package:zpay/core/utils/logger.dart';
import 'package:zpay/features/transactions/domain/models/transaction.dart' as t;

import '../utils/constants.dart';
import '../utils/db_helper.dart';

class DbService {
  // Create storage
  Future<void> storeCache(List<t.Transaction> txList) async {
    final db = await DatabaseHelper.instance.database;
    final batch = db.batch();
    for (var i = 0; i < txList.length; i++) {
      final txMap = txList[i].toJson();
      batch.insert(
        AppConstants.table,
        txMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    final rows = await batch.commit();

    logMessage('no of rows saved: ${rows.length}');
  }

  Future<List<t.Transaction>> readCache({int start = 0, int limit = 15}) async {
    final db = await DatabaseHelper.instance.database;
    final data = await db.query(AppConstants.table, limit: limit + start);

    return List.generate(data.length, (index) {
      final txMap = data[index];

      return t.Transaction.fromJson(txMap);
    });
  }

  Future<void> clearCache() async {
    final db = await DatabaseHelper.instance.database;
    db.delete(AppConstants.table);
  }
}
