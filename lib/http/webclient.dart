import 'dart:convert';

import 'package:gringotts/http/log/LoggingInterceptor.dart';
import 'package:gringotts/models/contact.dart';
import 'package:gringotts/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const API_URL = 'http://172.29.40.69:8080';

var client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);

Future<List<Transaction>> findAll() async {
  var future = await client.get('${API_URL}/transactions').timeout(
        Duration(seconds: 5),
      );
  List<Transaction> transactions = _decodeTransactions(future);

  return transactions;
}

Future<Transaction> save(Transaction transaction) async {
  var transactionMap = {
    'value' : transaction.value,
    'contact' : {
      'name' : transaction.contact.name,
      'accountNumber' : transaction.contact.accountNumber
    }
  };
  var future = await client.post('${API_URL}/transactions',
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: jsonEncode(transactionMap));

  return _decodeTransaction(jsonDecode(future.body));
}

List<Transaction> _decodeTransactions(Response future) {
  var decodedJson = jsonDecode(future.body);
  final List<Transaction> transactions = List();

  for (Map<String, dynamic> element in decodedJson) {
    Transaction transaction = _decodeTransaction(element);
    transactions.add(transaction);
  }
  return transactions;
}

Transaction _decodeTransaction(Map<String, dynamic> element) {
   var transaction = Transaction(
      element['value'],
      Contact(
        0,
        element['contact']['name'],
        element['contact']['accountNumber'],
      ));
  return transaction;
}
