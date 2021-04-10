import 'package:Decon/Models/Models.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ChangeCity extends ChangeNotifier{
  
  List<DeviceData> allDeviceData = [];

  void _sortList(){
    allDeviceData.sort((a, b) =>
          int.parse(a.id.split("_")[2].substring(1, 2))
              .compareTo(int.parse(b.id.split("_")[2].substring(1, 2))));
  }

  void reinitialize(){
    allDeviceData = [];
    notifyListeners();
  }

  void changecity(String methodName, {int index, DeviceData newDeviceData } ){
    
    if(methodName == "onDeviceAdded"){
      allDeviceData.add(newDeviceData);
      _sortList();
    }
    else if(methodName == "onDeviceChanged" && index!=null){
      allDeviceData[index] = newDeviceData;
    }
    else if(methodName == "onDeviceChanged" && index==null){
      allDeviceData.add(newDeviceData);
      _sortList();
    }
    
    notifyListeners();
  }
}

class ChangeWhenGetCity extends ChangeNotifier{
   
   Map citiesMap = {};
   void changeWhenGetCity(Map _citiesMap){
           
      citiesMap = _citiesMap;

     notifyListeners();
   }
   
}