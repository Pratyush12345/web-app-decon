import 'dart:async';
import 'package:Decon/Controller/Providers/devie_setting_provider.dart';
import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Models/Consts/database_calls.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Android/DrawerFragments/Home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageVM {
  static HomePageVM instance = HomePageVM._();
  HomePageVM._();
  bool isfromDrawer = true;
  Widget selectedDrawerWidget = Home();
  int selectedDrawerIndex = 0;
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();
  List<String> _seriesList;
  String _sheetURL;
  BuildContext context;
  Map _clientsMap;
  List<String> citieslist = [];
  Query _query;
  StreamSubscription<Event> _onDataAddedSubscription;
  StreamSubscription<Event> _onDataChangedSubscription;
  DatabaseCallServices _databaseCallServices = DatabaseCallServices();
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  String _ccode, _scode;
  
  onDeviceAdded(Event event) {
    if (event.snapshot.value["address"] != null) {
      Provider.of<ChangeDeviceData>(context, listen: false).changeDeviceData("onDeviceAdded", newDeviceData: DeviceData.fromSnapshot(event.snapshot, _scode));
    }
  }

  onDeviceChanged(Event event) {
    try {
      if (event.snapshot.value["address"] != null) {
        Provider.of<ChangeDeviceData>(context, listen: false).changeDeviceData("onDeviceChanged", newDeviceData: DeviceData.fromSnapshot(event.snapshot, _scode));
      }
    } catch (e) {
        Provider.of<ChangeDeviceData>(context, listen: false).changeDeviceData("onDeviceChanged", newDeviceData: DeviceData.fromSnapshot(event.snapshot, _scode));
     }
  }

  _getDeviceSetting(_ccode, _scode) async{
    
    DataSnapshot snapshot = await FirebaseDatabase.instance
        .reference()
        .child("clients/$_ccode/series/$_scode/DeviceSetting")
        .once();
    if(_scode == "S0"){
      if(snapshot.value!=null){
      S0DeviceSettingModel deviceSettingModel = S0DeviceSettingModel.fromSnapshot(snapshot);
      GlobalVar.seriesMap["S0"].model = deviceSettingModel; 
      }
      else{
      GlobalVar.seriesMap["S0"].model = S0DeviceSettingModel();   
      }
    Provider.of<ChangeDeviceSeting>(context, listen:  false).changeDeviceSetting("S0");
    } 
    else if(_scode == "S1" && snapshot.value!=null){
      if(snapshot.value!=null){
      S1DeviceSettingModel deviceSettingModel = S1DeviceSettingModel.fromSnapshot(snapshot);
      GlobalVar.seriesMap["S1"].model = deviceSettingModel;
      }else{
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
    DataSnapshot citiesSnapshot = await FirebaseDatabase.instance.reference().child("clientsList").once();
    _clientsMap = citiesSnapshot.value??{};
    if(GlobalVar.strAccessLevel=="1"){
    _clientsMap.removeWhere((key, value) => GlobalVar.userDetail.clientsVisible.contains(key));
    }else{
    _clientsMap.removeWhere((key, value) => !GlobalVar.userDetail.clientsVisible.contains(key));
    }
    Provider.of<ChangeWhenGetClientsList>(context, listen: false).changeWhenGetClientsList(_clientsMap);
    _clientsMap.forEach((key, value) { 
      if(value.toString().contains("Demo"))
      _ccode = key;
    });
    }

  _setQuery(String clientCode, String seriesCode) async {
    Provider.of<ChangeDeviceData>(context, listen: false).reinitialize();
    
    if(_query!=null){ 
    _onDataChangedSubscription.cancel();
    _onDataAddedSubscription.cancel();  
    }
    _query = _database.reference().child("clients/$clientCode/series/$seriesCode/devices");
    _onDataAddedSubscription = _query.onChildAdded.listen(onDeviceAdded);
    _onDataChangedSubscription = _query.onChildChanged.listen(onDeviceChanged);
  }
 
  onFirstLoad() async{
    await _getClientsList();
    await _getClientDetail(_ccode);
    await _getDeviceSetting(_ccode, _scode);
    await _setQuery(_ccode, _scode);
  }

  onChangeClient() async{
    Provider.of<ChangeClient>(context, listen: false).reinitialize();
    await _getClientDetail(_ccode);
    await _getDeviceSetting(_ccode, _scode);
    await _setQuery(_ccode, _scode);
  }
  
  onChangeSeries() async{
    await _getDeviceSetting(_ccode, _scode);
    await _setQuery(_ccode, _scode);
  }

  void initialize(BuildContext context){
    this.context = context;
    _ccode = "C0";
    _scode = "S0";
    onFirstLoad();
  }

  void dispose(){
    _onDataChangedSubscription.cancel();
    _onDataAddedSubscription.cancel();  
  }

  Map get getCitiesMap => _clientsMap;

  String get getClientCode => _ccode;

  String get getSheetURL => _sheetURL; 
  
  set setClientCode(String clientCode){
    _ccode = clientCode;
  } 

  String get getSeriesCode => _scode;

  set setSeriesCode(String seriesCode){
    _scode = seriesCode;
  } 
   
 
}