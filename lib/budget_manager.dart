import 'package:monedit_flutter/monedit_database.dart';
import 'package:tuple/tuple.dart';

import 'budget.dart';
import 'Entry/entry.dart';
import 'filter.dart';

class BudgetManager{ //TODO : should be a singleton

  final _db = MoneditDatabase.get();
  //TODO : write-through cache for budgets

  static Future<BudgetManager> get() async{
    var bm = BudgetManager();
    return bm;
  }

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

  Future<List<String>> findNamesLRU(int size) async{ //TODO : find with only one method with optional parameters
    return (await findAllNames()).sublist(0,size-1);
  }

  Future<bool> isValidName(BudgetBuilder bb) async{
    //check name does not exist
    return !(await (await _db).fetchBudgetNames()).contains(bb.name);
  }

  Future<List<Budget>> findTimelyBudgets() async{

    List<BudgetBuilder> bbs = [BudgetBuilder().setName("Day"), BudgetBuilder().setName("Week"), BudgetBuilder().setName("Month")];
    List<Budget> budgets = bbs.map((e) => e.build()).toList();

    DateTime now = DateTime.now();
    //TODO : testing to see if it is functional
    DateTime daily = DateTime( now.year, now.month, now.day );
    Duration oneDay = const Duration( days: 1);
    Duration oneWeek = const Duration( days: 7);
    Duration oneMonth = const Duration( days : 30);

    List<Filter> filters = [
      Filter(dateFilter: Tuple2( daily , daily.add(oneDay) ) ) ,
      Filter(dateFilter: Tuple2( daily.subtract(oneWeek) , daily.add(oneDay) ) ) ,
      Filter(dateFilter: Tuple2( daily.subtract(oneMonth) , daily.add(oneDay) ) ) ];

    var i = 0;
    for (var b in budgets) {
        List<Entry> entries = await (await _db).fetchEntries(filters[i]);
        for(var entry in entries){
          b.add(entry);
          b.balance += entry.value;
        }
        ++i;
    }

    return budgets;
  }

}