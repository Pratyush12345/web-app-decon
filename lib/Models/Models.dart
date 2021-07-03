import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/View_Web/clients/edit_clients.dart';
import 'package:Decon/View_Web/series_S1/DeviceSetting_S1.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/cupertino.dart';

class S1DeviceSettingModel {
  final double manholedepth;
  final double criticallevelabove;
  final double informativelevelabove;
  final double nomrallevelabove;
  final double groundlevelbelow;
  final double tempthresholdvalue;
  final int batterythresholdvalue;

  S1DeviceSettingModel({
      this.manholedepth,
      this.criticallevelabove,
      this.informativelevelabove,
      this.nomrallevelabove,
      this.groundlevelbelow,
      this.tempthresholdvalue,
      this.batterythresholdvalue});

  S1DeviceSettingModel.fromSnapshot(DataSnapshot snapshot)
      : manholedepth = double.parse(snapshot.val()["manHoleDepth"].toString()),
        criticallevelabove = double.parse(snapshot.val()["criticalLevelAbove"].toString()),
        informativelevelabove = double.parse(snapshot.val()["informativeLevelAbove"].toString()),
        nomrallevelabove =  double.parse(snapshot.val()["nomralLevelAbove"].toString()),
        groundlevelbelow = double.parse(snapshot.val()["groundLevelBelow"].toString()),
        tempthresholdvalue = double.parse(snapshot.val()["tempThresholdValue"].toString()),
        batterythresholdvalue = int.parse(snapshot.val()["batteryThresholdValue"].toString());

  toJson() {
    return {
      "manHoleDepth": manholedepth,
      "criticalLevelAbove": criticallevelabove,
      "informativeLevelAbove": informativelevelabove,
      "nomralLevelAbove": nomrallevelabove,
      "groundLevelBelow": groundlevelbelow,
      "tempThresholdValue": tempthresholdvalue,
      "batteryThresholdValue": batterythresholdvalue
    };
  }

  toDefaultJson() {
    return <String, dynamic>{
      "manHoleDepth": 75.5,
      "criticalLevelAbove": 60.5  ,
      "informativeLevelAbove": 40.5,
      "nomralLevelAbove": 20.5,
      "groundLevelBelow": 10.5,
      "tempThresholdValue": 55.2,
      "batteryThresholdValue": 80
    };
  }
}

class S0DeviceSettingModel {
  final double manholedepth;
  final int batterythresholdvalue;

  S0DeviceSettingModel({
      this.manholedepth,
      this.batterythresholdvalue});

  S0DeviceSettingModel.fromSnapshot(DataSnapshot snapshot)
      : manholedepth = double.parse(snapshot.val()["manHoleDepth"].toString()),
        batterythresholdvalue = int.parse(snapshot.val()["batteryThresholdValue"].toString());

  toJson() {
    return {
      "manHoleDepth": manholedepth,
      "batteryThresholdValue": batterythresholdvalue
    };
  }

  toDefaultJson() {
    return <String, dynamic> {
      "manHoleDepth": 75.5,
      "batteryThresholdValue": 80
    };
  }
}

class DataFromSheet {
  String date;
  String value;

  DataFromSheet(
    this.date,
    this.value,
  );

  factory DataFromSheet.fromJson(dynamic json) {
    return DataFromSheet("${json['key']}", "${json['value']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'date': date,
        'level': value,
      };
}

class DeviceData {
  int battery;
  double latitude;
  double longitude;
  int wlevel;
  dynamic distance;
  String id;
  int status;
  String address;
  dynamic temperature;
  int openManhole;
  int signalStrength;
  int lightIntensity;
  String lastUpdated;


  DeviceData(
      {
      @required this.id,
      @required this.battery,
      @required this.latitude,
      @required this.longitude,
      this.distance,
      this.wlevel,
      @required this.status,
      @required this.openManhole,
      @required this.address,
      @required this.lastUpdated,
      this.temperature,
      this.lightIntensity,
      this.signalStrength});

  DeviceData.fromSnapshot(DataSnapshot snapshot, String _seriesCode) {
    id = snapshot.val()["id"];
    latitude = snapshot.val()["latitude"];
    longitude = snapshot.val()["longitude"];
    battery = snapshot.val()["battery"];
    distance = snapshot.val()["distance"];
    if(_seriesCode == "S0"){
      wlevel = snapshot.val()["wLevel"];
    }
    else if(_seriesCode == "S1"){
      S1DeviceSettingModel _s1DeviceSettingModel = (GlobalVar.seriesMap["S1"].model as S1DeviceSettingModel);
      if (distance >= _s1DeviceSettingModel.groundlevelbelow)
      wlevel = 0;
      else if (distance >= _s1DeviceSettingModel.informativelevelabove &&
      distance < _s1DeviceSettingModel.nomrallevelabove)
      wlevel = 1;
      else if (distance >= _s1DeviceSettingModel.criticallevelabove &&
      distance < _s1DeviceSettingModel.informativelevelabove)
      wlevel = 2;
      else if (distance < _s1DeviceSettingModel.criticallevelabove) 
      wlevel = 3;
    }
    status = snapshot.val()["simStatus"] ?? 1;
    openManhole = snapshot.val()["openManhole"];
    temperature = snapshot.val()["temperature"];
    lastUpdated = snapshot.val()["lastUpdated"];
    address = snapshot.val()["address"] ?? "Empty";
    signalStrength = snapshot.val()["signalStrength"];
    lightIntensity = snapshot.val()["lightIntensity"];
  }
DeviceData.fromJson(Map<dynamic, dynamic> json, String _seriesCode) {
    id = json["id"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    battery = json["battery"];
    distance = json["distance"];
    if(_seriesCode == "S0"){
      wlevel = json["wLevel"];
    }
    else if(_seriesCode == "S1"){
      S1DeviceSettingModel _s1DeviceSettingModel = (GlobalVar.seriesMap["S1"].model as S1DeviceSettingModel);
      if (distance >= _s1DeviceSettingModel.groundlevelbelow)
      wlevel = 0;
      else if (distance >= _s1DeviceSettingModel.informativelevelabove &&
      distance < _s1DeviceSettingModel.nomrallevelabove)
      wlevel = 1;
      else if (distance >= _s1DeviceSettingModel.criticallevelabove &&
      distance < _s1DeviceSettingModel.informativelevelabove)
      wlevel = 2;
      else if (distance < _s1DeviceSettingModel.criticallevelabove) wlevel = 3;
    }
    status = json["simStatus"] ?? 1;
    openManhole = json["openManhole"];
    temperature = json["temperature"];
    lastUpdated = json["lastUpdated"];
    address = json["address"] ?? "Empty";
    signalStrength = json["signalStrength"];
    lightIntensity = json["lightIntensity"];
  }

  toS1Json() {
    return <String, dynamic>{
      "id": id,
      "battery": battery,
      "latitude": latitude,
      "longitude": longitude,
      "distance": distance,
      "simStatus": status,
      "openManhole": openManhole,
      "address": address,
      "temperature": temperature,
      "signalStrength" : signalStrength,
      "lightIntensity" : lightIntensity,
      "lastUpdated" : lastUpdated
    };
  }
  toS0Json() {
    return <String, dynamic>{
      "id": id,
      "battery": battery,
      "latitude": latitude,
      "longitude": longitude,
      "wLevel": wlevel,
      "simStatus": status,
      "openManhole": openManhole,
      "address": address,
      "signalStrength" : signalStrength,
      "lightIntensity" : lightIntensity,
      "lastUpdated" : lastUpdated
    };
  }
}

class DelegateModel {
  String uid;
  String name;
  String post;
  String numb;
  String stateName;
  String cityName;
  String cityCode;
  Map rangeOfDeviceEx;
  DelegateModel(
      {this.name,
      this.cityName,
      this.cityCode,
      this.post,
      this.numb,
      this.uid,
      this.stateName,
      this.rangeOfDeviceEx});
  DelegateModel.fromJsonForAdmin(Map snapshot) {
    snapshot?.forEach((key, value) {
      uid = key;
      cityCode = value["cityCode"];
      name = value["name"];
      post = value["post"];
      numb = value["phoneNo"];
      stateName = value["stateName"];
      cityName = value["cityName"];
      Map _map = {};
      String rangeofDevices = value["rangeOfDeviceEx"];
      if (rangeofDevices != "None" && rangeOfDeviceEx != null)
        rangeofDevices
            .replaceAll("{", "")
            .replaceAll("}", "")
            .split(",")
            .forEach((element) {
          String key = element.split(":")[0];
          String val = element.split(":")[1];
          _map[key] = val;
        });
      rangeOfDeviceEx = _map;
    });
  }
}

class Messages {
  String key;
  String url;
  String selfid;
  String time;
  String type;
  String resolveid;
  String caption;
  String cityCode;
  String location;
  Messages(this.key, this.url, this.selfid, this.time, this.type, this.caption,
      this.cityCode, this.location, this.resolveid);

  Messages.fromSnapshot(DataSnapshot snapshot) {
    key = snapshot.key;
    url = snapshot.val()["url"];
    selfid = snapshot.val()["selfId"];
    time = snapshot.val()["time"];
    type = snapshot.val()["type"];
    caption = snapshot.val()["caption"];
    cityCode = snapshot.val()["cityCode"];
    location = snapshot.val()["location"];
    resolveid = snapshot.val()["resolveid"];
  }
}
class Item {
  Text title;
  Icon icon;
  Widget screen;
  Item({this.title, this.icon, this.screen});
}


class UserDetailModel {
  String clientsVisible;
  String name;
  String phoneNo;
  String post;
  String delegate;
  bool isSelected;
  String key;
  String headUid;

  UserDetailModel({this.key,this.clientsVisible, this.name, this.phoneNo, this.post, this.delegate});

  UserDetailModel.fromJson( String uid, Map<dynamic, dynamic> json) {
    clientsVisible = json['clientsVisibile']??json['clientsVisible'];
    name = json['name'];
    phoneNo = json['phoneNo'];
    post = json['post'].toString().split("@")[0];
    delegate = json['post'].toString().split("@")[1];
    key = uid;
    isSelected = false;
    headUid = json['headUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientsVisible'] = this.clientsVisible;
    data['name'] = this.name;
    data['phoneNo'] = this.phoneNo;
    data['post'] = this.post;
    return data;
  }
}


class ClientDetailModel {
  String clientName;
  String departmentName;
  String cityName;
  String districtName;
  String stateName;
  String selectedSeries;
  String selectedManager;
  String selectedAdmin;
  String sheetURL;

  ClientDetailModel(
      {this.clientName,
      this.departmentName,
      this.cityName,
      this.districtName,
      this.stateName,
      this.selectedSeries,
      this.selectedManager,
      this.selectedAdmin,
      this.sheetURL});

  ClientDetailModel.fromJson(Map<dynamic, dynamic> json) {
    clientName = json['clientName'];
    departmentName = json['departmentName'];
    cityName = json['cityName'];
    districtName = json['districtName'];
    stateName = json['stateName'];
    selectedSeries = json['selectedSeries'];
    selectedManager = json['selectedManager'];
    selectedAdmin = json['selectedAdmin'];
    sheetURL = json['sheetURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientName'] = this.clientName;
    data['departmentName'] = this.departmentName;
    data['cityName'] = this.cityName;
    data['districtName'] = this.districtName;
    data['stateName'] = this.stateName;
    data['selectedSeries'] = this.selectedSeries;
    data['selectedManager'] = this.selectedManager;
    data['selectedAdmin'] = this.selectedAdmin;
    data['sheetURL'] = this.sheetURL;
    return data;
  }
}


class ClientListModel {
  String clientCode;
  String clientName;
  ClientListModel({this.clientCode, this.clientName});
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[this.clientCode] = this.clientName;
    return data;
  }
}


class SeriesInfo {
  Object model;
  final List<String> graphs;
  final Widget bottomLayout;
  final Widget deviceSetting;
  SeriesInfo({@required this.model,@required this.graphs, @required this.bottomLayout, @required this.deviceSetting});
}


class LinearData {
  int yearval;
  int levelval;
  LinearData(this.yearval, this.levelval);
}

class TempData {
  int yearval;
  double temp;
  TempData(this.yearval, this.temp);
}

class ManHoleData {
  int yearval;
  int condn;
  ManHoleData(this.yearval, this.condn);
}
