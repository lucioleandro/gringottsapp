import 'package:flutter/material.dart';
import 'package:gringotts/screens/contacts_list.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _FeatureItem(
                  'Transfer',
                  Icons.monetization_on,
                  onCLick: () {
                    _showContactList(context);
                  },
                ),
                _FeatureItem(
                  'Transaction Feed',
                  Icons.monetization_on,
                  onCLick: () {
                    _showContactList(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String _legend;
  final IconData _icon;
  final Function onCLick;

  _FeatureItem(this._legend, this._icon, {@required this.onCLick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            onCLick();
          },
          child: Container(
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  this._icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  this._legend,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_showContactList(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ContactsList(),
    ),
  );
}
