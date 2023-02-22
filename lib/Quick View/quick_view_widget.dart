
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class QuickViewWidget extends StatefulWidget{

  @override
  State<QuickViewWidget> createState() {
    return _QuickViewWidgetState();
  }
  const QuickViewWidget({super.key});

}

class _QuickViewWidgetState extends State<QuickViewWidget>{

  @override
  Widget build(BuildContext context) {
    //TODO : put quick view content here

   // ListTile.divideTiles(tiles: [const Card()]); // to divide with dividers automatically

    return Column(
      children: [
        GestureDetector(
          child :CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 5.0,
            percent: 0.5,
            center: const Text("HELLO IM AT THE CENTER"),
            progressColor: Colors.green,
            backgroundColor: Colors.black,
          ),
          //onTap: ,
        ),
        const Divider(),
        Expanded(
          child : ListView(

              children: const [
                Card(
                  child:
                      ListTile( //Entry widget should be a Card with a ListTile
                        title: Text("REPLACE BY ENTRY INFO"),
                        subtitle: Text("yay more details"),
                        //onTap: ,
                        //onLongPress: ,
                      ),
                ),
                Card(
                  child:
                  ListTile( //Entry widget should be a Card with a ListTile
                    title: Text("REPLACE BY ENTRY INFO"),
                    subtitle: Text("yay more details"),
                    isThreeLine: true,
                    //onTap: ,
                    //onLongPress: ,
                  ),
                ),
              ],
            )
          )
        ],

    );
  }
  
}