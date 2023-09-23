import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monedit_flutter/Entry%20View/entry_adder_widget.dart';

import '../Entry View/category_editor_widget.dart';

class EntryTabWidget extends StatefulWidget {

  const EntryTabWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EntryTabWidgetState();
  }

}

class _EntryTabWidgetState extends State<EntryTabWidget>{

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child:Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const TabBar(
              indicatorPadding: EdgeInsets.only(left: 15.0, right: 15.0),
              tabs: [Icon(Icons.add_rounded, size: 40.0,), Icon(Icons.edit_rounded,size: 40.0)],
            ),
          ),
          body:
              GestureDetector(
                onHorizontalDragEnd: (DragEndDetails ded){ setState(() {}); },
                onTap: (){ setState(() {}); },
          child : TabBarView(
            children: [
              EntryAdderWidget(),
              CategoryEditorWidget()
            ],
          ),
        )
        )

    );
  }

}