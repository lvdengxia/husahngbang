import 'package:flutter/material.dart';

class CommonProvider with ChangeNotifier{

  int bottomItemIndex = 0;

  setBottomItemIndex(index){
    this.bottomItemIndex = index;
    notifyListeners();
  }

}