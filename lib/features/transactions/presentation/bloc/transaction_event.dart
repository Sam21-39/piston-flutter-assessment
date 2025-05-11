abstract class TransactionEvent {}

class GetTransactionEvent extends TransactionEvent {}

class GetOfflineTransactionEvent extends TransactionEvent {
  final int start;

  GetOfflineTransactionEvent(this.start);
}
