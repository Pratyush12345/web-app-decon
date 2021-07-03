import 'package:Decon/Controller/ViewModels/Services/Android_wrapper/andr_user_Wrapper.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/ViewModels/Services/Web_Wrapper/web_user_Wrapper.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Android/series_S0/BottomLayout_S0.dart';
import 'package:Decon/View_Android/series_S0/DeviceSetting_S0.dart';
import 'package:Decon/View_Android/series_S1/BottomLayout_S1.dart';
import 'package:Decon/View_Android/series_S1/DeviceSetting_S1.dart';
import 'package:Decon/View_Web/series_S0/BottomLayout_S0.dart';
import 'package:Decon/View_Web/series_S0/DeviceSetting_S0.dart';
import 'package:Decon/View_Web/series_S1/BottomLayout_S1.dart';
import 'package:Decon/View_Web/series_S1/DeviceSetting_S1.dart';
import 'package:flutter/material.dart';
class OrientationWrapper extends StatelessWidget {
  const OrientationWrapper({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation){
        if(orientation == Orientation.landscape){
          if(Navigator.of(context).canPop()){
            Navigator.of(context).pop();
          }
          // GlobalVar.seriesMap = {
          //   "S0" : SeriesInfo(model: S0DeviceSettingModel() ,graphs: ["S0_levelSheet","S0_openManholeSheet"]  ,bottomLayout: BottomLayoutS0Web(), deviceSetting: DeviceSettingsS0Web() ),
          //   "S1" : SeriesInfo(model: S1DeviceSettingModel(),graphs: ["S1_levelSheet","S1_openManholeSheet", "S1_temperatureSheet"], bottomLayout: BottomLayoutS1Web(), deviceSetting: DeviceSettingsS1Web() )
          // };

          return WebUserWrapper();
        }
        else{
          if(Navigator.of(context).canPop()){
            Navigator.of(context).pop();
          }
          // GlobalVar.seriesMap = {
          //   "S0" : SeriesInfo(model: S0DeviceSettingModel() ,graphs: ["S0_levelSheet","S0_openManholeSheet"]  ,bottomLayout: BottomLayoutS0Andr(), deviceSetting: DeviceSettingsS0Andr() ),
          //   "S1" : SeriesInfo(model: S1DeviceSettingModel(),graphs: ["S1_levelSheet","S1_openManholeSheet", "S1_temperatureSheet"], bottomLayout: BottomLayoutS1Andr(), deviceSetting: DeviceSettingsS1Andr() )
          // };

          return AndrUserWrapper();
        }
      });
     
}
}