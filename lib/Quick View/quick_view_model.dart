import 'package:monedit_flutter/category_manager.dart';
import 'package:tuple/tuple.dart';

import '../budget.dart';
import '../Entry/entry.dart';
import '../Entry/entry_manager.dart';
import '../budget_manager.dart';

class QuickViewModel{

  final Future<EntryManager> _em = EntryManager.get();
  final Future<BudgetManager> _bm = BudgetManager.get();
  final CategoryManager _cm = CategoryManager();

  List<Entry> viewEntries = [];
  List<Budget> viewBudgets = [];

  var numberEntries = 10;
  var numberBudgets = 3;

  var currentBudgetIndex = 0;

  Future<void> getViewData() async{
    viewEntries = await _em.then((em) => em.find(size : numberEntries));
    viewBudgets = await _bm.then((bm) => bm.findLRU(numberBudgets));
  }

  //TODO : List<Event> NextEvents()

  Future<void> quickAddButton() async{
    EntryBuilder dummyEntry = EntryBuilder().setName("Name").setValue(0.0).setDate(DateTime.now());
    await _em.then((em) async => em.add(await dummyEntry.build(em)));
  }

  Budget currentBudget(){
    if(viewBudgets.isEmpty){
      return Budget("Example Budget",0.0,[],DateTime.now());
    }

    return viewBudgets[currentBudgetIndex];
  }

  void budgetSwipe(double primaryVelocity){
    currentBudgetIndex = (currentBudgetIndex + (primaryVelocity > 0 ? -1 : 1 ) )%numberBudgets;
    print("SWIPE");
  }

}