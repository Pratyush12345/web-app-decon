import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/Models/Models.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DeviceSettingVM {
  static DeviceSettingVM instance = DeviceSettingVM._();
  DeviceSettingVM._();
  final maholesdepth = TextEditingController();
  final crticallevelabove = TextEditingController();
  final informativelevelabove = TextEditingController();
  final normallevelabove = TextEditingController();
  final groundlevelbelow = TextEditingController();
  final tempthresholdvalue = TextEditingController();
  final batterythresholdvalue = TextEditingController();

  loadFromDatabase() {
    maholesdepth.text = Auth.instance.manholedepth.toString();
    crticallevelabove.text = Auth.instance.criticalLevelAbove.toString();
    informativelevelabove.text = Auth.instance.informativelevelabove.toString();
    normallevelabove.text = Auth.instance.normalLevelabove.toString();
    groundlevelbelow.text = Auth.instance.groundlevelbelow.toString();
    tempthresholdvalue.text = Auth.instance.tempThresholdValue.toString();
    batterythresholdvalue.text = Auth.instance.batteryThresholdvalue.toString();
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
        await FirebaseDatabase.instance
            .reference()
            .child("cities/${HomePageVM.instance.getCityCode}/DeviceSettings")
            .update(DeviceSettingModel(
                    maholesdepth.text,
                    crticallevelabove.text,
                    informativelevelabove.text,
                    normallevelabove.text,
                    groundlevelbelow.text,
                    tempthresholdvalue.text,
                    batterythresholdvalue.text)
                .toJson());
      } catch (e) {
        print(e);
      }
    }
  }
}
