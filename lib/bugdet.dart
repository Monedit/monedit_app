
class Budget{
  final String name;
  final int balance; //TODO : change types
  final List<int> uniqueEntries;

  Budget(this.name,this.balance, this.uniqueEntries){
    print("Budget constructor called");
  }

  //TODO : store it in the DB somehow

}


class BudgetBuilder{

  String? name;

  Budget build(){
    return Budget(name!,0,[]);
  }

  bool isValid(){
    return name != null;
  }

}