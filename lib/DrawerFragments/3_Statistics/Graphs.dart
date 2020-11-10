import 'package:Decon/Models/Models.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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

class Graphs extends StatefulWidget {
  final DeviceData deviceData;
  final String sheetURL;
  Graphs({@required this.deviceData, @required this.sheetURL});
  @override
  _GraphsState createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  List<charts.Series<LinearData, int>> _seriesLinearData;
  List<charts.Series<TempData, int>> _seriesTempData;
  List<charts.Series<ManHoleData, int>> _seriesManHoleData;
  String currentMM, currentYY;
  String monthNo;
  String url;
  String _itemSelected;
  List<LinearData> data1 = [];
  Map<String,String> _monthstonum = {
     "January":"01",
    "February":"02",
    "March":"03",
    "April":"04",
    "May":"05",
    "June":"06",
    "July":"07",
    "August":"08",
    "September":"09",
    "October":"10",
    "November":"11",
    "December":"12"
  };
  Map<int, String> _numtomonths = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December"
  };
  List<String> list = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  Map<int, int> _dataMap = {
    1: 31,
    2: 28,
    3: 31,
    4: 30,
    5: 31,
    6: 30,
    7: 31,
    8: 31,
    9: 30,
    10: 31,
    11: 30,
    12: 31,
  };
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
  int i;
  _generateData() {
    var data2 = [
      TempData(1, 10.0),
      TempData(2, 31.5),
      TempData(3, 81.0),
      TempData(4, 23.0),
      TempData(5, 45.6),
    ];
    var data3 = [
      ManHoleData(1, 1),
      ManHoleData(2, 0),
      ManHoleData(3, 1),
      ManHoleData(4, 0),
      ManHoleData(5, 1),
    ];

    _seriesTempData.add(charts.Series(
      data: data2,
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
      domainFn: (TempData data, _) => data.yearval,
      measureFn: (TempData data, _) => data.temp,
      id: "Temp",
    ));
    _seriesManHoleData.add(charts.Series(
      data: data3,
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
      domainFn: (ManHoleData data, _) => data.yearval,
      measureFn: (ManHoleData data, _) => data.condn,
      id: "Condn",
    ));
  }

  Future<List<FeedbackForm>> getFeedbackList() async {
    return await http.get(url).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => FeedbackForm.fromJson(json)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    var _date = DateTime.now();
    int mm = _date.month;
    int yy = _date.year;
    monthNo = mm.toString().length == 1 ? "0$mm" : "$mm";
    currentMM = _numtomonths[mm];
     _itemSelected = currentMM;
    currentYY = yy.toString();
    _createLevelGraphDatapoints();   
    _generateData();

  }
 _createLevelGraphDatapoints(){
   String searchKey = "$monthNo/$currentYY";
    url =
        "https://script.google.com/macros/s/AKfycbxhhXD1omW3H-nZcJUvfPZje2BdMGgvdTwc2X4x89F0Sh3O_egA/exec?searchKey=$searchKey&deviceNo=${widget.deviceData.id.split("_")[2].substring(1, 2)}&sheetURL=${widget.sheetURL}";
   
    
    _seriesLinearData = List<charts.Series<LinearData, int>>();
    _seriesTempData = List<charts.Series<TempData, int>>();
    _seriesManHoleData = List<charts.Series<ManHoleData, int>>();
    getFeedbackList().then((value) {
      int i = 1, ground = 0, normal = 0, informative = 0, critical = 0;
      data1.clear();
      for (i = 1; i <= 31; i++) {
        ground = 0;
        normal = 0;
        informative = 0;
        critical = 0;
        value.forEach((element) {
          String date = i.toString().length == 1 ? "0$i" : "$i";
          if (element.date.contains("$date/$monthNo/$currentYY\n")) {
            if (element.level == "0") {
              ground++;
            } else if (element.level == "1") {
              normal++;
            } else if (element.level == "2") {
              informative++;
            } else if (element.level == "3") {
              critical++;
            }
          }
        });

        if (ground == 0 && normal == 0 && informative == 0 && critical == 0) {
          data1.add(LinearData(i, 0));
        } else {
          if (critical >= normal &&
              critical >= informative &&
              critical >= ground) {
            data1.add(LinearData(i, 3));
          } else if (informative >= normal &&
              informative >= ground &&
              informative >= critical) {
            data1.add(LinearData(i, 2));
          } else if (normal >= informative &&
              normal >= ground &&
              normal >= critical) {
            data1.add(LinearData(i, 1));
          } else {
            data1.add(LinearData(i, 0));
          }
        }
      }
      _seriesLinearData.add(charts.Series(
        data: data1,
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        domainFn: (LinearData data, _) => data.yearval,
        measureFn: (LinearData data, _) => data.salesval,
        id: "Air",
      ));
      setState(() {});
    });
 }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
          title: Container(
        padding: EdgeInsets.only(left: 8.0),
        width: SizeConfig.v * 60,
        height: SizeConfig.b * 11,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(12.0)),
        child: DropdownButton<String>(
          dropdownColor: Color(0xff263238),
          underline: SizedBox(
            height: 0.0,
          ),
          elevation: 8,
          items: list.map((dropDownStringitem) {
            return DropdownMenuItem<String>(
              
              value: dropDownStringitem,
              child: Container(
                padding: EdgeInsets.only(left: 8.0, top: 8.0),
        
                width: SizeConfig.v * 60,
                height: SizeConfig.b * 11,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12.0)),
                child: Text(
                  dropDownStringitem,
                ),
              ),
            );
          }).toList(),
          onChanged: (newValueSelected) {
            setState(() {
            _itemSelected = newValueSelected;
            monthNo = _monthstonum[_itemSelected].toString();
            print(monthNo);
            _createLevelGraphDatapoints();  
            }); 
            
          },
          isExpanded: true,
          hint: Text("Select Month"),
          value: _itemSelected ?? null,
        ),
      )),
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Text("Last Updated: 28/nov/2019"),
                  //     Container(
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: SizeConfig.b * 1,
                  //             vertical: SizeConfig.v * 0.6),
                  //         decoration: BoxDecoration(
                  //             borderRadius:
                  //                 BorderRadius.circular(SizeConfig.b * 2),
                  //             color: Color(0xff0099FF)),
                  //         child: Text(widget.deviceData.id,
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: SizeConfig.b * 3.57))),
                  //   ],
                  // ),
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
                          Text("${levels[widget.deviceData.wlevel]}",
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
                              size: SizeConfig.b * 4),
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
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: charts.LineChart(
                _seriesLinearData,
                defaultRenderer:
                    charts.LineRendererConfig(includeArea: true, stacked: true),
                animate: true,
                animationDuration: Duration(seconds: 5),
                behaviors: [
                  charts.ChartTitle("Days",
                      behaviorPosition: charts.BehaviorPosition.bottom),
                  charts.ChartTitle("Levels",
                      behaviorPosition: charts.BehaviorPosition.start)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: charts.LineChart(
                _seriesTempData,
                defaultRenderer:
                    charts.LineRendererConfig(includeArea: true, stacked: true),
                animate: true,
                animationDuration: Duration(seconds: 5),
                behaviors: [
                  charts.ChartTitle("Years",
                      behaviorPosition: charts.BehaviorPosition.bottom),
                  charts.ChartTitle("Temperature",
                      behaviorPosition: charts.BehaviorPosition.start)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: charts.LineChart(
                _seriesManHoleData,
                defaultRenderer:
                    charts.LineRendererConfig(includeArea: true, stacked: true),
                animate: true,
                animationDuration: Duration(seconds: 5),
                behaviors: [
                  charts.ChartTitle("Years",
                      behaviorPosition: charts.BehaviorPosition.bottom),
                  charts.ChartTitle("ManHole Condn",
                      behaviorPosition: charts.BehaviorPosition.start)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LinearData {
  int yearval;
  int salesval;
  LinearData(this.yearval, this.salesval);
}

class TempData {
  int yearval;
  double temp;
  TempData(this.yearval, this.temp);
}

class ManHoleData {
  int yearval;
  int condn;
  ManHoleData(this.yearval, this.condn);
}
