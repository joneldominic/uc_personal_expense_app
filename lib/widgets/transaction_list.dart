import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personal_expense_app/models/transaction.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _transactions.map((tx) {
        return Card(
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.purple,
                    width: 2,
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                padding: EdgeInsets.all(10),
                child: Text(
                  '₱ ${tx.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tx.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('MMMM dd, y').format(tx.date), // Intl Package
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
