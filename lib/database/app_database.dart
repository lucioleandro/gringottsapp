import 'package:gringotts/database/dao/contact_dao.dart';
import 'package:gringotts/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDataBase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDAO.tableSql);
    },
    version: 1,
//      onDowngrade: onDatabaseDowngradeDelete,
  );
}