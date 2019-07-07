import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/transaction_item.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _txns;

  final Function deleteTxn;

  TransactionList(this._txns, this.deleteTxn);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: _txns.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      'No transactions added',
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, i) {
                return new TransactionItem(txn: _txns[i], deleteTxn: deleteTxn);
              },
              itemCount: _txns.length,
            ),
    );
  }
}
