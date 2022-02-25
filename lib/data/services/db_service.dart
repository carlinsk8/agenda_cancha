import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '/domain/entities/agenda.dart';

class DBService {
  static Database? _database;
  static final DBService db = DBService._();

  DBService._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database?> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'AgendaCanchas.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Agenda(
            id INTEGER PRIMARY KEY,
            name TEXT,
            imgUrl TEXT,
            user TEXT,
            date TEXT,
            grado TEXT,
            icon TEXT
          )
        ''');
    });
  }

  Future<int> newAgenda(Agenda newAgenda) async {
    final db = await database;
    final res = await db!.insert('Agenda', newAgenda.toMap());
    return res;
  }

  Future<List<Agenda>> getAllAgenda() async {
    final db = await database;
    //final res = await db!.query('Agenda');
    final res = await db!.rawQuery("SELECT * FROM Agenda order by date ");
    return res.isNotEmpty ? res.map((e) => Agenda.fromMap(e)).toList() : [];
  }

  Future<List> getCanchaDay(String date, String name) async {
    final db = await database;
    //final res = await db!.query('Agenda');
    final res = await db!.rawQuery(
        "SELECT count(*)  FROM Agenda WHERE name = ? AND date = ?",
        [name, date]);
    return res;
  }

  Future<int> deleteAgenda(int? id) async {
    if (id != null) {
      final db = await database;
      final res = await db!.delete('Agenda', where: 'id = ?', whereArgs: [id]);

      return res;
    }
    return 0;
  }
}
