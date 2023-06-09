import 'package:flutter/cupertino.dart';
import 'package:monedit_flutter/Entry%20View/entry_adder_model.dart';
import 'package:monedit_flutter/Quick%20View/quick_view_widget.dart';
import 'package:monedit_flutter/category_manager.dart';
import 'package:tuple/tuple.dart';

import '../budget.dart';
import '../Entry/entry.dart';
import '../Entry/entry_manager.dart';
import '../budget_manager.dart';

class QuickViewModel{

  QuickViewModel(this.viewState);

  State viewState;

  final Future<EntryManager> _em = EntryManager.get();
  final Future<BudgetManager> _bm = BudgetManager.get();
  final CategoryManager _cm = CategoryManager();

  List<Entry> viewEntries = [];
  List<Budget> viewBudgets = [];

  var numberEntries = 10;
  var numberBudgets = 3;

  var currentBudgetIndex = 0;

  var adding = false;
  var adderModel = EntryAdderModel();

  var detailedBudgetView = false;

  Future<void> getViewData() async{
    viewEntries = await _em.then((em) => em.find(size : numberEntries));
    viewBudgets = await _bm.then((bm) => bm.findTimelyBudgets());
  }

  //TODO : List<Event> NextEvents()

  Future<void> quickAddButton() async{
    adderModel = EntryAdderModel();
    adding = true;
  }

  Future<void> adderFinished() async{
    await getViewData();
    adderModel = EntryAdderModel();
    adding = false;
    viewState.setState(() {});
  }

  Budget currentBudget(){
    if(viewBudgets.isEmpty){
      return Budget("Example Budget",0.0,[],DateTime.now());
    }

    return viewBudgets[currentBudgetIndex];
  }

  void budgetSwipe(double primaryVelocity){
    currentBudgetIndex = (currentBudgetIndex + (primaryVelocity > 0 ? -1 : 1 ) )%numberBudgets;
  }

}