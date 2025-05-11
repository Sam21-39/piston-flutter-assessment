import 'package:flutter/material.dart';

import 'features/transactions/presentation/screens/transactions_page.dart';

class ZephyrPayApp extends StatelessWidget {
  const ZephyrPayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZephyrPay',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TransactionsPage(),
    );
  }
}
