import 'package:monedit_flutter/monedit_database.dart';

import 'budget.dart';

class BudgetStats{
  Budget budget;
  Map<String , double> balanceByCategory = {};

  BudgetStats(this.budget);

  Future<void> init() async{
      var db = await MoneditDatabase.get();
      var entries = await db.fetchEntriesById(budget.entriesIds);


      for ( var e in entries ) {
        balanceByCategory.update(e.category,
                (prevBalance) => prevBalance + e.value,
                ifAbsent: () => e.value);

      }

  }

}