import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyScaffoldProvider with ChangeNotifier{

  Offset _offset = Offset.zero;
  Offset get offset{
    return _offset;
  }

  bool _appbarShowed = true;

  //Method to set properties to default when the next pushed page use the same MyScaffoldProvider
  void setDefault(bool doNotifyListeners){
    _offset = Offset.zero;
    _appbarShowed = true;
    (doNotifyListeners)? notifyListeners() : null;
  }

  void scrollListener(ScrollController childScrollController) { 
    if(childScrollController.position.userScrollDirection == ScrollDirection.reverse){
      if(_appbarShowed){
        _appbarShowed = !_appbarShowed;
        _offset -= const Offset(0, 1);
        // print('reverse');
        notifyListeners();
      }
    }
    else if(childScrollController.position.userScrollDirection == ScrollDirection.forward){
      if(!_appbarShowed){
        _appbarShowed = !_appbarShowed;
        _offset += const Offset(0, 1);
        // print('forward');
        notifyListeners();
      }
    }
  }
}