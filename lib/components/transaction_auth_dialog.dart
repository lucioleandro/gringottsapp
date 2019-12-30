import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Authenticate',
        textAlign: TextAlign.center,
      ),
      content: TextField(
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        style: TextStyle(fontSize: 68, letterSpacing: 20),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => print('confirm'),
          child: Text('Confirm'),
        )
      ],
    );
  }
}
