import 'dart:core';

import 'package:agenda_contatos/data/datasources/local/constants/database_constants.dart';
import 'package:agenda_contatos/domain/entities/contact.dart';
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

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.id =
        await dbContact.insert(DatabaseConstants.contactTable, contact.toMap());
    return contact;
  }

  Future<Contact?> getContactById(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(DatabaseConstants.contactTable,
        columns: [
          DatabaseConstants.idColumn,
          DatabaseConstants.nameColumn,
          DatabaseConstants.phoneColumn,
          DatabaseConstants.emailColumn
        ],
        where: '${DatabaseConstants.idColumn} =?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    }
    return null;
  }

  Future<int> deleteContactById(int id) async {
    Database dbContact = await db;
    return await dbContact.delete(DatabaseConstants.contactTable,
        where: '${DatabaseConstants.idColumn}=?', whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update(
        DatabaseConstants.contactTable, contact.toMap(),
        where: '${DatabaseConstants.idColumn} = ?', whereArgs: [contact.id]);
  }

  Future<List<Contact>?> getAllContacts() async {
    Database dbContact = await db;
    final list = await dbContact
        .rawQuery('SELECT * FROM ${DatabaseConstants.contactTable}');
    List<Contact> contacs = [];
    if (list.isNotEmpty) {
      for (var element in list) {
        contacs.add(Contact.fromMap(element));
      }
    }

    return contacs;
  }

  Future<int> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery(
            'SELECT COUNT(*) FROM ${DatabaseConstants.contactTable}')) ??
        0;
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}
