import 'package:Decon/Controller/Providers/deviceHoverProvider.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';


class InformationTile extends StatelessWidget {
  final DeviceData deviceData;
  int index;
  InformationTile({@required this.deviceData, @required this.index});
  final Map<int, String> levels = {
    0: "Ground level",
    1: "Normal Level",
    2: "Infromative Level",
    3: "Critical Level",
    191: "Sensor 1",
    192: "Sensor 2",
    193: "Sensor 3"
  };
  final Map<int, String> _manholeCondition = {
    0: "manhole close",
    1: "manhole open",
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
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 1440;
    var h = SizeConfig.screenHeight / 900;

    return Consumer<DeviceHoverProvider>(
      builder: (context, model, child)=>
       Transform.translate(
         offset: model.hoveredIndex == index ? Offset(0, -5.0) :  Offset.zero ,
         child: Transform.scale(
           scale: model.hoveredIndex == index ? 1.05 : 1.0,
           child: Container(
            margin: EdgeInsets.only(bottom: h * 22),
            padding: EdgeInsets.only(
                top: h * 12, bottom: h * 15, left: b * 12, right: b * 12),
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
              borderRadius: BorderRadius.circular(h * 10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${deviceData.id.split("_")[2].replaceAll("D", "Device ")}",
                      style: txtS(dc, 20, FontWeight.w500),
                    ),
                    sb(30),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: h * 2, horizontal: b * 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(h * 2),
                        color: dc,
                      ),
                      child: Text(
                        'ID : ${deviceData.id}',
                        style: txtS(wc, 14, FontWeight.w400),
                      ),
                    ),
                    Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: b * 10),
                          height: h * 12,
                          width: b * 12,
                          decoration: BoxDecoration(
                            color: _levelsColor[deviceData.wlevel],
                            shape: BoxShape.circle,
                          ),
                          child: deviceData.wlevel>= 191? 
                                Icon(Icons.error,
                                size: h * 14,
                                color: Colors.red,): 
                                SizedBox(),
                        ),
                        Text(
                           levels[deviceData.wlevel]??"",
                          style: txtS(_levelsColor[deviceData.id], 16, FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                sh(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if(HomePageVM.instance.getSeriesCode == "S1")
                      
                    Row(children: [
                      SvgPicture.asset(
                        'images/distance.svg',
                        allowDrawingOutsideViewBox: true,
                      ),
                      sb(5),
                      Text(
                        "${deviceData.distance??""}m",
                        style: txtS(blc, 16, FontWeight.w400),
                      ),
                    ]),
                    Row(children: [
                      Icon(Icons.battery_charging_full, size: b * 16, color: blc),
                      Text(
                        "${deviceData.battery??""}%",
                        style: txtS(blc, 16, FontWeight.w400),
                      ),
                    ]),
                    if(HomePageVM.instance.getSeriesCode == "S1")
                 
                    Row(children: [
                      Icon(Icons.thermostat_sharp, size: b * 16, color: blc),
                      Text(
                        "${deviceData.temperature??""}\u2103",
                        style: txtS(blc, 16, FontWeight.w400),
                      ),
                    ]),
                     
                    Row(children: [
                      Icon(Icons.arrow_upward, size: b * 16, color: blc),
                    sb(5),
                          
                  Text(
                    "${_manholeCondition[deviceData.openManhole]??""}",
                    style: txtS(blc, 14, FontWeight.w400),
                  ),
                    ]),
                    Row(children: [
                      SvgPicture.asset(
                        'images/signal.svg',
                        allowDrawingOutsideViewBox: true,
                      ),
                      sb(5),
                      Text(
                        "${deviceData.signalStrength??""}",
                        style: txtS(blc, 16, FontWeight.w400),
                      ),
                    ]),
                  ],
                ),
                sh(30),
                Text(
                  "${deviceData.address??""}",
                  style: txtS(dc, 16, FontWeight.w400),
                ),
              ],
            ),
      ),
         ),
       ),
    );
  }
}
