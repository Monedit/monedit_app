import 'package:flutter/material.dart';

class CategoryManager{

  static Map<String, Icon?> nameToIconTable = {
    'None' : Icon(Icons.all_inclusive_rounded,  color: nameToColorTable['None']),
    'Food' : Icon(Icons.fastfood_rounded, color: nameToColorTable['Food'],),
    'House' : Icon(Icons.house_rounded, color: nameToColorTable['House'],)
  };

  static Map<String, Color?> nameToColorTable = {
    'None' : Colors.green,
    'Food' : Colors.red,
    'House' : Colors.blue
  };



}