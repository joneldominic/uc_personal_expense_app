import 'package:flutter/material.dart';
import 'package:personal_expense_app/widgets/transaction_list.dart';

import 'models/transaction.dart';
import 'widgets/new_transaction.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PersonalExpenseApp(),
    );
  }
}

class PersonalExpenseApp extends StatefulWidget {
  @override
  _PersonalExpenseAppState createState() => _PersonalExpenseAppState();
}

class _PersonalExpenseAppState extends State<PersonalExpenseApp> {
  final List<Transaction> _userTransactions = [
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

  void _addNewTransaction(String title, double amount) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bContext) {
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense Recorder'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.start, // Default
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                elevation: 5,
                child: Text('CHART'),
              ),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
