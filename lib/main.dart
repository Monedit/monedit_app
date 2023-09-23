import 'package:flutter/material.dart';

import 'Entry View/entry_adder_widget.dart';
import 'Entry/entry_tab_widget.dart';
import 'Quick View/quick_view_widget.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[ //Here put the 3 custom widgets for entries, quick view, stats
    EntryTabWidget(),
    QuickViewWidget(),
    Text(
      'Index 2: Stats',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.flutter_dash_rounded, size : 40) ,
        title: const Text('Monedit',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold) ,),
        actions: [
          IconButton(icon: const Icon(Icons.person_rounded, size : 40),
            onPressed: (){},  ),
          const Padding(padding: EdgeInsets.all(10))
        ],
        backgroundColor: Colors.green[900],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails ded){
          _selectedIndex = (_selectedIndex + (ded.primaryVelocity! > 0 ? -1 : 1 ) )%3;
          setState(() {});
        },
        child: BottomNavigationBar(
          iconSize: 40,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox_rounded),
              label: 'Entries',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.av_timer_rounded),
              label: 'Quick View',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assessment_rounded),
              label: 'Stats',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amberAccent,
          onTap: _onItemTapped,
          backgroundColor: Colors.green[900],
        ),
      )
    );
  }
}
