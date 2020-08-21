import 'package:flutter/material.dart';

class FontSizeNotifier extends ChangeNotifier {
  double fontSize = 22;

  double get getFontSize => fontSize;


  changeFontSize(double newValue){
    fontSize = newValue;
    notifyListeners();
  }

}