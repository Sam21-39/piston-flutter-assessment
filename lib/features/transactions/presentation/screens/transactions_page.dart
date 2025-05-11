import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zpay/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:zpay/features/transactions/presentation/bloc/transaction_event.dart';
import 'package:zpay/features/transactions/presentation/bloc/transaction_state.dart';
import 'package:zpay/features/transactions/presentation/cubit/tx_list_cubit.dart';
import 'package:zpay/features/transactions/presentation/screens/transaction_details_page.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final scrollCtrl = ScrollController(keepScrollOffset: true);

  @override
  void initState() {
    super.initState();
    scrollCtrl.addListener(_scrollListner);
  }

  @override
  void dispose() {
    scrollCtrl.removeListener(_scrollListner);
    scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollListner() {
    if (scrollCtrl.position.pixels >=
            scrollCtrl.position.maxScrollExtent - 100 &&
        scrollCtrl.position.axisDirection == AxisDirection.down) {
      context.read<TxListCubit>().loadNextPage(15);
      context.read<TransactionBloc>().add(
        GetOfflineTransactionEvent(context.read<TxListCubit>().currentOffset),
      );
    }
    //
    // scrollCtrl.jumpTo(scrollCtrl.position.maxScrollExtent);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollCtrl.hasClients) {
        scrollCtrl.animateTo(
          scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, txState) {
          if (txState is LoadingTransactionState) {
            return Center(child: CircularProgressIndicator());
          }
          if (txState is FetchedTransactionState) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<TransactionBloc>().add(
                  GetOfflineTransactionEvent(0),
                );
              },
              child: ListView.builder(
                controller: scrollCtrl,
                addSemanticIndexes: true,
                itemCount: txState.txList.length,
                itemBuilder: (context, index) {
                  final tx = txState.txList[index];
                  if (index >= txState.txList.length) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return ListTile(
                    title: Text(tx.description),
                    subtitle: Text('₹${tx.amount.toStringAsFixed(2)}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => TransactionDetailPage(transaction: tx),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
          if (txState is ErrorTransactionState) {
            return Center(child: Text(txState.error));
          }
          return Container();
        },
      ),
    );
  }
}
