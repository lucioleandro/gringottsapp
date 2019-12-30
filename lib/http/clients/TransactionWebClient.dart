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
    Map<String, Object> transactionMap = transaction.toJson();
    var future = await client.post(API_URL + '/transactions',
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: jsonEncode(transactionMap));

    return Transaction.fromJson(jsonDecode(future.body));
  }

  List<Transaction> _toTransactions(Response future) {
    var decodedJson = jsonDecode(future.body);

    final List<Transaction> transactions = decodedJson.map((dynamic json) =>
       Transaction.fromJson(json)
    ).toList();

    return transactions;
  }
}
