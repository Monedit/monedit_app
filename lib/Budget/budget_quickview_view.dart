import 'package:flutter/material.dart';
import 'package:monedit_flutter/budget_stats.dart';
import 'package:monedit_flutter/category_manager.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../budget.dart';

class BudgetQuickViewView extends StatelessWidget{

  final Budget budget;
  late BudgetStats stats;
  final bool detailed;

  BudgetQuickViewView(this.budget, this.detailed, {super.key}){
    stats = BudgetStats(budget);
  }

  Widget? circleCenter(double currBalance){
    if (currBalance == 0.0){
      return Column(
        mainAxisAlignment : MainAxisAlignment.center,
        children: [
        Text(budget.name),
        Text(budget.balance.toString())
        ],
      );
    }else{
      return null;
    }
  }

  List<Widget> makeCircles(){
    List<Widget> ls = [];
    double currBalance = 0.0;


    stats.balanceByCategory.forEach((key, value) {
      ls.add(
        CircularPercentIndicator(
          radius:  !detailed ? 150.0 : 100.0 ,
          lineWidth: 15.0,
          percent: (currBalance+value)/budget.balance,
          center: circleCenter(currBalance),
          progressColor: CategoryManager.nameToColorTable[key],
          backgroundColor: Colors.transparent,
        )
      );
      currBalance += value;
    });

    return ls.reversed.toList();
  }

  Widget makeDetails(){
    List<Widget> ls = [];
    TextStyle subtitleStyle = const TextStyle(fontSize: 15);


    stats.balanceByCategory.forEach((key, value) {
      ls.add(
              ListTile(
                leading: CategoryManager.nameToIconTable[key],
                title : Text( "${(100*value/budget.balance).toStringAsFixed(2)}%" , style : subtitleStyle )
              )
      );
    });

    return Column(
      children: ls,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: stats.init(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot){
        if(snapshot.connectionState == ConnectionState.done ){
          var circles = Stack(
            children: makeCircles(),
          );
          if(detailed){
            return Padding(
                padding: const EdgeInsets.only(left : 30.0),
                child :Row(
                  children: [
                    circles,
                    Flexible( child : makeDetails() )
                  ],
                )
            );
          }else{
            return circles;
          }

        }else if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        else{
          return CircularPercentIndicator(
            radius: 150.0,
            lineWidth: 15.0,
            percent: 0.0,
            center: Text(budget.name),
            progressColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          );
        }
      },
    );


  }

  
}