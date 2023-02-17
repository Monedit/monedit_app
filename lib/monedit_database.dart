import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'budget.dart';
import 'entry.dart';
import 'filter.dart';

class MoneditDatabase{ //TODO : Singleton correctly

  static const String _nameDb = "monedit.db";
  static late final Database? _database;

  //TODO : make a cache here


  static Future<MoneditDatabase> get() async{ //Database Factory
    WidgetsFlutterBinding.ensureInitialized();
    MoneditDatabase db = MoneditDatabase();

    //open the DB if it is not open already
    _database ??= await openDatabase(
        join(await getDatabasesPath(), _nameDb),
        onCreate: (db, version) {
          // Run the CREATE TABLE statement on the database.
          //TODO : check if not null is needed
          return db.execute(
            'CREATE TABLE entries(id INTEGER PRIMARY KEY, name TEXT, date TEXT, value REAL, category TEXT );'
             'CREATE TABLE budgets(name TEXT PRIMARY KEY, balance REAL, lastUse TEXT)'
            ,
            //TODO : will need to add more things into the DB
            //-> budgets (+ last use date? To order by LRU) and their lists
            //-> categories (names)
          );
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 1,
      );

    return db;
  }

  //TODO : maybe do 'AddAllEntries' and 'AddEntry' to not make for loops for nothing?
  Future<void> addEntries(List<Entry> entries) async{

    for (var e in entries) {  //TODO : should this be a transaction?
      _database!.insert('entries', e.toMap(),  //TODO : should this have an await?
        conflictAlgorithm: ConflictAlgorithm.ignore,);
    }

  }

  Future<void> removeEntries(List<int> entriesIds) async{
    for (var id in entriesIds) {  //TODO : should this be a transaction?
      _database!.delete('entries', //TODO : should this have an await?
        where: 'id = ?',
        whereArgs: [id], );
    }

  }

  Future<List<Entry>> fetchEntries(Filter f) async{ //TODO : how to use filters for fetching?
    var fRes = f.makeQuery();
    var entries = (await _database!.query('entries',
      where : fRes.item1,
      whereArgs : fRes.item2
    )).map((entryMap) =>
        Entry(entryMap['id'] as int, DateTime.parse(entryMap['date'] as String), entryMap['name'] as String, entryMap['value'] as double, entryMap['category'] as String) ).toList();

    return entries;
    
  }

  void addBudget(List<Budget> budgets) async{
    for (var b in budgets) {  //TODO : should this be a transaction?
      _database!.insert('budgets', b.toDbMap(),  //TODO : should this have an await?
        conflictAlgorithm: ConflictAlgorithm.ignore,);
      //TODO : create table with budget name for IDs of entries
          //-> 'id'
      _database!.execute(//TODO : check if this is correct
          'CREATE TABLE budget_${b.name}(name TEXT PRIMARY KEY)',);
      addBudgetEntries(b.name, b.entriesIds);
    }
  }

  void removeBudget(List<String> names) async{
    for (var name in names) {  //TODO : should this be a transaction?
      _database!.delete('budgets',
      where : 'name = ?',
      whereArgs : [name]);
      //TODO : delete table of entries for each budget
      _database!.execute('DROP TABLE budget_$name');
    }

  }

  void addBudgetEntries(String name, List<int> newIds){
    for(var id in newIds){
      _database!.insert('budget_$name', {'id' : id},  //TODO : should this have an await?
        conflictAlgorithm: ConflictAlgorithm.ignore,);
    }

  }

  void removeBudgetEntries(String name, List<int> ids){
    for( var id in ids ){
      _database!.delete('budget_$name',
          where : 'id = ?',
          whereArgs: [id]);
    }
  }

  Future<List<Budget>> fetchBudgetsByNames(List<String> names) async{
    //TODO :
    String namesForQuery = '(${names.reduce((queryAccumulator, newName) =>
    '$queryAccumulator , $newName')})'; //TODO : make list of names for query correctly
    var budgetMaps = await _database!.query('budgets',
      distinct : true,
      where : 'name IN ?',
      whereArgs: [namesForQuery],
      orderBy: 'lastUse'
    );

    var budgetIds = names.map(
            (name) async =>  (await _database!.query('budget_$name'))
                .map((idMap) => idMap['id'] as int).toList()
    ).toList();

    var budgets = [
      for (int index = 0 ; index < names.length ; ++index)
        Budget(budgetMaps[index]['name'] as String, budgetMaps[index]['balance'] as double,
            await budgetIds[index], DateTime.parse(budgetMaps[index]['lastUse'] as String))
    ];

    return budgets;

  }

  Future<List<Budget>> fetchBudgetsBySize(int size) async{
    //TODO : change to order by LRU + probably better if done in a specific query
    var names = (await fetchBudgetNames()).sublist(0,size-1);
    return (await fetchBudgetsByNames(names));
  }

  Future<List<String>> fetchBudgetNames() async{
    //TODO : change to order by LRU
    var budgetNames = (await _database!.query('budgets', orderBy: 'lastUse' ))
        .map((budgetMap) => budgetMap['name'] as String).toList();
    return budgetNames;
  }

}