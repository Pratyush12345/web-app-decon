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
  ClientDetailModel clientDetailModel;
  
  init(){
    selectedSeries = "";
    clientDetailModel = ClientDetailModel();
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
  
  getClientDetail(String clientCode) async{
   try{
    clientDetailModel =  await _databaseCallServices.getClientDetail(clientCode);
    selectedSeries = clientDetailModel.selectedSeries;
   }
   catch(e){
     print(e);
   }
  }

  getManagerDetail() async{
    try{
     return await _databaseCallServices.getManagerCredentails(clientDetailModel.selectedManager.trim());
    }catch(e){
      print(e);
    }
  }

  onPressedDone(BuildContext context, String clientCode, ClientDetailModel clientDetailModel, ClientListModel clientListModel  ) async{
     String clientListMsg= await _databaseCallServices.setClientList(clientListModel);
     String message =  await _databaseCallServices.setClientDetail(clientCode, clientDetailModel );
     String activateClientmsg = await _databaseCallServices.activateClient(clientCode);
     print(clientListMsg);
     print(message);
     print(activateClientmsg);
     Navigator.of(context).pop();
  }

  onDeactivatePressed(String clientCode) async{
    try{
      await _databaseCallServices.deactivateClient(clientCode);
    }
    catch(e){
      print(e);
    }
  }

}