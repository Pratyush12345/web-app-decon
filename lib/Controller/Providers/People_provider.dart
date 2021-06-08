import 'package:Decon/Models/Models.dart';
import 'package:flutter/cupertino.dart';

class PeopleProvider extends ChangeNotifier {
 List<ClientDetailModel> listClientDetailModel = [];
  
 void changeClientDetail(List<ClientDetailModel> _list ){
  listClientDetailModel = _list;
  notifyListeners();
 }
}