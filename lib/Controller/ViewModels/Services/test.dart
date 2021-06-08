import 'dart:async';
import 'package:provider/provider.dart';
import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Android/DrawerFragments/AddDevice/AddDevice.dart';
import 'package:Decon/View_Android/DrawerFragments/AboutVysion.dart';
import 'package:Decon/View_Android/OverflowChat/noticeBoard.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/View_Android/Bottom_Navigation/AllDevices.dart';
import 'package:Decon/View_Android/DrawerFragments/DeviceSetting/DeviceSetting.dart';
import 'package:Decon/View_Android/Bottom_Navigation/PeopleForAdmin.dart';
import 'package:Decon/View_Android/Bottom_Navigation/People_tabbar.dart';
import 'package:Decon/View_Android/DrawerFragments/Contact.dart';
import 'package:Decon/View_Android/DrawerFragments/HealthReport.dart';
import 'package:Decon/View_Android/DrawerFragments/Home.dart';
import 'package:Decon/View_Android/DrawerFragments/Statistics/Statistics.dart';
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