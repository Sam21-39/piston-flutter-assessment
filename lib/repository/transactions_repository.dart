import '../models/transaction.dart';
import '../services/zephyr_api_service.dart';

class TransactionsRepository {
  final ZephyrApiService _apiService = ZephyrApiService();
  List<Transaction> _cachedTransactions = [];

  Future<List<Transaction>> getTransactions() async {
    if (_cachedTransactions.isEmpty) {
      _cachedTransactions = await _apiService.fetchTransactions();
    }
    return _cachedTransactions;
  }

  void clearCache() {
    _cachedTransactions = [];
  }
}
