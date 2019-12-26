import 'package:flutter/material.dart';
import 'package:gringotts/components/centered_message.dart';
import 'package:gringotts/components/progress.dart';
import 'package:gringotts/http/webclient.dart';
import 'package:gringotts/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
          initialData: List(),
          future: findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Transaction> transactions = snapshot.data;
                if (transactions.isNotEmpty) {
                  ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return _TransactionItem(transaction);
                    },
                    itemCount: transactions.length,
                  );
                }
                return CenteredMessage(
                  'No transactions found',
                  icon: Icons.clear,
                );
                break;
            }
            return Text('Unknoun Error');
          }),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const _TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          transaction.value.toString(),
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          transaction.contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
