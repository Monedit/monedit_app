
//TODO : everything
import 'package:monedit_flutter/entry.dart';
import 'package:monedit_flutter/entry_manager.dart';

class EntryAdderModel{

  EntryBuilder eb = EntryBuilder();
  EntryManager em = EntryManager();

  void add() async{
    em.add(eb.build(em));
  }

  void nameChange(String newName){

  }

  void categoryChange(String newCategory){

  }

  void dateChange(DateTime newDate){

  }

  void valueChange(int newValue){

  }

}