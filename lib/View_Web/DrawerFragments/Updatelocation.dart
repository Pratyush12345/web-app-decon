import 'dart:js';

import 'package:Decon/Controller/Providers/deviceHoverProvider.dart';
import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/View_Web/Dialogs/LocationDialog.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';

 
class Updatelocation extends StatefulWidget {
  final BuildContext menuScreenContext;
  Updatelocation({Key key, this.menuScreenContext,})
      : super(key: key);

  @override
  _Updatelocation createState() => _Updatelocation();
}


class _Updatelocation extends State<Updatelocation> {
  List<DeviceData> _listDeviceData = [];
  DeviceData _deviceData;
  bool isDeviceSearched = false;
  int selectedIndex = -1;
  
  @override
  void initState() {
    super.initState();
  }

  Future showLocationDialog(BuildContext context, DeviceData device) {
    return showAnimatedDialog(
        context: context,
        animationType: DialogTransitionType.scaleRotate,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),
        builder: (context) {
          return LocationDialog(
            deviceId: device.id,
            initalAddress: device.address,
            initialLatitude: device.latitude,
            initialLongitude: device.longitude,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return Consumer<ChangeDeviceData>(
      builder: (context, changeList, child){
        if(!isDeviceSearched)
            _listDeviceData = List.from(changeList.allDeviceData);
            
      return Container(
        margin: EdgeInsets.only(left: b * 17, right: b * 32, bottom: h * 55),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(h * 10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 20,
              spreadRadius: 0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          sh(30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: b * 40),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Select device to update location",
                  style: txtS(blc, 14, FontWeight.w400),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: dc, width: 0.5),
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(b * 60),
                  ),
                  child: TextField(
                    onChanged: (val){
                      if(val.isNotEmpty){
                       _listDeviceData = changeList.allDeviceData.where((element) => element.id.split("_")[2].contains(val) || element.address.toLowerCase().contains(val) ).toList();
                       isDeviceSearched = true;
                      }else{
                        isDeviceSearched = false;
                       _listDeviceData = changeList.allDeviceData;
                      }
                      setState(() {});
                    },
                    
                    style: TextStyle(fontSize: b * 12, color: dc),
                    decoration: InputDecoration(
                      prefixIcon: InkWell(
                        child: Icon(Icons.search, color: blc),
                        onTap: null,
                      ),
                      isDense: true,
                      isCollapsed: true,
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 35, maxHeight: 30),
                      hintText: 'Search by Device/ ID/ location',
                      hintStyle: TextStyle(
                        fontSize: b * 12,
                        color: Color(0xff858585),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: h * 13, horizontal: b * 10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ]),
          ),
          sh(15),
          Expanded(
            flex: 4,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                padding:
                    EdgeInsets.symmetric(horizontal: b * 40, vertical: h * 13),
                itemCount: _listDeviceData.length ,
                itemBuilder: (BuildContext ctxt, int index) {
                  return InkWell(
                    onHover: (isHover){
                      Provider.of<DeviceHoverProvider>(context, listen: false).onDeivceHovered(isHover? index: -1);  
                    },
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        _deviceData = _listDeviceData[index];
                      });
                    },
                    child: Consumer<DeviceHoverProvider>(
                      builder: (context, model, child)=>
                       Container(
                        margin: EdgeInsets.only(bottom: h * 10),
                        decoration: BoxDecoration(
                          color: selectedIndex == index || model.hoveredIndex == index ? Color.fromRGBO(240, 240, 240, 1.0) : Colors.white,
                          border: Border.all(color: dc, width: 0.5),
                          borderRadius: BorderRadius.circular(h * 10),
                        ),
                        padding:
                            EdgeInsets.fromLTRB(b * 18, h * 11, b * 18, h * 11),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${_listDeviceData[index].id.split("_")[2].replaceAll("D", "Device ")}",
                                      style: txtS(dc, 16, FontWeight.w600),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(2),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: dc, width: 0.5),
                                        borderRadius: BorderRadius.circular(b * 2),
                                        color: Color(0xFFffffff),
                                      ),
                                      child: Text(
                                        'ID : ${_listDeviceData[index].id}',
                                        style: txtS(dc, 14, FontWeight.w400),
                                      ),
                                    ),
                                  ]),
                              sh(5),
                              Text(
                                'ID : ${_listDeviceData[index].address}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: txtS(Color(0xff858585), 14, FontWeight.w500),
                              ),
                            ]),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                if(selectedIndex != -1)
                showLocationDialog(context, _deviceData);
              },
              child: Container(
                margin: EdgeInsets.only(
                    bottom: h * 40, left: b * 170, right: b * 170, top: h * 32),
                decoration: BoxDecoration(
                  color: selectedIndex !=-1 ? blc : Colors.white,
                  border: Border.all(color: blc, width: 0.5),
                  borderRadius: BorderRadius.circular(h * 6),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Update Location",
                  style: txtS(selectedIndex!=-1 ? wc : blc, 18, FontWeight.w500),
                ),
              ),
            ),
          ),
        ]),
      );
      }
    );
      }
}
