import 'dart:convert';

import 'package:Decon/Models/Consts/base_calls.dart';
import 'package:Decon/Models/Consts/database_path.dart';
import 'package:Decon/Models/Models.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseCallServices extends BaseCall{
  
  Future<UserDetailModel> getSuperAdminCredentails(String uid) async {
   String url = "${DatabasePath.getSuperAdminCredentials}/$uid";
   DataSnapshot snapshot = await databaseOnceCall(url);
   return UserDetailModel.fromJson(snapshot.key, snapshot.value);
  }

  Future<UserDetailModel> getManagerCredentails(String uid) async {
   String url = "${DatabasePath.getManagerCredentials}/$uid";
   DataSnapshot snapshot = await databaseOnceCall(url);
   return UserDetailModel.fromJson(snapshot.key, snapshot.value);
  }
  Future setManagerClientVisible(String uid, String clientsVisible) async {
   String url = "${DatabasePath.getManagerCredentials}/$uid";
   return await databaseUpdateCall(url, {"clientsVisible": clientsVisible });
  }
  

  Future<UserDetailModel> getAdminCredentails(String uid) async {
   String url = "${DatabasePath.getAdminCredentials}/$uid";
   DataSnapshot snapshot = await databaseOnceCall(url);
   return UserDetailModel.fromJson(snapshot.key, snapshot.value);
  }

  Future<UserDetailModel> getManagerTeamCredentails(String managerUid, String uid) async {
   String url = "${DatabasePath.getManagerTeamCredentials}/$managerUid/$uid";
   DataSnapshot snapshot = await databaseOnceCall(url);
   return UserDetailModel.fromJson(snapshot.key, snapshot.value);
  }

  Future<UserDetailModel> getadminTeamCredentails(String adminUid, String uid) async {
   String url = "${DatabasePath.getAdminCredentials}/$adminUid/$uid";
   DataSnapshot snapshot = await databaseOnceCall(url);
   return UserDetailModel.fromJson(snapshot.key, snapshot.value);
  }

  Future<List<UserDetailModel>> getManagerTeamCredentailsList(String managerUid) async {
   String url = "${DatabasePath.getManagerTeamCredentials}/$managerUid";
   DataSnapshot snapshot = await databaseOnceCall(url);
   List<UserDetailModel> _list = [];
   (snapshot.value as Map)?.forEach((key, value) { 
     _list.add(UserDetailModel.fromJson(key, value));
   });
    return _list;
    }

  Future<List<UserDetailModel>> getAdminTeamCredentailsList(String adminUid) async {
   String url = "${DatabasePath.getAdminTeamCredentials}/$adminUid";
   DataSnapshot snapshot = await databaseOnceCall(url);
   List<UserDetailModel> _list = [];
   (snapshot.value as Map)?.forEach((key, value) { 
     _list.add(UserDetailModel.fromJson(key, value));
   });
    return _list;
    }  

  Future<ClientDetailModel> getClientDetail(String clientCode) async {
   String url = "${DatabasePath.getClientDetail}/$clientCode/Detail";
   DataSnapshot snapshot = await databaseOnceCall(url);
   return ClientDetailModel.fromJson(snapshot.value);
  }

  Future<String> getSeriesList() async {
   String url = "${DatabasePath.getSeriesList}";
   DataSnapshot snapshot = await databaseOnceCall(url);
   return snapshot.value;
  }

  Future<String> setClientDetail(String clientCode, ClientDetailModel model) async {
    String url = "${DatabasePath.setClientDetail}/$clientCode/Detail";
    String message = await databaseUpdateCall(url, model.toJson());
    return message;
  }

  
  Future setClientList(ClientListModel model) async {
    String url = "${DatabasePath.setClientList}";
    String message = await databaseUpdateCall(url, model.toJson());
    return message;
  }

  Future deactivateClient(String clientCode) async{
    String url = "${DatabasePath.client}/$clientCode";
    return await databaseUpdateCall(url, {"isActive" : 0} );
  }


  Future activateClient(String clientCode) async{
    String url = "${DatabasePath.client}/$clientCode";
    return await databaseUpdateCall(url, {"isActive" : 1} );
  }

  Future setDeviceSettingDefault(String clientCode, String seriesCode) async{
    String url = "${DatabasePath.client}/$clientCode/series/$seriesCode/DeviceSetting";
    if(seriesCode == "S0"){
    return await databaseUpdateCall(url, S0DeviceSettingModel().toDefaultJson());
    }
    else if(seriesCode == "S1"){
    return await databaseUpdateCall(url, S1DeviceSettingModel().toDefaultJson());
    }
  }
 Future setDeviceSetting(String clientCode, String seriesCode, Map<String, dynamic> jsonData ) async{
    String url = "${DatabasePath.client}/$clientCode/series/$seriesCode/DeviceSetting";
    if(seriesCode == "S0"){
    return await databaseUpdateCall(url, jsonData);
    }
    else if(seriesCode == "S1"){
    return await databaseUpdateCall(url, jsonData);
    }
  }
}