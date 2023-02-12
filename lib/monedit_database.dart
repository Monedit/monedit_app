import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'entry.dart';
import 'filter.dart';


class MoneditDatabase{

  static const String _nameDb = "monedit.db";
  static late final Database _database;


  static Future<MoneditDatabase> get() async{ //Database Factory
    WidgetsFlutterBinding.ensureInitialized();
    MoneditDatabase db = MoneditDatabase();

    //open the DB if it is not open already
    //if ( !_database.isOpen){ //TODO : check this?
      _database = await openDatabase(
        join(await getDatabasesPath(), _nameDb),
        onCreate: (db, version) {
          // Run the CREATE TABLE statement on the database.
          return db.execute(
            'CREATE TABLE entries(id INTEGER PRIMARY KEY, name TEXT, date TEXT, value REAL, category TEXT )',
            //TODO : will need to add more things into the DB
          );
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 1,
      );
   // }

    return db;
  }

  //TODO : maybe do 'AddAllEntries' and 'AddEntry' to not make for loops for nothing?
  Future<void> addEntries(List<Entry> entries) async{
    Database db = _database;
    for (var e in entries) {  //TODO : should this be a transaction?
      db.insert('entries', e.toMap(),  //TODO : should this have an await?
        conflictAlgorithm: ConflictAlgorithm.ignore,);
    }

  }

  Future<void> removeEntries(List<int> entriesIds) async{
    Database db = _database;
    for (var id in entriesIds) {  //TODO : should this be a transaction?
      db.delete('entries', //TODO : should this have an await?
        where: 'id = ?',
        whereArgs: [id], );
    }

  }

  Future<List<Entry>> fetchEntries(Filter f) async{ //TODO : how to use filters for fetching?
    var fRes = f.makeQuery();
    Database db = _database;
    final List<Map<String, dynamic>> maps = await db.query('entries',
      where : fRes.item1,
      whereArgs : fRes.item2
    );

    return List.generate(maps.length, (idx) {
      return Entry(maps[idx]['id'], DateTime.parse(maps[idx]['date']), maps[idx]['name'], maps[idx]['value'], maps[idx]['category']);
    });
    
  }

}