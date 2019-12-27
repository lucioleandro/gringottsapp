import 'dart:convert';

import 'package:gringotts/models/transaction.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransactionWebClient {

  Future<List<Transaction>> findAll() async {
    var future = await client.get(API_URL + '/transactions').timeout(
      Duration(seconds: 5),
    );
    List<Transaction> transactions = _toTransactions(future);

    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    Map<String, Object> transactionMap = _toMap(transaction);
    var future = await client.post(API_URL + '/transactions',
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: jsonEncode(transactionMap));

    return _toTransaction(jsonDecode(future.body));
  }

  Map<String, Object> _toMap(Transaction transaction) {
     var transactionMap = {
      'value' : transaction.value,
      'contact' : {
        'name' : transaction.contact.name,
        'accountNumber' : transaction.contact.accountNumber
      }
    };
    return transactionMap;
  }

  List<Transaction> _toTransactions(Response future) {
    var decodedJson = jsonDecode(future.body);
    final List<Transaction> transactions = List();

    for (Map<String, dynamic> element in decodedJson) {
      Transaction transaction = _toTransaction(element);
      transactions.add(transaction);
    }
    return transactions;
  }

  Transaction _toTransaction(Map<String, dynamic> element) {
    var transaction = Transaction.fromJson(element);
    return transaction;
  }
}