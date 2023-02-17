import 'package:monedit_flutter/monedit_database.dart';

import 'budget.dart';
import 'entry.dart';

class BudgetManager{ //TODO : should be a singleton

  final _db = MoneditDatabase.get();
  //TODO : write-through cache for budgets

  void add(Budget b) async{
    //add budget to DB + update last used date
    (await _db).addBudget([b]);
    //TODO : put in cache
  }

  void addEntryToBudget(String budgetName, Entry entry ) async {
    //TODO : update database and cache
    (await _db).addBudgetEntries(budgetName,[entry.id]);
  }

  void remove(String name) async{
    //remove budget from DB
    (await _db).removeBudget([name]);
  }

  void removeEntryFromBudget( String budgetName, int entryId )async{
    //TODO : update database and cache
    (await _db).removeBudgetEntries(budgetName, [entryId]);
  }

  Future<List<Budget>> findLRU(int size) async{
    //list the 'size' in order of LRU budgets
    //TODO : put in cache the ones found
    return (await _db).fetchBudgetsBySize(size);
  }

  Future<List<Budget>> findByNames(List<String> names) async{
    //list the 'size' in order of LRU budgets
    //TODO : put in cache the ones found
    return (await _db).fetchBudgetsByNames(names);
  }

  Future<List<String>> findAllNames() async{
    return (await _db).fetchBudgetNames();
  }

  Future<List<String>> findNamesLRU(int size) async{
    return (await findAllNames()).sublist(0,size-1);
  }

  Future<bool> isValidName(BudgetBuilder bb) async{
    //check name does not exist
    return !(await (await _db).fetchBudgetNames()).contains(bb.name);
  }

}