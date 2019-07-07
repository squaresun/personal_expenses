import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _txns;

  Chart(this._txns);

  List<Map<String, Object>> get groupedTxnValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0;
      for (int i = 0; i < _txns.length; i++) {
        if (_txns[i].date.day == weekday.day &&
            _txns[i].date.month == weekday.month &&
            _txns[i].date.year == weekday.year) {
          totalSum += _txns[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get maxSpent {
    return groupedTxnValues.fold(0.0, (total, txn) {
      return total + txn['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTxnValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                maxSpent == 0.0
                    ? maxSpent
                    : (data['amount'] as double) / maxSpent,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
