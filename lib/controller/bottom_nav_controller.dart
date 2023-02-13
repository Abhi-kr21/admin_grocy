import 'package:flutter/cupertino.dart';

class BottomNavigationController extends ChangeNotifier {
  int currentindex = 0;
  int getindex() {
    return currentindex;
  }

  void setindex(int index) {
    currentindex = index;
    notifyListeners();
  }
}
