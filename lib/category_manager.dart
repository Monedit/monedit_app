import 'package:flutter/material.dart';

class CategoryManager{

  static Map<String, Icon?> _nameToIconTable = {
    'None' : Icon(Icons.all_inclusive_rounded,  color: getColor("None"),),
    'Food' : Icon(Icons.fastfood_rounded, color: getColor('Food'), ),
    'House' : Icon(Icons.house_rounded, color: getColor('House'), )
  };

  static Icon _defaultIcon = Icon(Icons.all_inclusive_rounded,  color: _defaultColor,);

  static Map<String, Color?> _nameToColorTable = {
    'None' : Colors.green,
    'Food' : Colors.red,
    'House' : Colors.blue
  };

  static Color _defaultColor = Colors.black;

  static Map<String, Icon?> getIconTable() {
    return _nameToIconTable;
  }


  static Icon getIcon(String cat){
    return _nameToIconTable[cat] ?? _defaultIcon;
  }

  static Color getColor(String cat){
    return _nameToColorTable[cat] ?? _defaultColor;
  }



}