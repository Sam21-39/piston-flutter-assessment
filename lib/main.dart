import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpay/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:zpay/features/transactions/presentation/cubit/tx_list_cubit.dart';

import 'app.dart';
import 'features/transactions/presentation/bloc/transaction_event.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TxListCubit>(create: (context) => TxListCubit()),
        BlocProvider<TransactionBloc>(
          create:
              (BuildContext context) =>
                  TransactionBloc()..add(GetTransactionEvent()),
        ),
      ],
      child: const ZephyrPayApp(),
    ),
  );
}
