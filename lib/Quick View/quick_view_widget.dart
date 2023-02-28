
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monedit_flutter/Entry/entry.dart';
import 'package:monedit_flutter/Entry/entry_list_tile.dart';
import 'package:monedit_flutter/Quick%20View/quick_view_model.dart';
import 'package:monedit_flutter/monedit_database.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tuple/tuple.dart';

import '../Budget/budget_quickview_view.dart';
import '../budget.dart';

class QuickViewWidget extends StatefulWidget{


  @override
  State<QuickViewWidget> createState() {
    return _QuickViewWidgetState();
  }
  const QuickViewWidget({super.key});

}

class _QuickViewWidgetState extends State<QuickViewWidget>{

 // var mdb = MoneditDatabase.get().then((db) => Tuple2(db.fetchEntries(Filter()), db.fetchBudgetsBySize(3)));
  //TODO : this should be an entry manager and a budget manager NOT the DB
 // var mdb = MoneditDatabase.get().then( (db) async => Tuple2(await db.fetchEntriesBySize(10), await db.fetchBudgetsBySize(3))  );
  //TODO : make 1 Future who has all the content that is needed -> load everything once all at a time

  QuickViewModel model = QuickViewModel();
  late Future<void> modelData =  model.getViewData();

  Widget budgetSelector(int index){
      double size = index != model.currentBudgetIndex ? 10 : 20;
      Color color = index != model.currentBudgetIndex ? Colors.grey : Colors.blueGrey;
      return
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right : 5.0),
          child :
            Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ))
        );

  }

  @override
  Widget build(BuildContext context) {
    //TODO : put quick view content here
   // ListTile.divideTiles(tiles: [const Card()]); // to divide with dividers automatically

    return FutureBuilder<void>(
      future: modelData,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot){
        if(snapshot.connectionState == ConnectionState.done ){
          //TODO : modularize all of this please

          return Stack(
            children: [
              Padding(
                  padding : const EdgeInsets.only(top : 10.0),
                  child : Column(
                    children: [
                      Padding(
                        padding : const EdgeInsets.only(bottom: 10.0),
                        child : Row(
                          mainAxisAlignment : MainAxisAlignment.center,
                          children: [for (int index = 0 ; index < model.numberBudgets ; ++index )
                            budgetSelector(index)
                          ],
                        )
                      ),
                      GestureDetector(
                        child : BudgetQuickViewView(model.currentBudget()),
                        onTap: () {
                        },
                        onHorizontalDragEnd: (DragEndDetails ded){
                          model.budgetSwipe(ded.primaryVelocity!);
                          setState(() {});
                        },
                      ),
                      const Divider(),
                      Expanded(
                          child : ListView(
                            children: model.viewEntries.map((e) => EntryListTile(entry: e)).toList(),
                          )
                      )
                    ],
                  )
              ),
              Positioned(
                right: 25,
                bottom : 25,
                width: 70,
                height: 70,
                child: FloatingActionButton(
                  onPressed: () async {
                    modelData = model.quickAddButton().then((value) => model.getViewData());
                    setState(() {});
                    },
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add_rounded, size: 50, ),
                ),
              )
            ],
          ) ;


        }else if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        else{
          return const CupertinoActivityIndicator(radius: 40.0, color: CupertinoColors.systemGreen,);
        }
      },
    );


  }
  
}