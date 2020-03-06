import 'package:flutter/material.dart';

import '../models/transaction.dart';

import './new_transaction.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {

  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Breakfast',
      amount: 60.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Load',
      amount: 50.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Dinner',
      amount: 75.00,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String title, String amount) {

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(),
        TransactionList(_transactions),
      ],
    );
  }
}
