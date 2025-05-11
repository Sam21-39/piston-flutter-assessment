import 'package:zpay/features/transactions/domain/models/transaction.dart';

abstract class TransactionState {}

class InitalTransactionState extends TransactionState {}

class LoadingTransactionState extends TransactionState {}

class FetchedTransactionState extends TransactionState {
  final List<Transaction> txList;
  FetchedTransactionState(this.txList);
}

class ErrorTransactionState extends TransactionState {
  final String error;
  ErrorTransactionState(this.error);
}
