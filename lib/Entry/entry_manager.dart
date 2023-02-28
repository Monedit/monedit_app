import 'package:shared_preferences/shared_preferences.dart';

import '../Entry/entry.dart';
import '../filter.dart';
import '../monedit_database.dart';

class EntryManager{//TODO : should be a singleton

  final _db = MoneditDatabase.get();
  static late int _lastId; //This needs to be stored somewhere in a file : how to?
  static final _prefs = SharedPreferences.getInstance();
  //TODO : write-through cache for entries

  static Future<EntryManager> get() async {
    EntryManager em = EntryManager();

  // Try reading data from the lasId key. If it doesn't exist, return 0.
    _lastId = (await _prefs).getInt('lastId') ?? 0;

    return em;
  }

  Future<void> add(Entry e) async {
    await (await _db).addEntries([e]);
  }

  Future<void> remove(int e) async { //TODO : check if argument should be ID or whole entry
    await (await _db).removeEntries([e]);
  }

  //TODO : change return type AND do it cleaner with queries
  Future<List<Entry>> find({Filter f = const Filter(), int size = 0}) async {
    if(size == 0){
      return (_db).then((db) => db.fetchEntries(f));
    }
    return _db.then((db) => db.fetchEntriesBySize(f,size));
  }

  Future<int> newId() async {
    _lastId = _lastId +1;
    (await _prefs).setInt('lastId',_lastId);
    return _lastId;
  }

}