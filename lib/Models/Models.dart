import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
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

  DeviceSettingModel(
      this.manholedepth,
      this.criticallevelabove,
      this.informativelevelabove,
      this.nomrallevelabove,
      this.groundlevelbelow,
      this.tempthresholdvalue,
      this.batterythresholdvalue);

  DeviceSettingModel.fromSnapshot(DataSnapshot snapshot)
      : manholedepth = snapshot.value["manHoleDepth"],
        criticallevelabove = snapshot.value["criticalLevelAbove"],
        informativelevelabove = snapshot.value["informativeLevelAbove"],
        nomrallevelabove = snapshot.value["nomralLevelAbove"],
        groundlevelbelow = snapshot.value["groundLevelBelow"],
        tempthresholdvalue = snapshot.value["tempThresholdValue"],
        batterythresholdvalue = snapshot.value["batteryThresholdValue"];

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
}

class FeedbackForm {
  String date;
  String value;

  FeedbackForm(
    this.date,
    this.value,
  );

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm("${json['key']}", "${json['value']}");
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
  String openManhole;
  String address;
  dynamic temperature;

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
      @required this.temperature});

  DeviceData.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.value["id"];
    latitude = snapshot.value["latitude"];
    longitude = snapshot.value["longitude"];
    battery = snapshot.value["battery"];
    distance = snapshot.value["distance"];
    if (distance >= Auth.instance.groundlevelbelow)
      wlevel = 0;
    else if (distance >= Auth.instance.informativelevelabove &&
        distance < Auth.instance.normalLevelabove)
      wlevel = 1;
    else if (distance >= Auth.instance.criticalLevelAbove &&
        distance < Auth.instance.informativelevelabove)
      wlevel = 2;
    else if (distance < Auth.instance.criticalLevelAbove) wlevel = 3;
    status = snapshot.value["simStatus"] ?? 1;
    openManhole = snapshot.value["openManhole"];
    temperature = snapshot.value["temperature"];
    address = snapshot.value["address"] ?? "Empty";
  }

  toJson() {
    return {
      "id": id,
      "battery": battery,
      "latitude": latitude,
      "longitude": longitude,
      "wLevel": wlevel,
      "distance": distance,
      "simStatus": status,
      "openManhole": openManhole,
      "address": address,
      "temperature": temperature
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
    url = snapshot.value["url"];
    selfid = snapshot.value["selfId"];
    time = snapshot.value["time"];
    type = snapshot.value["type"];
    caption = snapshot.value["caption"];
    cityCode = snapshot.value["cityCode"];
    location = snapshot.value["location"];
    resolveid = snapshot.value["resolveid"];
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

  UserDetailModel({this.key,this.clientsVisible, this.name, this.phoneNo, this.post, this.delegate});

  UserDetailModel.fromJson( String uid, Map<dynamic, dynamic> json) {
    clientsVisible = json['clientsVisibile']??json['clientsVisible'];
    name = json['name'];
    phoneNo = json['phoneNo'];
    post = json['post'].toString().split("@")[0];
    delegate = json['post'].toString().split("@")[1];
    key = uid;
    isSelected = false;
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

  ClientDetailModel(
      {this.clientName,
      this.departmentName,
      this.cityName,
      this.districtName,
      this.stateName,
      this.selectedSeries,
      this.selectedManager,
      this.selectedAdmin});

  ClientDetailModel.fromJson(Map<dynamic, dynamic> json) {
    print("json================$json");
    clientName = json['clientName'];
    departmentName = json['departmentName'];
    cityName = json['cityName'];
    districtName = json['districtName'];
    stateName = json['stateName'];
    selectedSeries = json['selectedSeries'];
    selectedManager = json['selectedManager'];
    selectedAdmin = json['selectedAdmin'];
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