import 'dart:async';

import '../../domain/models/transaction.dart';

class ZephyrApiService {
  Future<List<Transaction>> fetchTransactions() async {
    await Future.delayed(
      const Duration(seconds: 2),
    ); // Simulating network delay
    return List.generate(50, (index) {
      return Transaction(
        id: '$index',
        description: 'Transaction $index',
        amount: (index + 1) * 10.0,
        date:
            DateTime.now()
                .subtract(Duration(days: index))
                .millisecondsSinceEpoch,
      );
    });
  }
}
