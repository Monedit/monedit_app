import 'package:flutter/foundation.dart';
import 'package:test/test.dart';
import 'package:monedit_flutter/entry.dart';
import 'package:monedit_flutter/entry_manager.dart';

void main(){

  EntryManager em = EntryManager();
  DateTime now = DateTime.now();
  test("Entry Manager : add an entry", () {
    Entry e1 = Entry(0,now,"",0,"");
    Map<int,Entry> m = {0 : e1};
    em.add(e1);
    //expect( true, equals( mapEquals(em.entries, m) ) );
    Entry e2 = Entry(0,now,"",3,"");
    em.add(e2);
    //expect( true, equals( mapEquals(em.entries, m) ) );
  });

  test("Entry Manager : remove an entry", () {
    Entry e = Entry(0,now,"",0,"");
    Map<int,Entry> m = {};
    em.add(e);
    em.remove(0);
    //expect( true, equals( mapEquals(em.entries, m) ) );
  });

}