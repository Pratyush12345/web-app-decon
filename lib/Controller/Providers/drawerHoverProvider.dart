import 'package:flutter/material.dart';

class DrawerHoverProvider extends ChangeNotifier {
  int hoveredIndex = -1;
  onDrawerHovered(int _hoveredIndex){
   hoveredIndex = _hoveredIndex;
   notifyListeners();
  }
}