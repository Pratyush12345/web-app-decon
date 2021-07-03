import 'package:Decon/Models/Models.dart';

import 'package:flutter/material.dart';
class ChangeManager extends ChangeNotifier{
   
   UserDetailModel userDetailModel;
   void changeManager(UserDetailModel _model){
           
     userDetailModel = _model;
     notifyListeners();
   }
   
}


