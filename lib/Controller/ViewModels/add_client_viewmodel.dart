import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
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
    seriesList = null;
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
  
  
  onPressedDone(BuildContext context,UserDetailModel previousManagerModel, String previousClientsVisible, bool isedit, ClientDetailModel clientDetailModel, ClientListModel clientListModel  ) async{
     String res1 = await _databaseCallServices.setClientList(clientListModel);
     String res2 =  await _databaseCallServices.setClientDetail(clientListModel.clientCode, clientDetailModel );
     String res3 = await _databaseCallServices.activateClient(clientListModel.clientCode);
     String clientsVisible =  previousClientsVisible + "," + clientListModel.clientCode;
     String res4 = await _databaseCallServices.setManagerClientVisible(clientDetailModel.selectedManager, clientsVisible);
     
     if(isedit && previousManagerModel!=null && clientDetailModel.selectedManager != previousManagerModel?.key  ){
      previousManagerModel.clientsVisible = previousManagerModel?.clientsVisible?.replaceAll(",${clientListModel.clientCode}", "");
      String res5 = await _databaseCallServices.setManagerClientVisible(previousManagerModel?.key, previousManagerModel.clientsVisible );   
      print(res5);
     }
     _setDeviceSetting( clientListModel.clientCode, clientDetailModel.selectedSeries.replaceFirst(",","" ).split(","));
     print(res1);
     print(res2);
     print(res3);
     print(res4);
     HomePageVM.instance.onFirstLoad();
     
     Navigator.of(context).pop();
  }

  _setDeviceSetting(String clientCode, List<String> _selectedSeries) async{
     for(int i = 0; i < _selectedSeries.length; i++ ){
      String res6 = await _databaseCallServices.setDeviceSettingDefault(clientCode,_selectedSeries[i]);
     }
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