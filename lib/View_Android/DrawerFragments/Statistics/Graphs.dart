import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/View_Android/DrawerFragments/Statistics/graphs_provider.dart';
import 'package:Decon/View_Android/DrawerFragments/Statistics/graphs_viewmodel.dart';
import 'package:Decon/View_Android/DrawerFragments/Statistics/levelGraph.dart';
import 'package:Decon/View_Android/DrawerFragments/Statistics/TemperatureGraph.dart';
import 'package:Decon/View_Android/DrawerFragments/Statistics/ManholeGraph.dart';
import 'package:Decon/Models/Models.dart';
import 'package:flutter/material.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:provider/provider.dart';


class Graphs extends StatefulWidget {
  final DeviceData deviceData;
  final String sheetURL;
  final String scriptEditorURL;
  Graphs({@required this.deviceData, @required this.scriptEditorURL, @required this.sheetURL});
  @override
  _GraphsState createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  final Map<int, String> _levels = {
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
    GraphsVM.intsance.init(context,widget.sheetURL, widget.scriptEditorURL, widget.deviceData);
    }

  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(title: Text("Graph")),
      body: ListView(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${widget.deviceData.id.split("_")[2].replaceAll("D", "Device ")}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Last Updated: ${GraphsVM.intsance.formattedDate(widget.deviceData.lastUpdated)}"),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.b * 1,
                              vertical: SizeConfig.v * 0.6),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(SizeConfig.b * 2),
                              color: Color(0xff0099FF)),
                          child: Text(widget.deviceData.id,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.b * 3.57))),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: SizeConfig.v * 1),
                        Row(children: [
                          CircleAvatar(
                              radius: SizeConfig.b * 1.781,
                              backgroundColor:
                                  _levelsColor[widget.deviceData.wlevel]),
                          SizedBox(width: SizeConfig.b * 0.5),
                          Text("${_levels[widget.deviceData.wlevel]}",
                              style: TextStyle(fontSize: SizeConfig.b * 3.57))
                        ]),
                        SizedBox(width: SizeConfig.v * 1),
                        Row(children: [
                          Icon(Icons.arrow_upward, size: SizeConfig.b * 4),
                          SizedBox(width: SizeConfig.b * 0.5),
                          Text("${widget.deviceData.openManhole}m")
                        ]),
                        SizedBox(width: SizeConfig.v * 1),
                        Row(children: [
                          Icon(Icons.battery_charging_full,
                              color: Colors.green, size: SizeConfig.b * 4),
                          SizedBox(width: SizeConfig.b * 0.5),
                          Text("${widget.deviceData.battery}%")
                        ]),
                        SizedBox(width: SizeConfig.v * 1),
                        Row(children: [
                          Icon(Icons.add, size: SizeConfig.b * 4),
                          SizedBox(width: SizeConfig.b * 0.5),
                          Text("${widget.deviceData.temperature}\u2103")
                        ]),
                        SizedBox(
                          width: SizeConfig.v * 1,
                        )
                      ]),
                  SizedBox(height: SizeConfig.v * 1.5),
                  Container(
                      padding: EdgeInsets.fromLTRB(SizeConfig.b * 5.6, 0, 0, 0),
                      child: Text(widget.deviceData.address,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: SizeConfig.b * 3.054,
                              color: Color(0xff0099FF)))),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: SizeConfig.b * 40,
                height: SizeConfig.v * 11,
                child: DropdownButton<String>(
                  dropdownColor: Color(0xff263238),
                  underline: SizedBox(
                    height: 0.0,
                  ),
                  elevation: 8,
                  items: GraphsVM.intsance.monthslist.map((dropDownStringitem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringitem,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 10 / 360,
                            top: SizeConfig.screenHeight * 9 / 640),
                        width: SizeConfig.v * 70,
                        height: SizeConfig.b * 11,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenHeight * 8 / 640),
                        ),
                        child: Text(
                          dropDownStringitem,
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
                width: SizeConfig.b * 30,
                height: SizeConfig.v * 11,
                child: DropdownButton<String>(
                  dropdownColor: Color(0xff263238),
                  underline: SizedBox(
                    height: 0.0,
                  ),
                  elevation: 8,
                  items: GraphsVM.intsance.yearlist.map((dropDownStringitem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringitem,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 10 / 360,
                            top: SizeConfig.screenHeight * 9 / 640),
                        width: SizeConfig.v * 60,
                        height: SizeConfig.b * 11,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenHeight * 8 / 640),
                        ),
                        child: Text(
                          dropDownStringitem,
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
          if(GlobalVar.seriesMap[HomePageVM.instance.getSeriesCode].graphs.contains("${HomePageVM.instance.getSeriesCode}_levelSheet"))
          Consumer<LinearGraphProvider>(
            builder: (context, model, child)=>
            LevelGraph(
              seriesLinearData: model.seriesLinearData,
              lastDay: double.parse(model.noOfDays.toString()),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          if(GlobalVar.seriesMap[HomePageVM.instance.getSeriesCode].graphs.contains("${HomePageVM.instance.getSeriesCode}_openManholeSheet"))
          Consumer<OpenManholeGraphProvider>(
            builder: (context, model, child)=>
             ManholeGraph(
                seriesManHoleData: model.seriesManHoleData,
                lastDay: double.parse(model.noOfDays.toString())),
          ),
          SizedBox(
            height: 20.0,
          ),
          if(GlobalVar.seriesMap[HomePageVM.instance.getSeriesCode].graphs.contains("${HomePageVM.instance.getSeriesCode}_temperatureSheet"))
          Consumer<TempGraphProvider>(
            builder: (context,model ,child)=>
            TempGraph(
                seriesTempData: model.seriesTempData,
                lastDay: double.parse(model.noOfDays.toString())),
          ),
          
        ],
      ),
    );
  }
}

