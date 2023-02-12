import 'package:flutter_test/flutter_test.dart';
import 'package:monedit_flutter/filter.dart';
import 'package:monedit_flutter/entry.dart';
import 'package:monedit_flutter/monedit_database.dart';

void main() async{
  TestWidgetsFlutterBinding.ensureInitialized();

  MoneditDatabase db = await MoneditDatabase.get();
  DateTime now = DateTime.now();

  test("Monedit Database : add and fetch", () async {
    Entry e1 = Entry(0,now,"ad",2,"po");
    Entry e2 = Entry(1,now,"ad2",3,"poad");
    await db.addEntries([e1,e2]);
    var ls = await db.fetchEntries(Filter());
    print(ls);
  });


}