import 'package:flutter/material.dart';

class RateNotifier extends ChangeNotifier {
  double rate = 0;

  double get getRate => rate;

  changeRating(double newValue){
    rate = newValue;
    notifyListeners();
  }
}