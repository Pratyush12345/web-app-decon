import 'package:Decon/Controller/ViewModels/device_setting_viewmodel.dart';
import 'package:Decon/Models/Models.dart';
import 'package:flutter/cupertino.dart';

class ChangeDeviceSeting extends ChangeNotifier{

  changeDeviceSetting(){
    DeviceSettingVM.instance.loadFromDatabase();
    notifyListeners();
  }

}