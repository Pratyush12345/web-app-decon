import 'package:Decon/View_Android/series_S0/BottomLayout_S0.dart';
import 'package:Decon/View_Android/series_S0/DeviceSetting_S0.dart';
import 'package:Decon/View_Android/series_S1/BottomLayout_S1.dart';
import 'package:Decon/View_Android/series_S1/DeviceSetting_S1.dart';
import 'package:Decon/View_Web/series_S1/device_setting_viewmodel_S1.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Web/series_S0/BottomLayout_S0.dart';
import 'package:Decon/View_Web/series_S0/DeviceSetting_S0.dart';
import 'package:Decon/View_Web/series_S1/BottomLayout_S1.dart';
import 'package:Decon/View_Web/series_S1/DeviceSetting_S1.dart';


class GlobalVar {
  static bool isActive = true; 
  static bool isclientchanged  = true;
  static String strAccessLevel;
  static bool isDeviceChanged = false;
  static UserDetailModel userDetail;
  static Map<String, SeriesInfo > seriesMap = {
    "S0" : SeriesInfo(model: S0DeviceSettingModel() ,graphs: ["S0_levelSheet","S0_openManholeSheet"]  ,bottomLayout: BottomLayoutS0Web(), deviceSetting: DeviceSettingsS0Web() ),
    "S1" : SeriesInfo(model: S1DeviceSettingModel(),graphs: ["S1_levelSheet","S1_openManholeSheet", "S1_temperatureSheet"], bottomLayout: BottomLayoutS1Web(), deviceSetting: DeviceSettingsS1Web() )
  };

  static Map<String, SeriesInfo > seriesMapWeb = {
    "S0" : SeriesInfo(model: S0DeviceSettingModel() ,graphs: ["S0_levelSheet","S0_openManholeSheet"]  ,bottomLayout: BottomLayoutS0Web(), deviceSetting: DeviceSettingsS0Web() ),
    "S1" : SeriesInfo(model: S1DeviceSettingModel(),graphs: ["S1_levelSheet","S1_openManholeSheet", "S1_temperatureSheet"], bottomLayout: BottomLayoutS1Web(), deviceSetting: DeviceSettingsS1Web() )
  };

  static Map<String, SeriesInfo > seriesMapAndr = {
    "S0" : SeriesInfo(model: S0DeviceSettingModel() ,graphs: ["S0_levelSheet","S0_openManholeSheet"]  ,bottomLayout: BottomLayoutS0Andr(), deviceSetting: DeviceSettingsS0Andr() ),
    "S1" : SeriesInfo(model: S1DeviceSettingModel(),graphs: ["S1_levelSheet","S1_openManholeSheet", "S1_temperatureSheet"], bottomLayout: BottomLayoutS1Andr(), deviceSetting: DeviceSettingsS1Andr() )
  };
  
}