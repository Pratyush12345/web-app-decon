import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/View_Web/Bottom_Navigation/informationTile.dart';
import 'package:Decon/View_Web/Dialogs/Filter_dialogbox.dart';
import 'package:Decon/View_Web/DrawerFragments/Statistics/Graphs.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Devices extends StatefulWidget {
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  final TextEditingController search = TextEditingController();
  List<DeviceData> _listDeviceData = [];
  DeviceData _deviceData;
  bool isdeviceSearched= false;
  String __itemSelected;
  final Map<int, String> levels = {
    0: "Ground level",
    1: "Normal Level",
    2: "Infromative Level",
    3: "Critical Level",
    191: "Sensor 1",
    192: "Sensor 2",
    193: "Sensor 3"
  };
  final Map<int, Color> _levelsColor = {
    0: Color(0xffC4C4C4),
    1: Color(0xff69D66D),
    2: Color(0xffE1E357),
    3: Color(0xffD93D3D),
    191: Colors.white,
    192: Colors.white,
    193: Colors.white
  };
  
  _filterDevices(List<DeviceData> allDeviceData) {
                    isdeviceSearched = true;
                    setState(() {
                      _listDeviceData.clear();
                      for (var i = 0; i < allDeviceData.length; i++) {
                        if (__itemSelected == "None") {
                          isdeviceSearched = false;
                          _listDeviceData.add(allDeviceData[i]);
                        } else if (__itemSelected == "Ground Level") {
                          if (allDeviceData[i].wlevel == 0) {
                            _listDeviceData.add(allDeviceData[i]);
                          }
                        } else if (__itemSelected == "Normal Level") {
                          if (allDeviceData[i].wlevel == 1) {
                            _listDeviceData.add(allDeviceData[i]);
                          }
                        } else if (__itemSelected == "Informative Level") {
                          if (allDeviceData[i].wlevel == 2) {
                            _listDeviceData.add(allDeviceData[i]);
                          }
                        } else if (__itemSelected == "Critical Level") {
                          if (allDeviceData[i].wlevel == 3) {
                            _listDeviceData.add(allDeviceData[i]);
                          }
                        } else if (__itemSelected == "Open Manholes") {
                          if (allDeviceData[i].wlevel == 0) {
                            _listDeviceData.add(allDeviceData[i]);
                          }
                        } else if (__itemSelected == "High Temperature") {
                          if (allDeviceData[i].wlevel == 0) {
                            _listDeviceData.add(allDeviceData[i]);
                          }
                        } else if (__itemSelected == "Insufficient Battery") {
                          if (allDeviceData[i].battery <= 80) {
                            _listDeviceData.add(allDeviceData[i]);
                          }
                        }
                      }
                    });
                  }
  Future showFilterDialog(BuildContext context, List<DeviceData> _allList) {
    return showAnimatedDialog(
        barrierDismissible: true,
        context: context,    
        animationType: DialogTransitionType.scaleRotate,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),
        builder: (context) {
          return FilterDialogDevice(selected: __itemSelected);
        }).then((value) { 
          if(value!=null){
          __itemSelected = value;
          _filterDevices( _allList);
          }
          });
  }                
  @override
    void initState() {
      if(Provider.of<ChangeDeviceData>(context, listen: false).allDeviceData!=null && 
         Provider.of<ChangeDeviceData>(context, listen: false).allDeviceData.isNotEmpty)
      _deviceData = Provider.of<ChangeDeviceData>(context, listen: false).allDeviceData[0];
      
                          
    
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              //TitleBar(),
              Expanded(
                child: Row(children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding:
                          EdgeInsets.fromLTRB(b * 0, h * 15, b * 0, h * 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(h * 10),
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.10),
                        //     blurRadius: 20,
                        //     spreadRadius: 0,
                        //     offset: Offset(0, 0),
                        //   ),
                        // ],
                      ),
                      margin: EdgeInsets.only(
                          left: b * 32, right: b * 21.5, bottom: h * 55, top: h*20),
                      child: Consumer<ChangeDeviceData>(
                        builder: (context, changeList, child){
                        if(!isdeviceSearched)
                        _listDeviceData = List.from(changeList.allDeviceData);
                    
                        return changeList.allDeviceData == null?AppConstant.progressIndicator():
                        changeList.allDeviceData.isEmpty?AppConstant.noDataFound():
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: b * 18),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: dc, width: 0.5),
                                        color: Color(0xffffffff),
                                        borderRadius:
                                            BorderRadius.circular(h * 60),
                                      ),
                                      child: TextField(
                                         onChanged: (val){
                                          if(val.isNotEmpty){
                                          _listDeviceData = changeList.allDeviceData.where((element) => element.id.toLowerCase().contains(val.toLowerCase()) || element.address.toLowerCase().contains(val.toLowerCase()) ).toList();
                                          isdeviceSearched = true;
                                          }else{
                                            isdeviceSearched = false;
                                          _listDeviceData = changeList.allDeviceData;
                                          }
                                          setState(() {});
                                          },
                  
                                        style: txtS(dc, 16, FontWeight.w500),
                                        decoration: InputDecoration(
                                          prefixIcon: InkWell(
                                            
                                            child: Icon(Icons.search,
                                                color: Colors.black),
                                            
                                          ),
                                          isDense: true,
                                          isCollapsed: true,
                                          prefixIconConstraints: BoxConstraints(
                                              minWidth: 40, maxHeight: 24),
                                          hintText: 'Search by Device Id/ Location',
                                          hintStyle: txtS(Color(0xff858585), 16,
                                              FontWeight.w400),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: h * 14,
                                              horizontal: b * 20),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  sb(30),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: (){
                                              showFilterDialog(context,changeList.allDeviceData);
                                            },
                                      child: Container(
                                        height: h * 45,
                                        width: b * 45,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: b * 28),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: blc, width: 0.5),
                                          shape: BoxShape.circle,
                                        ),
                                        child: SvgPicture.asset(
                                          'images/filter.svg',
                                          allowDrawingOutsideViewBox: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            sh(15),
                            Expanded(
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: b * 22, vertical: h * 13),
                                  itemCount: _listDeviceData.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return InkWell(
                                      onTap: () {
                                        print("device Data tapped");
                                        _deviceData = _listDeviceData[index];
                                        setState(() {});
                                      },
                                      child: InformationTile(deviceData: _listDeviceData[index],),
                                    );
                                  }),
                            ),
                          ],
                        );
                        }
                      )
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(b * 0, h * 9, b * 0, h * 27),
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
                      margin: EdgeInsets.only(
                          left: b * 21.5, right: b * 32, bottom: h * 55, top: h*20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sh(15),
                           Expanded(
                             child: 
                             Consumer<ChangeDeviceData>(
                        builder: (context, changeList, child){
                        if(!isdeviceSearched)
                        _listDeviceData = List.from(changeList.allDeviceData);
                    
                        return changeList.allDeviceData == null?AppConstant.progressIndicator():
                        changeList.allDeviceData.isEmpty?AppConstant.noDataFound():
                             Graphs(
                                   key: UniqueKey(),
                                   scriptEditorURL: HomePageVM.instance.getScriptEditorURL,
                                   deviceData: _deviceData,
                                   sheetURL: HomePageVM.instance.getSheetURL,
                                 );
                             }
                             )
                           ),
                            //for no data
                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: b * 21),
                            //   child: Row(
                            //     children: [
                            //       Text(
                            //         "Device 1",
                            //         style: txtS(dc, 20, FontWeight.w700),
                            //       ),
                            //       Spacer(),
                            //       Container(
                            //         padding: EdgeInsets.symmetric(
                            //             vertical: h * 2, horizontal: b * 4),
                            //         decoration: BoxDecoration(
                            //           borderRadius:
                            //               BorderRadius.circular(h * 2),
                            //           color: dc,
                            //         ),
                            //         child: Text(
                            //           'ID : C1_S9_D1',
                            //           style: txtS(wc, 14, FontWeight.w400),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // sh(132),
                            // Center(
                            //   child: Image.asset('images/noData.png',
                            //       width: b * 350, height: h * 270),
                            // ),
                            // Spacer(),
                            // Center(
                            //   child: Text(
                            //     "No data received in 15 days",
                            //     style: txtS(blc, 14, FontWeight.w400),
                            //   ),
                            // ),
                            // sh(14),
                            // Row(
                            //   children: [
                            //     Spacer(flex: 2),
                            //     Expanded(
                            //       flex: 4,
                            //       child: Container(
                            //         padding:
                            //             EdgeInsets.symmetric(vertical: h * 14),
                            //         alignment: Alignment.center,
                            //         decoration: BoxDecoration(
                            //           borderRadius:
                            //               BorderRadius.circular(h * 5),
                            //           color: Color(0xfff1f1f1),
                            //           border:
                            //               Border.all(color: blc, width: 0.5),
                            //         ),
                            //         child: Text(
                            //           "View Old Stats",
                            //           style: txtS(dc, 14, FontWeight.w400),
                            //         ),
                            //       ),
                            //     ),
                            //     Spacer(flex: 2),
                            //   ],
                            // ),
                            //Spacer(),
                          ]),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



