import 'package:flutter/material.dart';
import 'package:gringotts/components/centered_message.dart';
import 'package:gringotts/components/progress.dart';
import 'package:gringotts/http/clients/TransactionWebClient.dart';
import 'package:gringotts/models/transaction.dart';

class TransactionsList extends StatelessWidget {

  final TransactionWebClient _transactionWebClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
          future: _transactionWebClient.findAll(),
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
                if(snapshot.hasError) {
                  debugPrint('ERROR: ${snapshot.error}');
                }
                if (snapshot.hasData) {
                  final List<Transaction> transactions = snapshot.data;
                  if (transactions.isNotEmpty) {
                    final List<Transaction> transactions = snapshot.data;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Transaction transaction = transactions[index];
                        return _TransactionItem(transaction);
                      },
                      itemCount: transactions.length,
                    );
                  }
                }

                return CenteredMessage(
                  'No transactions found',
                  icon: Icons.clear,
                );
                break;
            }
            return CenteredMessage(
              'Unknoun Error',
              icon: Icons.error,
            );
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
