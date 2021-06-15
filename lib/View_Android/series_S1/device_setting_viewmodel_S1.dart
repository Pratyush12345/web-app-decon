import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/Models/Consts/database_calls.dart';
import 'package:Decon/Models/Models.dart';
import 'package:flutter/material.dart';

class DeviceSettingS1VM {
  static DeviceSettingS1VM instance = DeviceSettingS1VM._();
  DeviceSettingS1VM._();
  DatabaseCallServices _databaseCallServices = DatabaseCallServices();
  final maholesdepth = TextEditingController();
  final crticallevelabove = TextEditingController();
  final informativelevelabove = TextEditingController();
  final normallevelabove = TextEditingController();
  final groundlevelbelow = TextEditingController();
  final tempthresholdvalue = TextEditingController();
  final batterythresholdvalue = TextEditingController();

  loadFromModel() {
    S1DeviceSettingModel _s1DeviceSettingModel = (GlobalVar.seriesMap["S1"].model) as S1DeviceSettingModel;
    maholesdepth.text = _s1DeviceSettingModel.manholedepth.toString();
    crticallevelabove.text = _s1DeviceSettingModel.criticallevelabove.toString();
    informativelevelabove.text = _s1DeviceSettingModel.informativelevelabove.toString();
    normallevelabove.text = _s1DeviceSettingModel.nomrallevelabove.toString();
    groundlevelbelow.text = _s1DeviceSettingModel.groundlevelbelow.toString();
    tempthresholdvalue.text = _s1DeviceSettingModel.tempthresholdvalue.toString();
    batterythresholdvalue.text = _s1DeviceSettingModel.batterythresholdvalue.toString();
  }

  onAddPressed() async {
    if (double.parse(groundlevelbelow.text) <=
            double.parse(maholesdepth.text) &&
        (double.parse(normallevelabove.text) <=
            double.parse(groundlevelbelow.text)) &&
        (double.parse(informativelevelabove.text) <=
            double.parse(normallevelabove.text)) &&
        (double.parse(crticallevelabove.text) <=
            double.parse(informativelevelabove.text))) {
      try {
        String res = await _databaseCallServices.setDeviceSetting(
          HomePageVM.instance.getClientCode, 
          "S1",
          S1DeviceSettingModel(
            criticallevelabove: double.parse(crticallevelabove.text.toString()),
            informativelevelabove: double.parse(informativelevelabove.text.toString()),
            nomrallevelabove: double.parse(normallevelabove.text.toString()),
            groundlevelbelow: double.parse(groundlevelbelow.text.toString()),
            tempthresholdvalue: double.parse(tempthresholdvalue.text.toString()),
            batterythresholdvalue: int.parse(batterythresholdvalue.text.toString()),
            manholedepth: double.parse(maholesdepth.text.toString())
          ).toJson() 
        );
        print(res);
      
      } catch (e) {
        print(e);
      }
    }
  }
}
