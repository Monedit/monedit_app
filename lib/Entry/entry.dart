

import 'package:monedit_flutter/Entry/entry_manager.dart';

class Entry{ //TODO : change types + order attributes and functions consistently (also in the DB)
  final int id;
  final DateTime date;
  final String name;
  final double value;
  final String category; //TODO : should Category be a class?

  Entry(this.id, this.date, this.name, this.value, this.category);

  bool equals(Entry other){
    return id == other.id && date == other.date && name == other.name && value == other.value && category == other.category;
  }

  Map<String, Object?> toMap(){
    return {
      'id' : id,
      'date' : date.toIso8601String(),
      'name' : name,
      'value' : value,
      'category' : category
    };
  }
  static Entry? fromMap(){ //TODO : make non-nullable and content
    return null;
  }

  @override
  String toString(){
    return "Entry #'$id' : '$name' at '$date' of '$category', value : '$value' ";
  }

}

class EntryBuilder {

  DateTime? date = DateTime.now(); //Default value could be "TODAY"
  String? name ;
  double? value = 0.0;
  String? category = "None"; //Default category could be None or ""

  Future<Entry> build(EntryManager manager) async{
    //TODO : do extra steps , eg : if name is empty or null use #ID as the name
    int idToUse = await manager.newId();
    name = (name == null || name!.isEmpty) ? idToUse.toString() : name; //??= if null then this
    category ??= "None";
    date ??= DateTime.now(); //Should be today
    //TODO : check value is not null : should be done in manager
    return Entry(idToUse, date!, name!, value!, category!);
  }

  bool isValid(){
    return value != null && value != 0.0;
  }

  EntryBuilder setDate(DateTime toSet){
    date = toSet;
    return this;
  }
  EntryBuilder setName(String toSet){
    name = toSet;
    return this;
  }
  EntryBuilder setValue(double toSet){
    value = toSet;
    return this;
  }
  EntryBuilder setCategory(String toSet){
    category = toSet;
    return this;
  }


}


