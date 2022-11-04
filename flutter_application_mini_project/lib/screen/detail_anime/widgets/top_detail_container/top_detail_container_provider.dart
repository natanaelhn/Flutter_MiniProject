import 'package:flutter/material.dart';

class TopDetailContainerProvider with ChangeNotifier{

  int _index = 0;
  int get index => _index;

  void setDefault(){
    _index = 0;
  }

  void setIndex(int index){
    _index = index;
    notifyListeners();
  }

}