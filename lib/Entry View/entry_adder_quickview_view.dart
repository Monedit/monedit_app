
//TODO : everything
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monedit_flutter/Entry%20View/entry_adder_model.dart';
import 'package:monedit_flutter/category_manager.dart';

import '../Quick View/quick_view_model.dart';

class EntryAdderQuickviewWidget extends StatefulWidget {

  final QuickViewModel parentModel;

  const EntryAdderQuickviewWidget(this.parentModel, {super.key});


  @override
  State<StatefulWidget> createState() {
    return _EntryAdderQuickviewWidgetState(parentModel);
  }

}

class _EntryAdderQuickviewWidgetState extends State<EntryAdderQuickviewWidget>{

  EntryAdderModel? model;
  QuickViewModel parentModel;

  _EntryAdderQuickviewWidgetState(this.parentModel){
    model = parentModel.adderModel;
  } //still an entry adder just the UI is slightly different and can go back to previous



  // This function displays a CupertinoModalPopup with a reasonable fixed height
  // which hosts CupertinoDatePicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system
          // navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {

    return
      Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Entry name',
            ),
            // initialValue : model.eb.name.toString(),
            onChanged: (value){
              model!.nameChange(value);
              setState(() =>{});
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          OutlinedButton(
            onPressed: () {
              _showDialog(
                CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.dateAndTime,
                  use24hFormat: true,
                  // This is called when the user changes the time.
                  onDateTimeChanged: (DateTime newTime) {
                    model!.dateChange(newTime);
                    setState(() => {});
                  },
                ),
              );
            },
            child: Text("Entry date : ${model!.eb.date.toString()}"),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Entry value',
            ),
            onChanged: (value){
              var v = double.parse(value);
              model!.valueChange(v);
              setState(() => {});
            },
            keyboardType: const TextInputType.numberWithOptions(decimal: true,signed: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            //initialValue : model.eb.value.toString(),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          DropdownButton(
            items: CategoryManager.nameToIconTable.keys.toList().map((str) => DropdownMenuItem(value : str, child: Text(str))).toList(), //TODO : Make the Category show logo and text
            onChanged: (String? selected){
              model!.categoryChange(selected!);
              setState(() {});
            },
            value: model!.eb.category,
          ),
          FloatingActionButton.extended(
            onPressed: () async {
              setState(() {});
              model!.add().then((value) => {
                  if(value){
                    parentModel.adderFinished()
                  }
              }
              );
            },
            label : const Text("Add Entry"),
            backgroundColor: Colors.green,
            icon: const Icon(Icons.add_rounded, size: 50, ),
          )
        ],
      ) ;
  }

}