import 'package:flutter/material.dart';

import './transaction.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PersonalExpenseApp(),
    );
  }
}

class PersonalExpenseApp extends StatelessWidget {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 2000.00,
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense Recorder'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              elevation: 5.0,
              child: Text('CHART'),
            ),
          ),
          Column(
            children: _transactions.map((tx) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      padding: EdgeInsets.all(10),
                      child: Text('₱ ${tx.amount.toStringAsFixed(2)}'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(tx.title),
                        Text(tx.date.toString()),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
