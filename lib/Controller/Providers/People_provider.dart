import 'package:Decon/Models/Models.dart';
import 'package:flutter/cupertino.dart';

class PeopleProvider extends ChangeNotifier {
 Map<String, ClientDetailModel> listClientDetailModel = {};
  
 void changeClientDetail(Map<String, ClientDetailModel> _list ){
  listClientDetailModel = _list;
  notifyListeners();
 }
}