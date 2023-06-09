
import 'Entry/entry.dart';

class Budget{ //This budget has no warning point for the balance
  final String name;
  double balance;
  final List<int> entriesIds;
  DateTime lastUse;
  //TODO : need to put last use date?

  Budget(this.name,this.balance, this.entriesIds, this.lastUse);

  Map<String, Object?> toDbMap(){
    return {
      'name' : name,
      'balance' : balance
    };
  }

  //TODO : store it in the DB somehow
  void add(Entry e){
    entriesIds.add(e.id);
    if(name != 'None'){ //TODO : 'None' or 'All'
      //add the entry to the None budget
    }
  }

}

//TODO : all budget builder
class BudgetBuilder{

  String? name;

  Budget build(){
    return Budget(name!,0,[],DateTime.now());
  }

  BudgetBuilder setName(String newName){
    name = newName;
    return this;
  }

  bool isValid(){
    return name != null;
  }

}