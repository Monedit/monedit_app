import 'package:test/test.dart';
import 'package:monedit_flutter/Entry/entry.dart';
import 'package:monedit_flutter/Entry/entry_manager.dart';

void main() async {

  EntryManager em = EntryManager();
  DateTime now = DateTime.now();

  test("Entry : creation as expected", () async {
    Entry e = Entry(0,now,"ad",2,"po");
    expect(e.id, equals(0));
    expect(e.date, equals(1));
    expect(e.name, equals("ad"));
    expect(e.value, equals(2));
    expect(e.category, equals("po"));
  });

  test("Entry Builder : ",() async {
    EntryBuilder eb = EntryBuilder();
    Entry e1 = Entry(0,now,"ad",2,"po");
    Entry e2 = await eb.setDate(now)
        .setName("ad")
        .setValue(2)
        .setCategory("po")
        .build(em);
    expect(e1.id, equals(e2.id));
    expect(e1.date, equals(e2.date));
    expect(e1.name, equals(e2.name));
    expect(e1.value, equals(e2.value));
    expect(e1.category, equals(e2.category));
  });

}