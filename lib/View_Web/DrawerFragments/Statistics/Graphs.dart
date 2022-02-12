import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/View_Web/DrawerFragments/Statistics/graphs_provider.dart';
import 'package:Decon/View_Web/DrawerFragments/Statistics/graphs_viewmodel.dart';
import 'package:Decon/View_Web/DrawerFragments/Statistics/levelGraph.dart';
import 'package:Decon/View_Web/DrawerFragments/Statistics/TemperatureGraph.dart';
import 'package:Decon/View_Web/DrawerFragments/Statistics/ManholeGraph.dart';
import 'package:Decon/Models/Models.dart';
import 'package:flutter/material.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Decon/Models/Consts/app_constants.dart';



class Graphs extends StatefulWidget {
  final DeviceData deviceData;
  final String sheetURL;
  final String scriptEditorURL;
  Graphs({Key key,@required this.deviceData, @required this.scriptEditorURL, @required this.sheetURL})
  : super(key: key);
  @override
  _GraphsState createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
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
  void initState() {
    super.initState();
    GraphsVM.intsance.init(context,widget.sheetURL, widget.scriptEditorURL, widget.deviceData);
    }

  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return ListView(
      padding: EdgeInsets.fromLTRB(14.0,0.0 , 14.0, 0.0),
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
        margin: EdgeInsets.only(bottom: h * 19),
        padding: EdgeInsets.only(
            top: h * 6, bottom: h * 20, left: b * 12, right: b * 12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${widget.deviceData.id.split("_")[2].replaceAll("D", "Device ")}",
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
                  'ID : ${widget.deviceData.id}',
                  style: txtS(wc, 14, FontWeight.w400),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: b * 10),
                    height: h * 12,
                    width: b * 12,
                    decoration: BoxDecoration(
                      color: _levelsColor[widget.deviceData.wlevel],
                      shape: BoxShape.circle,
                    ),
                    child: widget.deviceData.wlevel>= 191? 
                          Icon(Icons.error,
                          size: h * 14,
                          color: Colors.red,): 
                          SizedBox(),

                  ),
                  Text(
                     levels[widget.deviceData.wlevel],
                    style: txtS(_levelsColor[widget.deviceData.id], 16, FontWeight.w400),
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
                  "${widget.deviceData.distance??""}m",
                  style: txtS(blc, 16, FontWeight.w400),
                ),
              ]),
              Row(children: [
                Icon(Icons.battery_charging_full, size: b * 16, color: blc),
                Text(
                  "${widget.deviceData.battery??""}%",
                  style: txtS(blc, 16, FontWeight.w400),
                ),
              ]),
              if(HomePageVM.instance.getSeriesCode == "S1")
              
              Row(children: [
                Icon(Icons.thermostat_sharp, size: b * 16, color: blc),
                Text(
                  "${widget.deviceData.temperature??""}\u2103",
                  style: txtS(blc, 16, FontWeight.w400),
                ),
              ]),
                
              Row(children: [
                Icon(Icons.arrow_upward, size: b * 16, color: blc),
              sb(5),  
            Text(
              "${_manholeCondition[widget.deviceData.openManhole]??""}",
              style: txtS(blc, 16, FontWeight.w400),
            ),
              ]),
              Row(children: [
                SvgPicture.asset(
                  'images/signal.svg',
                  allowDrawingOutsideViewBox: true,
                ),
                sb(5),
                Text(
                  "${widget.deviceData.signalStrength??""}",
                  style: txtS(blc, 16, FontWeight.w400),
                ),
              ]),
            ],
          ),
          sh(30),
          Text(
            "${widget.deviceData.address??""}",
            style: txtS(dc, 16, FontWeight.w400),
          ),
        ],
      ), 
        
      ),
      Text("Last Updated: ${GraphsVM.intsance.formattedDate(widget.deviceData.lastUpdated)}"),
                    
                  SizedBox(height: SizeConfig.v * 0.5),
                  ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: SizeConfig.b * 15,
                height: SizeConfig.v * 5,
                child: DropdownButton<String>(
                  dropdownColor: Color(0xff263238),
                  underline: SizedBox(
                    height: 0.0,
                  ),
                  elevation: 8,
                  items: GraphsVM.intsance.monthslist.map((dropDownStringitem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringitem,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          width: SizeConfig.b * 15,
                          height: SizeConfig.v * 5,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(
                                SizeConfig.screenHeight * 8 / 640),
                          ),
                          child: Center(
                            child: Text(
                              dropDownStringitem,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValueSelected) {
                    setState(() {
                      GraphsVM.intsance.onChangeMonth(newValueSelected);
                      });
                  },
                  isExpanded: true,
                  hint: Text("Select Month"),
                  value: GraphsVM.intsance.monthSelected ?? null,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                width: SizeConfig.b * 15,
                height: SizeConfig.v * 5,
                child: DropdownButton<String>(
                  dropdownColor: Color(0xff263238),
                  underline: SizedBox(
                    height: 0.0,
                  ),
                  elevation: 8,
                  items: GraphsVM.intsance.yearlist.map((dropDownStringitem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringitem,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          width: SizeConfig.b * 15,
                          height: SizeConfig.v * 5,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(
                                SizeConfig.screenHeight * 8 / 640),
                          ),
                          child: Center(
                            child: Text(
                              dropDownStringitem,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValueSelected) {
                    setState(() {
                      GraphsVM.intsance.onChangeYear(newValueSelected);
                      });
                  },
                  isExpanded: true,
                  hint: Text("Select Year"),
                  value: GraphsVM.intsance.yearSelected ?? null,
                ),
              ),
            ],
          ),
          if(GlobalVar.seriesMap[HomePageVM.instance.getSeriesCode].graphs.contains("${HomePageVM.instance.getSeriesCode}_LevelGraph"))
          Consumer<LinearGraphProvider>(
            builder: (context, model, child)=>
            LevelGraph(
              seriesLinearData: model.seriesLinearData,
              lastDay: double.parse(model.noOfDays.toString()),
              showNoDatafoundflag: model.showNoDatafound,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          if(GlobalVar.seriesMap[HomePageVM.instance.getSeriesCode].graphs.contains("${HomePageVM.instance.getSeriesCode}_ManholeGraph"))
          Consumer<OpenManholeGraphProvider>(
            builder: (context, model, child)=>
             ManholeGraph(
                seriesManHoleData: model.seriesManHoleData,
                lastDay: double.parse(model.noOfDays.toString()),
                showNoDatafoundflag: model.showNoDatafound,),
          ),
          SizedBox(
            height: 20.0,
          ),
          if(GlobalVar.seriesMap[HomePageVM.instance.getSeriesCode].graphs.contains("${HomePageVM.instance.getSeriesCode}_TemperatureGraph"))
          Consumer<TempGraphProvider>(
            builder: (context,model ,child)=>
            TempGraph(
                seriesTempData: model.seriesTempData,
                lastDay: double.parse(model.noOfDays.toString()),
                showNoDatafoundflag: model.showNoDatafound,),
          ),
          
        ],
      );
  }
}

