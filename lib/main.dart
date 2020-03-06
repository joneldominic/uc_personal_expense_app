import 'package:flutter/material.dart';
import 'package:personal_expense_app/widgets/user_transactions.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense Recorder'),
      ),
      body: Column(
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
          UserTransactions(),
        ],
      ),
    );
  }
}
