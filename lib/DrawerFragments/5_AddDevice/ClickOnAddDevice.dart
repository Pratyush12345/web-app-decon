

import 'package:Decon/Models/AddressCaluclator.dart';

import 'package:Decon/Models/Models.dart';
import 'package:Decon/Services/Auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double b;
  static double v;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    b = screenWidth / 100;
    v = screenHeight / 100;
  }
}

class ClickOnAddDevice extends StatefulWidget {
  final bool isUpdating;
  final String deviceid;
  ClickOnAddDevice({@required this.isUpdating , this.deviceid});
  @override
  _ClickOnAddDeviceState createState() => _ClickOnAddDeviceState();
}

class _ClickOnAddDeviceState extends State<ClickOnAddDevice> {
  final _deviceIdText = TextEditingController();
  final _latitudeText = TextEditingController();
  final _longitudeText = TextEditingController();
  Position position;
  bool _addDeviceManually = false;

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }
  _updatedatabase(double latitude, double longitude) async{
               String cityCode = _deviceIdText.text.split("_")[0];
               String seriescode = _deviceIdText.text.split("_")[1];
               String deviceCode = _deviceIdText.text.split("_")[2];
               String address = await AddressCalculator(latitude,longitude).getLocation();
               await FirebaseDatabase.instance.reference().child("cities/$cityCode/Series/$seriescode/Devices/$deviceCode")
               .update(
                 DeviceData(
                  id:_deviceIdText.text,
                  battery: 100,
                  latitude: latitude,
                  longitude: longitude,
                  status: 1,
                  distance: 3.9,
                  openManhole: "No Data",
                  address: address,
                  temperature: 50.2

                 ).toJson());
                 
  }
  @override
  void initState() {
    if(widget.isUpdating){
      _deviceIdText.text = widget.deviceid;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Card(
          margin: EdgeInsets.fromLTRB(
                    SizeConfig.screenWidth * 0.05,
                    SizeConfig.screenHeight * 0.2,
                    SizeConfig.screenWidth * 0.05,
                    SizeConfig.screenHeight * 0.21),
                elevation: 5,
                color: Color(0xff263238),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeConfig.b * 2.25),
                ),
            
          child: Container(
            padding: EdgeInsets.fromLTRB(SizeConfig.b * 2.5,
                      SizeConfig.v * 0.5, SizeConfig.b * 2.5, SizeConfig.v * 3),
                  
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                            color: Colors.white,
                      
                            borderRadius:
                                BorderRadius.circular(12.0)),
                      width: SizeConfig.b * 80,
                      child: TextField( 
                        cursorColor: Color(0xFF868A8F),
                        controller: _deviceIdText,
                        
                                style: TextStyle(fontSize: SizeConfig.b * 4.3,color: Color(0xFF868A8F) ),
                                decoration: InputDecoration(
                            border: InputBorder.none,      
                            isDense: true,
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            hintText: "Enter Device Id",
                            ),
                      ),
                ),
                SizedBox(height: 20.0,),
                !_addDeviceManually? RaisedButton(
                  shape: RoundedRectangleBorder(
                            
                            borderRadius: BorderRadius.circular(24.0),
                            side: BorderSide(color: Colors.blue)
                          ),
                  textColor: Colors.white,
                          elevation: 7.0,
                          color: Colors.blue,
                  child: Text("Add Location of this Device"),
                  onPressed:()async {
                   position = await getCurrentLocation();
                   await _updatedatabase(position.latitude,position.longitude);
                   Navigator.of(context).pop();  
                   } 
                ):
                Column(
                  children: [
                    Container(
                      
                      decoration: BoxDecoration(
                            color: Colors.white,
                      
                            borderRadius:
                                BorderRadius.circular(12.0)),
                      width: SizeConfig.b * 80,
                      height: 40.0 ,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "cannot be empty";
                          }
                          return null;
                        },
                        controller: _latitudeText,
                        cursorColor: Color(0xFF868A8F),
                        style: TextStyle(fontSize: SizeConfig.b * 4.3, color: Color(0xFF868A8F)),
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            hintText: "Enter Latitude",
                            border: InputBorder.none 
                            ),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      decoration: BoxDecoration(
                            color: Colors.white,
                      
                            borderRadius:
                                BorderRadius.circular(12.0)),
                      width: SizeConfig.b * 80,
                      height: 40.0,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "cannot be empty";
                          }
                          return null;
                        },
                        controller: _longitudeText,
                        cursorColor: Color(0xFF868A8F),
                        style: TextStyle(fontSize: SizeConfig.b * 4.3, color: Color(0xFF868A8F)),
                        decoration: InputDecoration(
                           isDense: true,
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            hintText: "Enter Longitude",
                            border: InputBorder.none  
                            )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                RaisedButton(onPressed: ()async{
                if(!_addDeviceManually)
                setState(() {
                   _addDeviceManually = true;
                }); 
                else{
            
                  print(_latitudeText.text);
                  print(_longitudeText.text);
                  double latitude = double.parse(_latitudeText.text);
                  double longitude = double.parse(_longitudeText.text);
                //await _updatedatabase(double.parse(_latitudeText.text), double.parse(_longitudeText.text));
                String cityCode = _deviceIdText.text.split("_")[0];
               String seriescode = _deviceIdText.text.split("_")[1];
               String deviceCode = _deviceIdText.text.split("_")[2];
               print(cityCode);
               print(seriescode);
               print(deviceCode);
               String address = await AddressCalculator(latitude,longitude).getLocation();
               await FirebaseDatabase.instance.reference().child("cities/$cityCode/Series/$seriescode/Devices/$deviceCode")
               .update(
                 DeviceData(
                  id:_deviceIdText.text,
                  battery: 100,
                  latitude: latitude,
                  longitude: longitude,
                  status: 1,
                  distance: 3.9,
                  openManhole: "No Data",
                  address: address,
                  temperature: 50.5

                 ).toJson());
                 Navigator.of(context).pop();

                }
                },
                shape: RoundedRectangleBorder(
                            
                            borderRadius: BorderRadius.circular(24.0),
                            side: BorderSide(color: Colors.blue)
                          ),
                child: Text("Add Device Manually"),
                textColor: Colors.white,
                          elevation: 7.0,
                          color: Colors.blue
                )
              ],
            ),
          ) ,
        ),
    );
    
  }
}