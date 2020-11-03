import 'package:Decon/Services/Auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class DeviceSettingModel {
  final String manholedepth;
  final String criticallevelabove;
  final String informativelevelabove;
  final String nomrallevelabove;
  final String groundlevelbelow;
  final String tempthresholdvalue;
  final String batterythresholdvalue;

  DeviceSettingModel(this.manholedepth, this.criticallevelabove, this.informativelevelabove, this.nomrallevelabove, this.groundlevelbelow, this.tempthresholdvalue, this.batterythresholdvalue);
  
  DeviceSettingModel.fromSnapshot(DataSnapshot snapshot):
  manholedepth = snapshot.value["manHoleDepth"],
  criticallevelabove = snapshot.value["criticalLevelAbove"],
  informativelevelabove = snapshot.value["informativeLevelAbove"],
  nomrallevelabove = snapshot.value["nomralLevelAbove"],
  groundlevelbelow = snapshot.value["groundLevelBelow"],
  tempthresholdvalue = snapshot.value["tempThresholdValue"],
  batterythresholdvalue = snapshot.value["batteryThresholdValue"];
 
  toJson(){
    return {
      "manHoleDepth": manholedepth,
      "criticalLevelAbove": criticallevelabove,
      "informativeLevelAbove": informativelevelabove,
      "nomralLevelAbove": nomrallevelabove,
      "groundLevelBelow": groundlevelbelow,
      "tempThresholdValue": tempthresholdvalue,
      "batteryThresholdValue":batterythresholdvalue
    };
  }


}



class DeviceData {
  int battery;
  double latitude;
  double longitude;
  int wlevel;
  double distance;
  String id;
  int status;
  String openManhole;
  String address;
  double temperature;

  DeviceData(
      {@required this.id,
      @required this.battery,
      @required this.latitude,
      @required this.longitude,
      @required this.distance,
       this.wlevel,
      @required this.status,
      @required this.openManhole,
      @required this.address,
      @required this.temperature
      });

  DeviceData.fromSnapshot(DataSnapshot snapshot){
        id = snapshot.value["id"];
        latitude = double.parse(snapshot.value["latitude"].toString());
        longitude = double.parse( snapshot.value["longitude"].toString());
        battery = snapshot.value["battery"];
        distance =  snapshot.value["distance"];
        if(distance>=Auth.instance.groundlevelabove)
        wlevel = 0;
        else if(distance>=Auth.instance.informativelevelabove && distance< Auth.instance.normalLevelabove)
        wlevel = 1;
        else if(distance>=Auth.instance.criticalLevelAbove && distance< Auth.instance.informativelevelabove)
        wlevel = 2;
        else if(distance<Auth.instance.criticalLevelAbove)
        wlevel = 3;
        status = snapshot.value["simStatus"];
        openManhole = snapshot.value["openManhole"];
        temperature = snapshot.value["temperature"];
        address = snapshot.value["address"]??"Empty";
  }

  toJson() {
    return {
      "id": id,
      "battery": battery,
      "latitude": latitude,
      "longitude": longitude,
      "wLevel": wlevel,
      "simStatus": status,
      "openManhole": openManhole,
      "address": address,
      "temperature" : temperature
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
      this.post,
      this.numb,
      this.uid,
      this.stateName,
      this.rangeOfDeviceEx});
  DelegateModel.fromJsonForAdmin(Map snapshot){
   snapshot.forEach((key, value) { 
   uid = key;
   name = value["name"];
   post = value["post"];
   numb = value["phoneNo"];
   stateName = value["stateName"];
   cityName = value["cityName"];
   cityCode = value["cityCode"];
   Map _map = {};
   String rangeofDevices = value["rangeOfDeviceEx"];
   if (rangeofDevices != "None")
   rangeofDevices.replaceAll("{", "").replaceAll("}", "")
   .split(",").forEach((element) {
      String key = element.split(":")[0];
      String val = element.split(":")[1];
      _map[key] = val;
   });
  rangeOfDeviceEx = _map;
   });
   
  }    
}
