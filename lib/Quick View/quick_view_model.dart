import '../budget.dart';
import '../entry.dart';
import '../entry_manager.dart';

class QuickViewModel{

  Future<EntryManager> em = EntryManager.get();
  //TODO : Budget Manager

  void prevBudget(){

  }

  void nextBudget(){

  }

  Budget getBudget(){
    return Budget("",0,[],DateTime.now());
  }

  List<Entry> lastEntries(){
    return [];
  }

  //TODO : List<Event> NextEvents()

  void quickAddButton(){

  }

}