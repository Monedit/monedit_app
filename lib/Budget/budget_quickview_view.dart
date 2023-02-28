import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../budget.dart';

class BudgetQuickViewView extends StatelessWidget{

  final Budget budget;

  const BudgetQuickViewView(this.budget, {super.key});

  @override
  Widget build(BuildContext context) {

    return CircularPercentIndicator(
      radius: 150.0,
      lineWidth: 15.0,
      percent: 1.0,
      center: Column(
        mainAxisAlignment : MainAxisAlignment.center,
        children: [
          Text(budget.name),
          Text(budget.balance.toString())
        ],
      ),
      progressColor: Colors.green,
      backgroundColor: Colors.black,
    );

  }

  
}