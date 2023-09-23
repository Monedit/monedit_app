import 'package:flutter/material.dart';
import 'package:monedit_flutter/category_manager.dart';

class CategoryEditorWidget extends StatefulWidget {

  const CategoryEditorWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategoryEditorWidgetState();
  }

}

class _CategoryEditorWidgetState extends State<CategoryEditorWidget>{
  @override
  Widget build(BuildContext context) {
    return
        Column(
          children : [
            const Text("Categories"),
            Divider(),
            ListView(
              padding: const EdgeInsets.only(bottom : 10.0),
              children: CategoryManager.getIconTable().keys.map((cat) => _CategoryListTile(this ,categoryName: cat)).toList(),
            )
          ]
        );
  }

}


class _CategoryListTile extends StatelessWidget{

  final String categoryName;
  final State parentState;

  const _CategoryListTile(this.parentState,{super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Card(
        child:
        ListTile(
          leading: CategoryManager.getIcon(categoryName),
          title: Text(categoryName, style : const TextStyle(fontSize: 20, fontWeight: FontWeight.bold) ),
          trailing:
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: (){
                parentState.setState(() {

                });
              }, icon: Icon(Icons.edit_rounded)),
              IconButton(onPressed: (){
                parentState.setState(() {

                });
              }, icon: Icon(Icons.delete_rounded))
            ],
          ),
        )
    );
  }

}