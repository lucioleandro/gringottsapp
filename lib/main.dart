import 'package:flutter/material.dart';
import 'package:gringotts/components/transaction_auth_dialog.dart';
import 'package:gringotts/screens/dashboard.dart';

void main() => runApp(GringottsApp());


class GringottsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          ),
      ),
      home: TransactionAuthDialog(),
    );
  }
}