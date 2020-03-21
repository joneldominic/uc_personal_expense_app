import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

//NOTE: There official third-party chart packages that can be used for complex charts
class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double recentWeeklySum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          recentWeeklySum += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(recentWeeklySum);

      return {'day': DateFormat.E().format(weekDay).substring(0,1), 'amount': recentWeeklySum};
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map((data) {
          return Text('${data['day']} : ${data['amount']}');
        }).toList(),
      ),
    );
  }
}
