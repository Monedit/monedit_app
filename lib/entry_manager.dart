import 'entry.dart';
import 'filter.dart';
import 'monedit_database.dart';

class EntryManager{

  final _db = MoneditDatabase.get();
  int _lastId = 0; //This needs to be stored somewhere in a file : how to?

  EntryManager(){
    //lastId shenanigans
  }

  Future<void> add(Entry e) async {
    await (await _db).addEntries([e]);
  }

  Future<void> remove(int e) async { //TODO : check if argument should be ID or whole entry
    await (await _db).removeEntries([e]);
  }

  //TODO : change return type AND do it cleaner with queries
  Future<List<Entry>> find(Filter f) async {
    return (await _db).fetchEntries(f);
  }

  int newId(){
    return _lastId++;
  }

}