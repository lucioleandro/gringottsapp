class Contact {
  final String _name;
  final int _accountNumber;

  Contact(this._name, this._accountNumber);

  @override
  String toString() {
    return 'Contact{_name: $_name, _accountNumber: $_accountNumber}';
  }

}