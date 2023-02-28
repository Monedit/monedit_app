import 'package:flutter/material.dart';
import 'package:monedit_flutter/Entry/entry.dart';
import 'package:monedit_flutter/category_manager.dart';

//TODO : should each entry have a Tile OR make a adapter from Entry -> Widget??
class EntryListTile extends StatelessWidget{

  final Entry entry;

  const EntryListTile({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {

    TextStyle titleStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    TextStyle subtitleStyle = const TextStyle(fontSize: 15);

    return Card(
      child:
      ListTile( //Entry widget should be a Card with a ListTile
        trailing: Text(entry.value.toString(),style: titleStyle,),
        title: Text(entry.name, style: titleStyle,),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children : [Text(entry.category, style: subtitleStyle), Text(
              "${entry.date.day.toString()}/${entry.date.month}/${entry.date.year} , ${entry.date.hour}:${entry.date.minute}", style: subtitleStyle)],
        ),
      //  isThreeLine: true,
        leading: CategoryManager.nameToIconTable[entry.category], //fill with ICON of the Category
      //  dense:true,
        //onTap: ,
        //onLongPress: ,
      ),
    );

  }

}