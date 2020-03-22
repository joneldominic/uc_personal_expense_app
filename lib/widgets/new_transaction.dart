import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    print('Title: $enteredTitle');
    print('Amount: $enteredAmount');

    widget.addNewTransaction(
      enteredTitle,
      enteredAmount, // Error needs to be handled
    );

    Navigator.of(context).pop(); // Clears topmost view...
  }

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
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70.0,
              child: Row(
                children: <Widget>[
                  Text(
                    'No Date Chosen',
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {},
                    child: Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: submitData,
              child: Text('Add Transcation'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            )
          ],
        ),
      ),
    );
  }
}
