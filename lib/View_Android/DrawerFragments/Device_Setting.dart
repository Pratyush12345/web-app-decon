import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceSetting  extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeSeries>(
      builder: (context, _,child){
        if(HomePageVM.instance.getSeriesCode != null || HomePageVM.instance.getSeriesCode != "" )
        return GlobalVar.seriesMap[HomePageVM.instance.getSeriesCode].deviceSetting;
        else
        return AppConstant.noDataFound();
      }
       
      );
  }
}