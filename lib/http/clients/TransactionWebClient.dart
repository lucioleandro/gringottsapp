import 'dart:convert';

import 'package:gringotts/models/transaction.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransactionWebClient {

  static final Map<int, String> _statusCodeResponses = {
    400 : 'There was a error submitting transaction',
    401 : 'Autentication failed'
  };

  Future<List<Transaction>> findAll() async {
    var future = await client.get(API_URL + '/transactions').timeout(
          Duration(seconds: 5),
        );
    return _toTransactions(future);
  }

  Future<Transaction> save(Transaction transaction, String password) async {
   final String transactionJson = jsonEncode(transaction.toJson());
    var future = await client.post(API_URL + '/transactions',
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: transactionJson);


   if(future.statusCode == 200) {
     return Transaction.fromJson(jsonDecode(future.body));
    }

   throw HttpException(_statusCodeResponses[future.statusCode]);

  }

  List<Transaction> _toTransactions(Response future) {
    final List<dynamic> decodedJson = jsonDecode(future.body);

    return decodedJson.map((dynamic json) =>
       Transaction.fromJson(json)
    ).toList();
  }
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
