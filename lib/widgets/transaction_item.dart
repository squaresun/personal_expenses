import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required Transaction txn,
    @required this.deleteTxn,
  })  : txn = txn,
        super(key: key);

  final Transaction txn;
  final Function deleteTxn;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('\$${txn.amount}'),
            ),
          ),
        ),
        title: Text(
          txn.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(txn.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                textColor: Theme.of(context).errorColor,
                label: Text('Delete'),
                icon: Icon(Icons.delete),
                onPressed: () => deleteTxn(txn.id),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteTxn(txn.id);
                },
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
