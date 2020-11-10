import 'package:Decon/DrawerFragments/3_Statistics/Graphs.dart';
import 'package:Decon/MainPage/Layout/Address.dart';

import 'package:Decon/Models/Models.dart';
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

class AllDevices extends StatefulWidget {
  final BuildContext menuScreenContext;
  final List<DeviceData> allDeviceData;
  final String sheetURL;
  AllDevices({Key key, this.menuScreenContext,this.sheetURL, this.allDeviceData}) : super(key: key);

  @override
  _AllDevicesState createState() => _AllDevicesState();
}

const gc = Colors.black;
const tc = Color(0xff263238);

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
  final Map<int, String> levels = {0:"Ground level", 1:"Normal Level", 2:"Infromative Level",
  3:"Critical Level"};
  final Map<int , Color> _levelsColor = {0: Color(0xffC4C4C4) , 1:Color(0xff69D66D), 2:Color(0xffE1E357),
  3:Color(0xffD93D3D)};

  @override
  void initState() {
    widget.allDeviceData.forEach((element) {
      _filteredDeviceData.add(element);
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: SizeConfig.v * 3),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(
              SizeConfig.b * 1.5, SizeConfig.v * 1, SizeConfig.b * 1.3, 0),
          height: SizeConfig.v * 7,
          width: SizeConfig.b * 63.61,
          decoration: BoxDecoration(
              color: Color(0xffDEE0E0),
              borderRadius: BorderRadius.circular(SizeConfig.b * 7.2)),
          child: TextField(
            onChanged: (value){
             _filteredDeviceData.clear();  
             widget.allDeviceData.forEach((element) {
                _filteredDeviceData.add(element);
              });      
             setState(() {
                _filteredDeviceData.removeWhere((element){ 
                 if(!element.address.toLowerCase().contains(value.trim().toLowerCase())){
                   if(!element.id.toLowerCase().contains(value.trim().toLowerCase()))
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
              prefixIcon : Icon(Icons.search, size: 25.0,),
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
          height: SizeConfig.v * 7,
          width: SizeConfig.b * 28,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 222, 224, 224),
              borderRadius: BorderRadius.circular(SizeConfig.b * 7.7)),
          child: DropdownButton<String>(
                 dropdownColor: Color(0xff263238),
                isDense: false,
                underline: SizedBox(height: 0.0,),
                elevation: 8,
                items: list.map((dropDownStringitem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringitem,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(4.0,4.0,0.0,0.0),
                        width: SizeConfig.b*80,
                        height: SizeConfig.v*4,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 222, 224, 224).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                      child: Text(
                        dropDownStringitem,
                        style: TextStyle(
                        color: Colors.black87,  
                        fontSize: SizeConfig.b*3.2
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValueSelected) {
                  setState(() {
                    __itemSelected = newValueSelected;
                    _filteredDeviceData.clear();
                    for (var i = 0; i < widget.allDeviceData.length; i++) {
                      
                      if(__itemSelected == "None"){
                       _filteredDeviceData.add(widget.allDeviceData[i]);
                      }
                      else if(__itemSelected == "Ground Level"){
                      if (widget.allDeviceData[i].wlevel == 0) {
                        _filteredDeviceData.add(widget.allDeviceData[i]);
                      } 
                      }
                      else if(__itemSelected == "Normal Level"){
                      if (widget.allDeviceData[i].wlevel == 1) {
                        _filteredDeviceData.add(widget.allDeviceData[i]);
                      } 
                      }
                      else if(__itemSelected == "Informative Level"){
                      if (widget.allDeviceData[i].wlevel == 2) {
                        _filteredDeviceData.add(widget.allDeviceData[i]);
                      } 
                      }
                      else if(__itemSelected == "Critical Level"){
                      if (widget.allDeviceData[i].wlevel == 3) {
                        _filteredDeviceData.add(widget.allDeviceData[i]);
                      } 
                      }
                      else if(__itemSelected == "Open Manholes"){
                      if (widget.allDeviceData[i].wlevel == 0) {
                        _filteredDeviceData.add(widget.allDeviceData[i]);
                      } 
                      }
                      else if(__itemSelected == "High Temperature"){
                      if (widget.allDeviceData[i].wlevel == 0) {
                        _filteredDeviceData.add(widget.allDeviceData[i]);
                      } 
                      }
                      else if(__itemSelected == "Insufficient Battery"){
                      if (widget.allDeviceData[i].battery <= 80) {
                        _filteredDeviceData.add(widget.allDeviceData[i]);
                      } 
                      }
                    }
                  });
                },
                isExpanded: true,
                hint: Text("Filter", style: TextStyle(fontSize: SizeConfig.b*3.2),),
                value: __itemSelected ?? null,
              )
        ),
      ]),
      SizedBox(height: SizeConfig.v * 1),
      Divider(color: Color(0xffCACACA), thickness: 1),
      Expanded(
          child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: ListView.builder(
                  
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: _filteredDeviceData.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return InkWell(
                        onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Graphs(deviceData: _filteredDeviceData[index],sheetURL: widget.sheetURL,)));
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
                                    Text("${_filteredDeviceData[index].id.split("_")[2].replaceAll("D","Device ")}",
                                        style: TextStyle(
                                            fontSize: SizeConfig.b * 5.09,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(height: SizeConfig.v * 1),
                                    Row(children: [
                                      CircleAvatar(
                                        radius: SizeConfig.b * 1.781,
                                        backgroundColor:
                                            _levelsColor[ _filteredDeviceData[index].wlevel] 
                                      ),
                                      SizedBox(width: SizeConfig.b * 2),
                                      Text("${ levels[_filteredDeviceData[index].wlevel]}",
                                          style: TextStyle(
                                              fontSize: SizeConfig.b * 3.57))
                                    ]),
                                    SizedBox(height: SizeConfig.v * 1),
                                    Container(
                                        padding: EdgeInsets.fromLTRB(
                                            SizeConfig.b * 5.6, 0, 0, 0),
                                        child: Text(_filteredDeviceData[index].address,
                                            style: TextStyle(
                                                fontSize: SizeConfig.b * 3.054,
                                                color: Color(0xff0099FF)))),
                                  ])),
                          Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,    
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
                                  child: Text(_filteredDeviceData[index].id,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: SizeConfig.b * 3.57))),
                              SizedBox(height: SizeConfig.v * 0.5),
                              Row(children: [
                                Icon(Icons.arrow_upward,
                                    size: SizeConfig.b * 4),
                                SizedBox(width: SizeConfig.b * 1),
                                Text("${_filteredDeviceData[index].openManhole}m")
                              ]),
                              SizedBox(height: SizeConfig.v * 0.5),
                              Row(children: [
                                Icon(Icons.battery_charging_full,
                                    size: SizeConfig.b * 4),
                                SizedBox(width: SizeConfig.b * 1),
                                Text("${_filteredDeviceData[index].battery}%")
                              ]),
                              SizedBox(height: SizeConfig.v * 0.5),
                              Row(children: [
                                Icon(Icons.thermostat_rounded,
                                    size: SizeConfig.b * 4),
                                SizedBox(width: SizeConfig.b * 1),
                                Text("${_filteredDeviceData[index].temperature}\u2103")
                              ]),
                            ],
                          ))
                        ]),
                        SizedBox(height: SizeConfig.v * 1),
                        Divider(color: Color(0xffCACACA), thickness: 1),
                      ]),
                    );
                  }))),
    ]));
  }
}

