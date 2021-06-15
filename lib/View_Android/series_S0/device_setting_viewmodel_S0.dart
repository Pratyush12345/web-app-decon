import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/Models/Consts/database_calls.dart';
import 'package:Decon/Models/Models.dart';
import 'package:flutter/material.dart';

class DeviceSettingS0VM {
  static DeviceSettingS0VM instance = DeviceSettingS0VM._();
  DeviceSettingS0VM._();
  DatabaseCallServices _databaseCallServices = DatabaseCallServices();
  final maholesdepth = TextEditingController();
  final batterythresholdvalue = TextEditingController();

  loadFromModel() {
    S0DeviceSettingModel _s0DeviceSettingModel = (GlobalVar.seriesMap["S0"].model) as S0DeviceSettingModel;
    maholesdepth.text = _s0DeviceSettingModel.manholedepth.toString();
    batterythresholdvalue.text = _s0DeviceSettingModel.batterythresholdvalue.toString();
  }

  onAddPressed() async { 
      try {
        String res6 = await _databaseCallServices.setDeviceSetting(
          HomePageVM.instance.getClientCode, 
          "S0",
          S0DeviceSettingModel(
            batterythresholdvalue: int.parse(batterythresholdvalue.text.toString()),
            manholedepth: double.parse(maholesdepth.text.toString())

          ).toJson() 
        );
        print(res6);
      } catch (e) {
        print(e);
      }
    }
  
}
