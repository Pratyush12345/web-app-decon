import 'package:Decon/Authentication/Wait.dart';
import 'package:Decon/DrawerFragments/3_Statistics/Graphs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class LevelGraph extends StatelessWidget {
  final List<ChartSeries<LinearData, int>> seriesLinearData;
  final double lastDay;
  LevelGraph({this.seriesLinearData, this.lastDay});
  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.only(right: 8.0),
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            child: seriesLinearData.length!=0? SfCartesianChart(
              enableMultiSelection: false,

              tooltipBehavior: TooltipBehavior(
                enable: true,
                header: "Day : Level",
              ),

              series: seriesLinearData,
              enableAxisAnimation: true,
              title: ChartTitle(text: 'Level analysis'),
              legend: Legend(isVisible: true),
              //tooltipBehavior: TooltipBehavior(enable: true),
              primaryYAxis: NumericAxis(
                interval: 1,
                maximum: 3,
                title: AxisTitle(
                  text: "Levels"
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