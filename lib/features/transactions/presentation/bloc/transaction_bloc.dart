import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpay/core/services/db_service.dart';
import 'package:zpay/core/utils/logger.dart';
import 'package:zpay/features/transactions/domain/models/transaction.dart';
import 'package:zpay/features/transactions/domain/repository/transactions_repository.dart';

import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(InitalTransactionState()) {
    on<GetTransactionEvent>(_fetchTransactions);
    on<GetOfflineTransactionEvent>(_fetchOfflineTransactions);
  }
}

void _fetchOfflineTransactions(
  GetOfflineTransactionEvent event,
  Emitter<TransactionState> emit,
) async {
  emit(LoadingTransactionState());
  try {
    final DbService dbService = DbService();

    final List<Transaction> txListData = await dbService.readCache(
      start: event.start,
    );
    emit(FetchedTransactionState(txListData));
  } catch (e) {
    logMessage(e.toString());
    emit(ErrorTransactionState(e.toString()));
  }
}

void _fetchTransactions(
  GetTransactionEvent event,
  Emitter<TransactionState> emit,
) async {
  final txRepo = TransactionsRepository();
  emit(LoadingTransactionState());
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.none)) {
    emit(ErrorTransactionState('No Internet Connection'));
    return;
  }
  try {
    final List<Transaction> txList = await compute(
      (message) => txRepo.getTransactions(),
      'txlist',
    );
    txList.sort((a, b) => a.date.compareTo(b.date));
    final DbService dbService = DbService();
    if (txList.isEmpty) {
      emit(FetchedTransactionState(<Transaction>[]));
    } else {
      await dbService.storeCache(txList);
      final List<Transaction> txListData = await dbService.readCache();
      emit(FetchedTransactionState(txListData));
    }
  } catch (e) {
    logMessage(e.toString());
    emit(ErrorTransactionState('Data could not be loaded'));
  }
}
