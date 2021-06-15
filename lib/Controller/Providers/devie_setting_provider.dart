import 'package:Decon/View_Android/series_S0/device_setting_viewmodel_S0.dart';
import 'package:Decon/View_Android/series_S1/device_setting_viewmodel_S1.dart';
import 'package:flutter/cupertino.dart';

class ChangeDeviceSeting extends ChangeNotifier{

  
  changeDeviceSetting(String seriesCode){
  
    if(seriesCode == "S0"){
    DeviceSettingS0VM.instance.loadFromModel();
    }
    else if(seriesCode == "S1"){
    DeviceSettingS1VM.instance.loadFromModel();
    }
    notifyListeners();
  }

}