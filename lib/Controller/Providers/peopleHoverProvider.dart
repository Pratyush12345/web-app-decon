import 'package:flutter/material.dart';

class PeopleHoverProvider extends ChangeNotifier {
  String idHovered = "-1";
  onPeopleHovered(String _idHovered){
   idHovered = _idHovered;
   notifyListeners();
  }
}