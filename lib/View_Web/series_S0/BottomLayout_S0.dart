import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Models.dart';
import 'package:flutter/material.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:provider/provider.dart';

class BottomLayoutS0Web extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return BottomLayoutState();
  }
}

class BottomLayoutState extends State<BottomLayoutS0Web>
    with SingleTickerProviderStateMixin {
  Animation groundAnimation,
      normalAnimation,
      informativeAnimation,
      criticalAnimation;
  AnimationController animationController;
  bool details = false, _animate = false, _isStart = true;  
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<int> _count = List.filled(4, null);
  int countOpenManhole =0,
      countbattery = 0, countError = 0;
  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((_){
       _isStart
        ? Future.delayed(Duration(milliseconds: 1100), () {
            setState(() {
              _animate = true;
              _isStart = false;
            });
          })
        : _animate = true;
    
      });
    animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
  
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }
  Widget informationRow(Color col, String tit, int val) {
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return Container(
      padding: EdgeInsets.only(
          left: b * 25, right: b * 25, top: h * 15, bottom: h * 15),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: col,
            radius: b * 5.5,
          ),
          sb(8),
          Text(
            tit,
            style: txtS(col, 16, FontWeight.w400),
          ),
          sb(14),
          Text(
            val.toString(),
            style: txtS(col, 16, FontWeight.w400),
          ),
        ],
      ),
    );
  }
  
  Container detailRow(String tit, int val) {
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return Container(
      padding: EdgeInsets.only(
          left: b * 25, right: b * 25, top: h * 15, bottom: h * 15),
      color: Colors.white,
      margin: EdgeInsets.only(bottom: h * 6),
      child: Row(children: [
        Text(
          tit,
          style: txtS(dc, 16, FontWeight.w400),
        ),
        Spacer(),
        Text(
          val.toString(),
          style: txtS(dc, 16, FontWeight.w400),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;
    
    return
        Consumer<ChangeDeviceData>(
          builder: (context, model, child){
          print("Length of All device is ${model.allDeviceData.length}");
          _count = countDevices(model.allDeviceData);
          countbattery = 0;
          countError = 0;
          countOpenManhole = 0;
          model.allDeviceData.forEach((element) {
            if (element.battery < (GlobalVar.seriesMap["S0"].model as S0DeviceSettingModel).batterythresholdvalue) {
              countbattery++;
            }  
            if(element.wlevel > 3){
              countError++;
            }
            if(element.openManhole ==1){
              countOpenManhole ++;
            }
          });
          groundAnimation = IntTween(begin: 0, end: _count[0]).animate(
              CurvedAnimation(parent: animationController, curve: Curves.ease));

          normalAnimation = IntTween(begin: 0, end: _count[1]).animate(
              CurvedAnimation(parent: animationController, curve: Curves.ease));

          informativeAnimation = IntTween(begin: 0, end: _count[2]).animate(
              CurvedAnimation(parent: animationController, curve: Curves.ease));

          criticalAnimation = IntTween(begin: 0, end: _count[3]).animate(
              CurvedAnimation(parent: animationController, curve: Curves.ease));

          animationController.forward();

          return AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget child) {
                return Container(
       width: b * 420,
      padding: EdgeInsets.only(top: details ? h * 18 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(h * 10),
        color: Color(0xfff8f8f8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        sh(8),
        Container(
          child: Text(
            "Total Devices With",
            style: txtS(blc, 16, FontWeight.w400),
          ),
        ),
        sh(18),
        Row(children: [
          Expanded(
            flex: 2,
            child: informationRow(Color(0xff848484), 'Ground Level', groundAnimation.value),
          ),
          Expanded(
            flex: 2,
            child: informationRow(Color(0xff69d66d), 'Normal Level', normalAnimation.value),
          ),
        ]),
        sh(20),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: informationRow( Color(0xffFFBC3A), 'Informative Level', informativeAnimation.value),
            ),
            Expanded(
              flex: 2,
              child: informationRow(Colors.red, 'Critical Level', criticalAnimation.value),
            ),
          ],
        ),
        sh(16),
        details
            ? AnimatedOpacity(
                duration: Duration(milliseconds: 1000),
                opacity: _animate ? 1 : 0,
                curve: Curves.easeInOutQuart,
                child: AnimatedPadding(
                  duration: Duration(milliseconds: 1000),
                  padding: _animate
                      ? EdgeInsets.all(0)
                      : const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      detailRow("Open Manholes", countOpenManhole),
                      detailRow("Insufficient Energy", countbattery),
                      if(GlobalVar.strAccessLevel !="3" && GlobalVar.strAccessLevel !="5")
                      detailRow("Error in Devices", countError),
                    ],
                  ),
                ),
              )
            : SizedBox(),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            setState(() {
              details = !details;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: h * 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(b * 6),
            ),
            alignment: Alignment.center,
            child: Text(
              details ? 'Hide Details' : "Show Details",
              style: TextStyle(
                color: blc,
                fontSize: h * 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        sh(10),
      ]),
    );
              });
          }
        );
  }
}

List<int> countDevices(List<DeviceData> _allDevicedata) {
  print("Length ${_allDevicedata.length}");
  List<int> _count = List.filled(4, null);
  int _ground = 0, _normal = 0, _informative = 0, _critical = 0;
  for (var i = 0; i < _allDevicedata.length; i++) {
    if (_allDevicedata[i].wlevel == 0) {
      _ground++;
    } else if (_allDevicedata[i].wlevel == 1) {
      _normal++;
    } else if (_allDevicedata[i].wlevel == 2) {
      _informative++;
    } else if(_allDevicedata[i].wlevel == 3){
      _critical++;
    }
  }
  _count[0] = _ground;
  _count[1] = _normal;
  _count[2] = _informative;
  _count[3] = _critical;
  print("ground ${_count[0]}");
  print("normal ${_count[1]}");
  print("informative ${_count[2]}");
  print("critical${_count[3]}");

  return _count;
}
