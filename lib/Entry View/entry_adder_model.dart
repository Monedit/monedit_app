
//TODO : everything
import 'package:monedit_flutter/entry.dart';
import 'package:monedit_flutter/entry_manager.dart';

class EntryAdderModel{

  EntryBuilder eb = EntryBuilder();
  Future<EntryManager> em = EntryManager.get();

  void add() async{
    (await em).add(await eb.build(await em));
    //TODO : update widget -> reset or exit adder
  }

  void nameChange(String newName){
    eb.setName(newName);
    //TODO : update widget with new name
  }

  void categoryChange(String newCategory){
    eb.setCategory(newCategory);
    //TODO : update widget with new category
  }

  void dateChange(DateTime newDate){
    eb.setDate(newDate);
    //TODO : update widget with new date
  }

  void valueChange(double newValue){
    eb.setValue(newValue);
    //TODO : update widget with new value
  }

}