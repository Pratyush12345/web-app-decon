import 'package:flutter/material.dart';

class DeviceHoverProvider extends ChangeNotifier {
  int hoveredIndex = -1;
  onDeivceHovered(int _hoveredIndex){
   hoveredIndex = _hoveredIndex;
   notifyListeners();
  }
}