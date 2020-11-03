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
                  latitude: position.latitude,
                  longitude: position.longitude,
                  status: 1,
                  distance: Auth.instance.manholedepth,
                  openManhole: "No Data",
                  address: address,
                  temperature: 0.0

                 ).toJson());
                 Navigator.of(context).pop();

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
              children: [
                Container(
                  color: Colors.white,
                  child: TextField(
                        
                        controller: _deviceIdText,
                        
                                style: TextStyle(fontSize: SizeConfig.b * 4.3,color: Colors.white ),
                                decoration: InputDecoration(
                                  
                            isDense: true,
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            hintText: "Enter Device Id",
                            border: OutlineInputBorder(
                                
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                ),
                SizedBox(height: 20.0,),
                !_addDeviceManually? RaisedButton(
                  child: widget.isUpdating? Text("Add This Device") : Text("Add Location of this device"),
                  onPressed:()async {
                   position = await getCurrentLocation();
                   await _updatedatabase(position.latitude,position.longitude);
                               } 
                ):
                Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "First Name cannot be empty";
                        }
                        return null;
                      },
                      controller: _latitudeText,
                      style: TextStyle(fontSize: 14.0, color: Color(0xFF868A8F)),
                      decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          hintText: "Enter Latitude",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(color: Colors.grey))),
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "First Name cannot be empty";
                        }
                        return null;
                      },
                      controller: _longitudeText,
                      style: TextStyle(fontSize: 14.0, color: Color(0xFF868A8F)),
                      decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          hintText: "Enter Longitude",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(color: Colors.grey))),
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
                await _updatedatabase(double.parse(_latitudeText.text), double.parse(_longitudeText.text));
                }
                },
                child: Text("Add Device Manually"),
                )
              ],
            ),
          ) ,
        ),
    );
    
  }
}