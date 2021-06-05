import 'package:Decon/Models/Consts/database_calls.dart';
import 'package:Decon/Models/Models.dart';
import 'package:flutter/cupertino.dart';

class AddClientVM {
  static AddClientVM instance = AddClientVM._();
  AddClientVM._();
  DatabaseCallServices _databaseCallServices = DatabaseCallServices();
  String seriesValue;
  List<String> seriesList;
  String selectedSeries;
  
  init(){
    selectedSeries = "";
  }
  getSeriesList() async{
     try{
      String series =  await _databaseCallServices.getSeriesList();
      if(series != null)
      seriesList = series?.split(",");
      else
      seriesList = [];
     }
     catch(e){
       print(e);
     }
  }

  onPressedDone(BuildContext context, String clientCode, ClientDetailModel clientDetailModel, ClientListModel clientListModel  ) async{
     String clientListMsg= await _databaseCallServices.setClientList(clientListModel);
     String message =  await _databaseCallServices.setClientDetail(clientCode, clientDetailModel );
     print(clientListMsg);
     print(message);
     Navigator.of(context).pop();
  }
}