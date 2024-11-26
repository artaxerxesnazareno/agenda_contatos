import 'dart:core';

import 'package:agenda_contatos/data/datasources/local/constants/database_constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactHelper {
  static final ContactHelper _instace = ContactHelper.internal();

  factory ContactHelper() => _instace;

  ContactHelper.internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contacts.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newVersion) async {
      await db.execute(
          "CREATE TABLE ${DatabaseConstants.contactTable} (${DatabaseConstants.idColumn} INTEGER PRIMARY KEY, ${DatabaseConstants.nameColumn} TEXT, ${DatabaseConstants.emailColumn} TEXT, ${DatabaseConstants.phoneColumn} TEXT, ${DatabaseConstants.imgColumn} TEXT)");
    });
  }
}
