import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gringotts/components/progress.dart';
import 'package:gringotts/components/response_dialog.dart';
import 'package:gringotts/components/transaction_auth_dialog.dart';
import 'package:gringotts/http/clients/TransactionWebClient.dart';
import 'package:gringotts/models/contact.dart';
import 'package:gringotts/models/transaction.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;
  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _transactionWebClient = TransactionWebClient();
  final String transactionId = Uuid().v4();

  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(message: 'Sending...'),
                ),
                visible: _isSending,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                      child: Text('Transfer'),
                      onPressed: () {
                        final double value =
                            double.tryParse(_valueController.text);
                        final transactionCreated =
                            Transaction(transactionId,value, widget.contact);
                        showDialog(
                          context: context,
                          builder: (contextDialog) => TransactionAuthDialog(
                            onConfirm: (String password) {
                              _save(transactionCreated, password, context);
                            },
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(Transaction transactionCreated, String password,
      BuildContext context) async {
    Transaction transaction = await _send(
      transactionCreated,
      password,
      context,
    );
    _showSuccessMessage(transaction, context);
  }

  Future _showSuccessMessage(
      Transaction transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Successful transaction');
          });

      Navigator.pop(context);
    }
  }

  Future<Transaction> _send(Transaction transactionCreated, String password,
      BuildContext context) async {

    setState(() {
      _isSending = true;
    });

    var transaction = await _transactionWebClient
        .save(transactionCreated, password)
        .catchError((e) {
      _showFailureMessage(context,
          message: 'Timeout submitting the transaction');
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureMessage(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _showFailureMessage(context);
    }).whenComplete(() {
      setState(() {
        _isSending = false;
      });
    });
    return transaction;
  }

  void _showFailureMessage(BuildContext context,
      {String message = 'Unknow error'}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
