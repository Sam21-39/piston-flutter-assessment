import 'package:flutter_bloc/flutter_bloc.dart';

class TxListCubit extends Cubit<int> {
  int _start = 0;

  TxListCubit() : super(0);

  void loadNextPage(int limit) {
    _start += limit;
    emit(_start);
  }

  void reset() {
    _start = 0;
    emit(_start);
  }

  int get currentOffset => _start;
}
