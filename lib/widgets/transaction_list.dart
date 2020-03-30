import 'package:flutter/material.dart';

import '../models/transaction.dart';

import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return this.transactions.isEmpty
        ? LayoutBuilder(builder: (bContext, contraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                const SizedBox(height: 10),
                Container(
                  height: contraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : /* ListView.builder( /* Theres a bug in ListView.builder in terms of using key */
            itemBuilder: (bCtx, index) {
              return TransactionItem(
                  key: ValueKey(transactions[index].id),
                  /* UniqueKey() = Not good since it will update every changes */
                  transaction: transactions[index],
                  deleteTransaction: deleteTransaction);
            },
            itemCount: transactions.length,
          ); */
        ListView(
            children: <Widget>[
              ...transactions.map((tItem) => TransactionItem(
                  key: ValueKey(tItem.id),
                  /* UniqueKey() = Not good since it will update every changes */
                  transaction: tItem,
                  deleteTransaction: deleteTransaction))
            ],
          );
  }
}
