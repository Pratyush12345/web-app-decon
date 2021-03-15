import 'package:Decon/View_Android/Authentication/Wait.dart';
import 'package:Decon/View_Android/DrawerFragments/3_Statistics/Graphs.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';
class TempGraph extends StatelessWidget {
  final List<ChartSeries<TempData, int>> seriesTempData;
  final double lastDay;
  TempGraph({this.seriesTempData, this.lastDay});
  
  @override
  Widget build(BuildContext context) {
    
  return Container(
            padding: EdgeInsets.only(right: 8.0),
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            child: seriesTempData.length!=0? SfCartesianChart(
              enableMultiSelection: false,

              tooltipBehavior: TooltipBehavior(
                enable: true,
                header: "Day : Temp",
              ),

              series: seriesTempData,
              enableAxisAnimation: true,
              title: ChartTitle(text: 'Temperature analysis'),
              legend: Legend(isVisible: true),
              //tooltipBehavior: TooltipBehavior(enable: true),
              primaryYAxis: NumericAxis(
                interval: 5,
                title: AxisTitle(
                  text: "Temperature"
                )
 

              ),
              primaryXAxis: NumericAxis(
                interval: 5,
                maximum: lastDay,
                title: AxisTitle(
                  text: "Days"
                  
                )
                ),
            ):Wait()
          );
        
  }
}