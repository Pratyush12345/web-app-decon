import 'dart:async';

import 'package:Decon/View_Android/series_S0/BottomLayout_S0.dart';
import 'package:Decon/View_Android/series_S0/BottomLayout_S0_no_ground.dart';
import 'package:Decon/View_Android/series_S0/DeviceSetting_S0.dart';
import 'package:Decon/View_Android/series_S1/BottomLayout_S1.dart';
import 'package:Decon/View_Android/series_S1/DeviceSetting_S1.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Web/series_S0/BottomLayout_S0.dart';
import 'package:Decon/View_Web/series_S0/BottomLayout_S0_no_ground.dart';
import 'package:Decon/View_Web/series_S0/DeviceSetting_S0.dart';
import 'package:Decon/View_Web/series_S1/BottomLayout_S1.dart';
import 'package:Decon/View_Web/series_S1/DeviceSetting_S1.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GlobalVar {
  static bool isActive = true; 
  static bool isclientchanged  = true;
  static String strAccessLevel;
  static bool isDeviceChanged = false;
  static int thresholdClientId = 6;
  static UserDetailModel userDetail;
  static Map<String, SeriesInfo > seriesMap = {
    "S0" : SeriesInfo(model: S0DeviceSettingModel() ,graphs: ["S0_LevelGraph","S0_ManholeGraph"]  ,bottomLayout: BottomLayoutS0Web(), deviceSetting: DeviceSettingsS0Web() ),
    "S1" : SeriesInfo(model: S1DeviceSettingModel(),graphs: ["S1_LevelGraph","S1_ManholeGraph", "S1_TemperatureGraph"], bottomLayout: BottomLayoutS1Web(), deviceSetting: DeviceSettingsS1Web() )
  };
 static Map<String, SeriesInfo > seriesMapNoGround = {
    "S0" : SeriesInfo(model: S0DeviceSettingModel() ,graphs: ["S0_LevelGraph", "S0_ManholeGraph"]  ,bottomLayout: BottomLayoutS0NoGroundWeb(), deviceSetting: DeviceSettingsS0Web() ),
    "S1" : SeriesInfo(model: S1DeviceSettingModel(),graphs: ["S1_LevelGraph", "S1_ManholeGraph", "S1_TemperatureGraph"], bottomLayout: BottomLayoutS1Web(), deviceSetting: DeviceSettingsS1Web() )
  };


  

 static Map<String, SeriesInfo > seriesMapWebNoGround = {
    "S0" : SeriesInfo(model: S0DeviceSettingModel() ,graphs: ["S0_LevelGraph", "S0_ManholeGraph"]  ,bottomLayout: BottomLayoutS0NoGroundWeb(), deviceSetting: DeviceSettingsS0Web() ),
    "S1" : SeriesInfo(model: S1DeviceSettingModel(),graphs: ["S1_LevelGraph", "S1_ManholeGraph", "S1_TemperatureGraph"], bottomLayout: BottomLayoutS1Web(), deviceSetting: DeviceSettingsS1Web() )
  };

  static Map<String, SeriesInfo > seriesMapWeb = {
    "S0" : SeriesInfo(model: S0DeviceSettingModel() ,graphs: ["S0_LevelGraph","S0_ManholeGraph"]  ,bottomLayout: BottomLayoutS0Web(), deviceSetting: DeviceSettingsS0Web() ),
    "S1" : SeriesInfo(model: S1DeviceSettingModel(),graphs: ["S1_LevelGraph","S1_ManholeGraph", "S1_TemperatureGraph"], bottomLayout: BottomLayoutS1Web(), deviceSetting: DeviceSettingsS1Web() )
  };

  static Map<String, SeriesInfo > seriesMapAndr = {
    "S0" : SeriesInfo(model: S0DeviceSettingModel() ,graphs: ["S0_LevelGraph","S0_ManholeGraph"]  ,bottomLayout: BottomLayoutS0Andr(), deviceSetting: DeviceSettingsS0Andr() ),
    "S1" : SeriesInfo(model: S1DeviceSettingModel(),graphs: ["S1_LevelGraph","S1_ManholeGraph", "S1_TemperatureGraph"], bottomLayout: BottomLayoutS1Andr(), deviceSetting: DeviceSettingsS1Andr() )
  };

  static Map<String, SeriesInfo > seriesMapAndrNoGround = {
    "S0" : SeriesInfo(model: S0DeviceSettingModel() ,graphs: ["S0_LevelGraph","S0_ManholeGraph"]  ,bottomLayout: BottomLayoutS0AndrNoGround(), deviceSetting: DeviceSettingsS0Andr() ),
    "S1" : SeriesInfo(model: S1DeviceSettingModel(),graphs: ["S1_LevelGraph","S1_ManholeGraph", "S1_TemperatureGraph"], bottomLayout: BottomLayoutS1Andr(), deviceSetting: DeviceSettingsS1Andr() )
  };

  static Completer<GoogleMapController> gcontroller = Completer();
  
}