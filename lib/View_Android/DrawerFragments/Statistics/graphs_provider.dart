import 'package:Decon/Models/Models.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LinearGraphProvider extends ChangeNotifier{
  List<ChartSeries<LinearData, int>> seriesLinearData;
  int noOfDays;
  reinitialize(){
   seriesLinearData = [];
   noOfDays = 0;
   notifyListeners();
  }

  linearChangeGraph(List<ChartSeries<LinearData, int>> _seriesLinearData, int _noOfDays){
   seriesLinearData = _seriesLinearData;
   noOfDays = _noOfDays;
   notifyListeners();
  }

}
class TempGraphProvider extends ChangeNotifier{
  List<ChartSeries<TempData, int>> seriesTempData;
  int noOfDays;
  
  reinitialize(){
   seriesTempData = [];
   noOfDays = 0;
   notifyListeners();
  }

  tempChangeGraph(List<ChartSeries<TempData, int>> _seriesTempData, int _noOfDays){
   seriesTempData = _seriesTempData;
   noOfDays = _noOfDays;
   notifyListeners();
  }

}
class OpenManholeGraphProvider extends ChangeNotifier{
  List<ChartSeries<ManHoleData, int>> seriesManHoleData;
  int noOfDays;
  reinitialize(){
   seriesManHoleData = [];
   noOfDays = 0;
   notifyListeners();
  }

  openManholeChangeGraph(List<ChartSeries<ManHoleData, int>> _seriesManHoleData, int _noOfDays){
    seriesManHoleData = _seriesManHoleData;
    noOfDays = _noOfDays;
    notifyListeners();
  }

}