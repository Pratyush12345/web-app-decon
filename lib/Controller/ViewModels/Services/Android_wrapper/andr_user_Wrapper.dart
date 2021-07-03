import 'package:Decon/Controller/ViewModels/Services/Android_wrapper/andr_future_Wrapper.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Android/Authentication/Phoneverif.dart';
import 'package:Decon/View_Android/Authentication/login_screen.dart';
import 'package:Decon/View_Android/series_S1/DeviceSetting_S1.dart';
import 'package:Decon/View_Android/series_S0/BottomLayout_S0.dart';
import 'package:Decon/View_Android/series_S0/DeviceSetting_S0.dart';
import 'package:Decon/View_Android/series_S1/BottomLayout_S1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AndrUserWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
  final user= Provider.of<User>(context);
  // GlobalVar.seriesMap = {
  //             "S0" : SeriesInfo(model: S0DeviceSettingModel() ,graphs: ["S0_levelSheet","S0_openManholeSheet"]  ,bottomLayout: BottomLayoutS0(), deviceSetting: DeviceSettingsS0() ),
  //             "S1" : SeriesInfo(model: S1DeviceSettingModel(),graphs: ["S1_levelSheet","S1_openManholeSheet", "S1_temperatureSheet"], bottomLayout: BottomLayoutS1(), deviceSetting: DeviceSettingsS1() )
  //           };
          
  if(user==null){
  
   return Login();
  } 
  else{
  if(Navigator.of(context).canPop()){
    Navigator.of(context).pop();
  }
  return AndrFutureWrapper();

  }

  }
}