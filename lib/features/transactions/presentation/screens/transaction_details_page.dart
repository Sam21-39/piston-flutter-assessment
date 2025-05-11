import 'package:flutter/material.dart';

import '../../domain/models/transaction.dart';

class TransactionDetailPage extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${transaction.id}', style: const TextStyle(fontSize: 18)),
            Text('Description: ${transaction.description}'),
            Text('Amount: ₹${transaction.amount.toStringAsFixed(2)}'),
            Text('Date: ${DateTime(transaction.date).toLocal()}'),
          ],
        ),
      ),
    );
  }
}
