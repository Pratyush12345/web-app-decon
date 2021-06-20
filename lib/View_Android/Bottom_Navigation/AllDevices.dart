import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/View_Android/DrawerFragments/Statistics/Graphs.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';

import 'package:Decon/Models/Models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';


class AllDevices extends StatefulWidget {

  @override
  _AllDevicesState createState() => _AllDevicesState();
}


class _AllDevicesState extends State<AllDevices> {
  List<DeviceData> _filteredDeviceData = [];

  final _searchText = TextEditingController();
  final list = [
    "None",
    "Ground Level",
    "Normal Level",
    "Informative Level",
    "Critical Level",
    "Open Manholes",
    "High Temperature",
    "Insufficient Battery"
  ];
  String __itemSelected;
  final Map<int, String> levels = {
    0: "Ground level",
    1: "Normal Level",
    2: "Infromative Level",
    3: "Critical Level"
  };
  final Map<int, Color> _levelsColor = {
    0: Color(0xffC4C4C4),
    1: Color(0xff69D66D),
    2: Color(0xffE1E357),
    3: Color(0xffD93D3D)
  };
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Container(
      child: Consumer<ChangeDeviceData>(
          builder: (context, changeList, child){
            _filteredDeviceData =[];
            changeList.allDeviceData.forEach((element) {
            _filteredDeviceData.add(element);
            });
    
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.v * 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(SizeConfig.b * 1.5,
                    SizeConfig.v * 0.8, SizeConfig.b * 1.3, 0),
                height: SizeConfig.v * 5.5,
                width: SizeConfig.b * 63.61,
                decoration: BoxDecoration(
                    color: Color(0xffDEE0E0),
                    borderRadius: BorderRadius.circular(SizeConfig.b * 7.2)),
                child: TextField(
                  onChanged: (value) {
                    _filteredDeviceData.clear();
                    changeList.allDeviceData.forEach((element) {
                      _filteredDeviceData.add(element);
                    });
                    setState(() {
                      _filteredDeviceData.removeWhere((element) {
                        if (!element.address
                            .toLowerCase()
                            .contains(value.trim().toLowerCase())) {
                          if (!element.id
                              .toLowerCase()
                              .contains(value.trim().toLowerCase()))
                            return true;
                          else
                            return false;
                        }
                        return false;
                      });
                    });
                  },
                  controller: _searchText,
                  style: TextStyle(fontSize: SizeConfig.b * 4.3),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 25.0,
                    ),
                    isDense: true,
                    hintText: 'Search by Device/ ID/ location',
                    hintStyle: TextStyle(fontSize: SizeConfig.b * 3.2),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.b * 2),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(SizeConfig.b * 3.82, 0, 0, 0),
                height: SizeConfig.v * 5.5,
                width: SizeConfig.b * 28,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 222, 224, 224),
                    borderRadius: BorderRadius.circular(SizeConfig.b * 7.7)),
                child: DropdownButton<String>(
                  icon: Icon(Icons.arrow_drop_down_rounded),
                  dropdownColor: Color(0xff263238),
                  underline: SizedBox(
                    height: 0.0,
                  ),
                  elevation: 8,
                  items: list.map((dropDownStringitem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringitem,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(4.0, 4.0, 0.0, 2.0),
                        width: SizeConfig.b * 100,
                        height: SizeConfig.v * 5,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 222, 224, 224)
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          dropDownStringitem,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: SizeConfig.b * 3.2),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValueSelected) {
                    setState(() {
                      __itemSelected = newValueSelected;
                      _filteredDeviceData.clear();
                      for (var i = 0; i < changeList.allDeviceData.length; i++) {
                        if (__itemSelected == "None") {
                          _filteredDeviceData.add(changeList.allDeviceData[i]);
                        } else if (__itemSelected == "Ground Level") {
                          if (changeList.allDeviceData[i].wlevel == 0) {
                            _filteredDeviceData.add(changeList.allDeviceData[i]);
                          }
                        } else if (__itemSelected == "Normal Level") {
                          if (changeList.allDeviceData[i].wlevel == 1) {
                            _filteredDeviceData.add(changeList.allDeviceData[i]);
                          }
                        } else if (__itemSelected == "Informative Level") {
                          if (changeList.allDeviceData[i].wlevel == 2) {
                            _filteredDeviceData.add(changeList.allDeviceData[i]);
                          }
                        } else if (__itemSelected == "Critical Level") {
                          if (changeList.allDeviceData[i].wlevel == 3) {
                            _filteredDeviceData.add(changeList.allDeviceData[i]);
                          }
                        } else if (__itemSelected == "Open Manholes") {
                          if (changeList.allDeviceData[i].wlevel == 0) {
                            _filteredDeviceData.add(changeList.allDeviceData[i]);
                          }
                        } else if (__itemSelected == "High Temperature") {
                          if (changeList.allDeviceData[i].wlevel == 0) {
                            _filteredDeviceData.add(changeList.allDeviceData[i]);
                          }
                        } else if (__itemSelected == "Insufficient Battery") {
                          if (changeList.allDeviceData[i].battery <= 80) {
                            _filteredDeviceData.add(changeList.allDeviceData[i]);
                          }
                        }
                      }
                    });
                  },
                  isExpanded: true,
                  hint: Text(
                    "Filter",
                    style: TextStyle(fontSize: SizeConfig.b * 3.2),
                  ),
                  value: __itemSelected ?? null,
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.v * 1),
          Divider(color: Color(0xffCACACA), thickness: 1),
          Expanded(
              child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: ListView.builder(
                      padding:
                      EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 10),
                
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _filteredDeviceData.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return 
                        InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Graphs(
                                      scriptEditorURL: HomePageVM.instance.getScriptEditorURL,
                                      deviceData: _filteredDeviceData[index],
                                      sheetURL: HomePageVM.instance.getSheetURL,
                                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: h * 19),
        padding: EdgeInsets.only(
            top: h * 12, bottom: h * 20, left: b * 12, right: b * 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(b * 10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_filteredDeviceData[index].id.split("_")[2].replaceAll("D", "Device ")}",
                  style: txtS(dc, 18, FontWeight.w400),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: h * 2, horizontal: b * 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(b * 2),
                    color: dc,
                  ),
                  child: Text(
                    'ID : ${_filteredDeviceData[index].id}',
                    style: txtS(Colors.white, 12, FontWeight.w400),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: b * 6),
                      height: h * 12,
                      width: b * 12,
                      decoration: BoxDecoration(
                        color: _levelsColor[_filteredDeviceData[index].wlevel],
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      levels[_filteredDeviceData[index].wlevel],
                      style: txtS(_levelsColor[_filteredDeviceData[index].id], 12, FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            sh(18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(HomePageVM.instance.getSeriesCode == "S1")
                Row(children: [
                  SvgPicture.asset(
                    'images/distance.svg',
                    allowDrawingOutsideViewBox: true,
                  ),
                  SizedBox(width: b * 5),
                  Text(
                    "${_filteredDeviceData[index].distance??""}m",
                    style: txtS(blc, 14, FontWeight.w400),
                  ),
                ]),
                Row(children: [
                  Icon(Icons.battery_charging_full, size: b * 16, color: blc),
                  Text(
                    "${_filteredDeviceData[index].battery??""}%",
                    style: txtS(blc, 14, FontWeight.w400),
                  ),
                ]),
                if(HomePageVM.instance.getSeriesCode == "S1")
                Row(children: [
                  Icon(Icons.thermostat_sharp, size: b * 16, color: blc),
                  Text(
                    "${_filteredDeviceData[index].temperature??""}\u2103",
                    style: txtS(blc, 14, FontWeight.w400),
                  ),
                ]),
                Row(children: [
                  Icon(Icons.arrow_upward, size: b * 16, color: blc),
                  Text(
                    "${_filteredDeviceData[index].openManhole??""}",
                    style: txtS(blc, 14, FontWeight.w400),
                  ),
                ]),
                Row(children: [
                  SvgPicture.asset(
                    'images/signal.svg',
                    allowDrawingOutsideViewBox: true,
                  ),
                  SizedBox(width: b * 5),
                  Text(
                    "${_filteredDeviceData[index].signalStrength??""}",
                    style: txtS(blc, 14, FontWeight.w400),
                  ),
                ]),
              ],
            ),
            sh(23),
            Text(
              "${_filteredDeviceData[index].address??""}",
              style: txtS(dc, 12, FontWeight.w400),
            ),
          ],
        ),
      ),
    );                        
                      }))),
        ],
      );
  },
    ),
    );
  }
}
