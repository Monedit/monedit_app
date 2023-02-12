import 'package:tuple/tuple.dart';

class Filter{

  //TODO : change types
  String? nameFilter;
  Tuple2<int,int?>? valueFilter;
  Tuple2<DateTime,DateTime?>? dateFilter;
  String? categoryFilter;

  Tuple2<String,List<Object?>> makeQuery(){ //TODO : modularize strings query section
    List<Object?> whereArgs = [];
    String where = '';

    if(nameFilter != null){ //TODO : this could be a function
      where += "name LIKE '%?%' AND";
      whereArgs.add(nameFilter);
    }
    if(categoryFilter != null){
      where += "category LIKE '%?%' AND";
      whereArgs.add(categoryFilter);
    }
    if(valueFilter != null){//TODO : this could be a function
      if(valueFilter!.item2 != null){
        where += "value BETWEEN ? AND ?  AND";
        whereArgs.addAll([valueFilter!.item1,valueFilter!.item2!]);
        //return here in the function
      }else{//get rid of this
        where += "value = ? AND";
        whereArgs.add(valueFilter!.item1);
        //return here in the function
      }

    }

    if(dateFilter != null){//TODO : this could be a function
      if(dateFilter!.item2 != null){
        where += "date BETWEEN ? AND ? ";
        whereArgs.addAll([dateFilter!.item1,dateFilter!.item2!]);
        //return here in the function
      }else{//get rid of this
        where += "date = ?";
        whereArgs.add(dateFilter!.item1);
        //return here in the function
      }

    }

    return Tuple2(where, whereArgs);
  }

}