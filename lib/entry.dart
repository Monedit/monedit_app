

import 'package:monedit_flutter/entry_manager.dart';

class Entry{ //TODO : change types
  final int id;
  final DateTime date;
  final String name;
  final int value;
  final String category; //TODO : should Category be a class?

  Entry(this.id, this.date, this.name, this.value, this.category);

  bool equals(Entry other){
    return id == other.id && date == other.date && name == other.name && value == other.value && category == other.category;
  }

  Map<String, Object?> toMap(){
    return {};
  }

}

class EntryBuilder {

  DateTime? date = DateTime.now(); //Default value could be "TODAY"
  String? name= "";
  int? value = 0;
  String? category; //Default category could be None or ""

  Entry build(EntryManager manager) {
    //TODO : do extra steps , eg : if name is empty or null use #ID as the name
    int idToUse = manager.newId();
    name ??= idToUse.toString(); //??= if null then this
    category ??= "";
    date ??= DateTime.now(); //Should be today
    return Entry(idToUse, date!, name!, value!, category!);
  }

  bool isValid(){
    return value != null;
  }

  EntryBuilder setDate(DateTime toSet){
    date = toSet;
    return this;
  }
  EntryBuilder setName(String toSet){
    name = toSet;
    return this;
  }
  EntryBuilder setValue(int toSet){
    value = toSet;
    return this;
  }
  EntryBuilder setCategory(String toSet){
    category = toSet;
    return this;
  }


}


