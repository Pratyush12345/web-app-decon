
import 'package:Decon/DrawerFragments/5_AddDevice/ClickOnAddDevice.dart';

import 'package:Decon/Models/Models.dart';
import 'package:Decon/Services/Auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
class AddDevice extends StatefulWidget {
  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  Future showDelegatesDialog({BuildContext context, bool isUpdating, deviceId}) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return ClickOnAddDevice(isUpdating: isUpdating, deviceid: deviceId,);
        });
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff0099FF),                        
        onPressed: (){
         showDelegatesDialog(context: context, isUpdating: false);
        },
        child: Icon(Icons.add),
        ),
      body: StreamBuilder<Event>( 
        stream: FirebaseDatabase.instance.reference().child("cities/C1/Series/S1/Devices").onValue ,
        builder:(BuildContext context, snapshot){
          if(snapshot.hasData){
                  List<DeviceData> _listofDevices = List();
                  int _wlevel;double _distance;
                  snapshot.data.snapshot?.value?.forEach((key, value){
                    _distance = value["distance"]; 
                    if(_distance>=Auth.instance.groundlevelabove)
                      _wlevel = 0;
                      else if(_distance>=Auth.instance.informativelevelabove && _distance< Auth.instance.normalLevelabove)
                      _wlevel = 1;
                      else if(_distance>=Auth.instance.criticalLevelAbove && _distance< Auth.instance.informativelevelabove)
                      _wlevel = 2;
                      else if(_distance<Auth.instance.criticalLevelAbove)
                      _wlevel = 3;
                    _listofDevices.add(DeviceData(
                      id: value["id"],battery: value["battery"], latitude: value["latitude"],
                      longitude: value["longitude"], status: value["simStatus"],
                      distance: _distance,
                      wlevel: _wlevel ,
                      openManhole: value["openManhole"],
                      address: value["address"]??"Empty",
                      temperature: value["temperature"]
                    ));
                    
                  });
                  _listofDevices.sort((a,b)=>int.parse(a.id.split("_")[2].substring(1,2) ).compareTo(int.parse(b.id.split("_")[2].substring(1,2))));
    
                  return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,    
                itemCount: _listofDevices.length,
                itemBuilder: (context, index) {
                  return 
                  InkWell(
                        onTap: () {
                        showDelegatesDialog(context: context, isUpdating: true, deviceId:_listofDevices[index].id  );
                        
                      },
                        child: Column(children: [
                        Row(children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(
                                  SizeConfig.b * 3.6,
                                  SizeConfig.v * 0.8,
                                  SizeConfig.b * 2.6,
                                  SizeConfig.v * 0.8),
                              width: SizeConfig.b * 68.7,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${_listofDevices[index].id.split("_")[2].replaceAll("D","Device ")}",
                                        style: TextStyle(
                                            fontSize: SizeConfig.b * 5.09,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(height: SizeConfig.v * 1),
                                    
                                    SizedBox(height: SizeConfig.v * 1),
                                    Container(
                                        padding: EdgeInsets.fromLTRB(
                                            SizeConfig.b * 5.6, 0, 0, 0),
                                        child: Text(_listofDevices[index].address,
                                            style: TextStyle(
                                                fontSize: SizeConfig.b * 3.054,
                                                color: Color(0xff0099FF)))),
                                  ])),
                          Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.b * 1,
                                      vertical: SizeConfig.v * 0.6),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(SizeConfig.b * 2),
                                      color: Color(0xff0099FF)),
                                  child: Text(_listofDevices[index].id,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: SizeConfig.b * 3.57))),
                              
                            ],
                          ))
                        ]),
                        SizedBox(height: SizeConfig.v * 1),
                        Divider(color: Color(0xffCACACA), thickness: 1),
                      ]),
                  );
                });
                  }
                  else {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                }
        } )
    );
  }
}