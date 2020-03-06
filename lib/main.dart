import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  // Property Input
  String titleInput;
  String amountInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense Recorder'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              elevation: 5,
              child: Text('CHART'),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    onChanged: (val) {
                      titleInput = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    onChanged: (val) => amountInput = val,
                  ),
                  FlatButton(
                    onPressed: () {
                      print('Title: $titleInput');
                      print('Amount: $amountInput');
                    },
                    child: Text('Add Transcation'),
                    textColor: Colors.purple,
                  )
                ],
              ),
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
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                          DateFormat('MMMM dd, y')
                              .format(tx.date), // Intl Package
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
          ),
        ],
      ),
    );
  }
}
