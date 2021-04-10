import 'dart:async';
import 'package:provider/provider.dart';
import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Android/DrawerFragments/5_AddDevice/AddDevice.dart';
import 'package:Decon/View_Android/DrawerFragments/6_AboutVysion.dart';
import 'package:Decon/View_Android/OverflowChat/noticeBoard.dart';
import 'package:Decon/Controller/Services/GlobalVariable.dart';
import 'package:Decon/View_Android/Bottom_Navigation/2_AllDevices.dart';
import 'package:Decon/View_Android/DrawerFragments/2_DeviceSetting/2_DeviceSetting.dart';
import 'package:Decon/View_Android/Bottom_Navigation/PeopleForAdmin.dart';
import 'package:Decon/View_Android/Bottom_Navigation/PeopleForManager.dart';
import 'package:Decon/View_Android/DrawerFragments/7_Contact.dart';
import 'package:Decon/View_Android/DrawerFragments/4_HealthReport.dart';
import 'package:Decon/View_Android/DrawerFragments/1_Home.dart';
import 'package:Decon/View_Android/DrawerFragments/3_Statistics/3_Statistics.dart';
//import 'package:Decon/Controller/Services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}
const gc= Colors.black;

const tc = Color(0xff263238);
class _TestPageState extends State<TestPage> {

   



  @override
    void initState() {
      print("cccccccccccccccccccccccc");
    print(context);
    print("cccccccccccccccccccccccc");
    // HomePageVM.instance.initialize(context);
   
      super.initState();
    }
  

  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("test"),),
      body: Center(
        child: Text("test"),
      ),
    );
  }
}