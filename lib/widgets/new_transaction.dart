import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addNewTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addNewTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            FlatButton(
              onPressed: () {
                print('Title: ${titleController.text}');
                print('Amount: ${amountController.text}');
                addNewTransaction(
                  titleController.text,
                  double.parse(amountController.text), // Error needs to be handled
                );
              },
              child: Text('Add Transcation'),
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
