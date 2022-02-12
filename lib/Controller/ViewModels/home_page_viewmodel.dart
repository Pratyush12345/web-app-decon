import 'dart:async';
import 'package:Decon/Controller/MessagingService/FirebaseMessaging.dart';
import 'package:Decon/Controller/Providers/devie_setting_provider.dart';
import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/ViewModels/Services/Auth.dart' as auth;
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Models/Consts/database_calls.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Web/DrawerFragments/Home.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageVM {
  static HomePageVM instance = HomePageVM._();
  HomePageVM._();
  bool isfromDrawer = true;
  Widget selectedDrawerWidget = Home();
  List<String> _seriesList;
  String _sheetURL, _scriptEditorURL;
  BuildContext context;
  Map _clientsMap;
  List<String> citieslist = [];
  Query _query;
  Query _delquery;
  StreamSubscription<QueryEvent> _onDataAddedSubscription;
  StreamSubscription<QueryEvent> _onDataChangedSubscription;
  StreamSubscription<QueryEvent> _onUserChangedSubscription;
  DatabaseCallServices _databaseCallServices = DatabaseCallServices();
  final Database _database = database();
  String _ccode, _scode;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  onDeviceAdded(QueryEvent event) {
    if (event.snapshot.val()["address"] != null) {
      Provider.of<ChangeDeviceData>(context, listen: false).changeDeviceData("onDeviceAdded", newDeviceData: DeviceData.fromSnapshot(event.snapshot, _scode));
    }
  }
  loadMap() async{
    await Future.delayed(Duration(milliseconds: 1000));
        GlobalVar.isDeviceChanged = false;
        Provider.of<ChangeGoogleMap>(context, listen: false).changeGoogleMap(true);
   await Future.delayed(Duration(milliseconds: 2000));
   Provider.of<ChangeGoogleMap>(context, listen: false).changeGoogleMap(false);
  }
  onDeviceChanged(QueryEvent event)  async{
    try {
      if (event.snapshot.val()["address"] != null) {
        Provider.of<ChangeDeviceData>(context, listen: false).changeDeviceData("onDeviceChanged", newDeviceData: DeviceData.fromSnapshot(event.snapshot, _scode));
        await loadMap();
      }
    } catch (e) {
        Provider.of<ChangeDeviceData>(context, listen: false).changeDeviceData("onDeviceChanged", newDeviceData: DeviceData.fromSnapshot(event.snapshot, _scode));
     }
  }

  _getDeviceSetting(_ccode, _scode) async{
    
    DataSnapshot snapshot = (await _database.ref("clients/$_ccode/series/$_scode/DeviceSetting")
        .once('value')).snapshot;
    if(_scode == "S0"){
      if(snapshot.val()!=null){
      S0DeviceSettingModel deviceSettingModel = S0DeviceSettingModel.fromSnapshot(snapshot);
      _sheetURL = deviceSettingModel.sheetURL;
      GlobalVar.seriesMap["S0"].model = deviceSettingModel; 
      }
      else{
      _sheetURL = "";
      GlobalVar.seriesMap["S0"].model = S0DeviceSettingModel();   
      }
    Provider.of<ChangeDeviceSeting>(context, listen:  false).changeDeviceSetting("S0");
    } 
    else if(_scode == "S1" && snapshot.val()!=null){
      if(snapshot.val() !=null){
      S1DeviceSettingModel deviceSettingModel = S1DeviceSettingModel.fromSnapshot(snapshot);
      _sheetURL = deviceSettingModel.sheetURL;
      GlobalVar.seriesMap["S1"].model = deviceSettingModel;
      }else{
      _sheetURL = "";  
      GlobalVar.seriesMap["S1"].model = S1DeviceSettingModel();   
      }
    Provider.of<ChangeDeviceSeting>(context, listen:  false).changeDeviceSetting("S1");
    }
    Provider.of<ChangeSeries>(context, listen: false).changeDeconSeries(_scode, _seriesList);
  }

   _getClientDetail(String clientCode) async{
   try{
    ClientDetailModel _clientDetailModel =  await _databaseCallServices.getClientDetail(clientCode);
    _seriesList = _clientDetailModel.selectedSeries.replaceFirst(",","").split(",");
    _scode = _seriesList[0];
    Provider.of<ChangeClient>(context, listen: false).changeClientDetail(_clientDetailModel);
   }
   catch(e){
     print(e);
   }
  }

  _getClientsList() async {  
    List<ClientListModel> _clientList = [];
    try{
    DataSnapshot citiesSnapshot = (await _database.ref("clientsList").once('value')).snapshot;
    _clientsMap = citiesSnapshot.val()??{};
    if(GlobalVar.strAccessLevel=="1"){
    _clientsMap.removeWhere((key, value) => GlobalVar.userDetail.clientsVisible.contains(key));
    }else{
    _clientsMap.removeWhere((key, value) => !GlobalVar.userDetail.clientsVisible.contains(key));
    }
    _clientsMap.forEach((key, value) { 
      _clientList.add(ClientListModel(clientCode: key, clientName: value));
    });
    _clientList.sort((a, b) =>
          int.parse(a.clientCode.substring(1, 2))
              .compareTo(int.parse(b.clientCode.substring(1, 2))));
    
    Provider.of<ChangeWhenGetClientsList>(context, listen: false).changeWhenGetClientsList(_clientList);
    
    }
    catch(e){
      print(e);
    }
    if(_clientList.isNotEmpty)
    _ccode = _clientList[0]?.clientCode??"C0";
    else{
    Provider.of<ChangeWhenGetClientsList>(context, listen: false).changeWhenGetClientsList([ClientListModel(clientCode: "C0", clientName: "Demo Municipal Corporation")]);
    _ccode = "C0";
    _scode = "S0";
    }
    
    }
   _checkQuery() async{
   await Future.delayed(Duration(seconds: 2));
   if( Provider.of<ChangeDeviceData>(context, listen: false).allDeviceData.isEmpty){
     Provider.of<ChangeDeviceData>(context, listen: false).rebuild();
   }
  }
  _setdelQuery(){
        
     if (GlobalVar.strAccessLevel == "1") {
       }
      else if (GlobalVar.strAccessLevel == "2") {
        _delquery =   _database.ref("/managers/${FirebaseAuth.instance.currentUser.uid}");
        _attachfunction();
      }  
      else if (GlobalVar.strAccessLevel == "3") {
        _delquery =   _database.ref("/admins/${FirebaseAuth.instance.currentUser.uid}");
       _attachfunction();
         
      }
      else if (GlobalVar.strAccessLevel == "4") {
        _delquery =   _database.ref("/managerTeam/${FirebaseAuth.instance.currentUser.uid}");
        _attachfunction();
      }
      else if (GlobalVar.strAccessLevel == "5") {
        _delquery =   _database.ref("/adminTeam/${FirebaseAuth.instance.currentUser.uid}");
        _attachfunction();   
      }
      
  }
  _attachfunction(){
     _onUserChangedSubscription    = _delquery.onChildRemoved.listen((event) { 
          
          if(event.snapshot.key == "phoneNo" && event.snapshot.val() == "${GlobalVar.userDetail.phoneNo}")
           auth.Auth.instance.signOut();
          });
  }
  
  _setQuery(String clientCode, String seriesCode) async {
    Provider.of<ChangeDeviceData>(context, listen: false).reinitialize();
    
    if(_query!=null){ 
    _onDataChangedSubscription.cancel();
    _onDataAddedSubscription.cancel();  
    }
    _query = _database.ref("clients/$clientCode/series/$seriesCode/devices");
    _onDataAddedSubscription = _query.onChildAdded.listen(onDeviceAdded);
    _onDataChangedSubscription = _query.onChildChanged.listen(onDeviceChanged);
    _checkQuery();// To Avoid map Jerk loading
  }
 
  _getClientisActive(String clientCode) async{
    DataSnapshot snapshot = (await _database.ref("clients/$clientCode/isActive").once('value')).snapshot;
    if(snapshot.val() == 1)
    GlobalVar.isActive = true;
    else  
    GlobalVar.isActive = false;
    Provider.of<ChangeOnActive>(context, listen: false).changeOnActive();
   }

  onFirstLoad() async{
    await _getClientsList();
    await _getClientisActive(_ccode);
    await _getClientDetail(_ccode);
    await _getDeviceSetting(_ccode, _scode);
    await _setQuery(_ccode, _scode);
  }

  onChangeClient() async{
    Provider.of<ChangeClient>(context, listen: false).reinitialize();
    _getScriptEditorUrl();
    await _getClientisActive(_ccode);
    await _getClientDetail(_ccode);
    await _getDeviceSetting(_ccode, _scode);
    await _setQuery(_ccode, _scode);
  }
  
  onChangeSeries() async{
    _getScriptEditorUrl();
    await _getDeviceSetting(_ccode, _scode);
    await _setQuery(_ccode, _scode);
  }
  _getScriptEditorUrl() async{
    _scriptEditorURL = (await _database.ref("clients/$_ccode/series/$_scode/DeviceSetting/doPost").once('value')).snapshot.val();
  }

  void initialize(BuildContext context){
    this.context = context;
    _ccode = "C0";
    _scode = "S0";
    onFirstLoad();
    _getScriptEditorUrl();
    FirebaseMessagingServeiceWeb.instance.initializeWebService(context);
    
  }

  void dispose(){
    _onDataChangedSubscription.cancel();
    _onDataAddedSubscription.cancel();  
    _onUserChangedSubscription.cancel();
  }

  Map get getClientsMap => _clientsMap;

  String get getClientCode => _ccode;

  String get getSheetURL => _sheetURL; 
  
  String get getScriptEditorURL => _scriptEditorURL; 
  
  set setClientCode(String clientCode){
    _ccode = clientCode;
  } 

  String get getSeriesCode => _scode;

  set setSeriesCode(String seriesCode){
    _scode = seriesCode;
  } 
   
  
}