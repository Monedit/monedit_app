import 'package:tuple/tuple.dart';
import 'entry.dart';

class Filter{

  //TODO : change types
  String? nameFilter;
  Tuple2<int,int>? valueFilter;
  Tuple2<DateTime,DateTime>? dateFilter;
  String? categoryFilter;

  bool inFilter(Entry e){ //TODO : useful?
    if(nameFilter != null && e.name == nameFilter){
      return true;
    }
    if(valueFilter != null && e.value >= valueFilter!.item1 && e.value <= valueFilter!.item2) {
      return true;
    }
    if(dateFilter != null && e.date.isAfter(dateFilter!.item1)  && e.date.isBefore(dateFilter!.item2)){
      return true;
    }
    if(categoryFilter != null && e.category == categoryFilter){
      return true;
    }
    return false;
  }

  String makeQuery(){ //TODO
    return "";
  }

}