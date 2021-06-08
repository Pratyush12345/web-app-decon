import 'dart:async';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Consts/client_not_found.dart';
import 'package:Decon/View_Android/MainPage/drawer.dart';
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
import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  
  int _currentIndex=  0;
  String _itemSelected;
  
  _getBottomNavItem(int position) {
  
    switch (position) {
      case 0:
        return Home();
        break;
      case 1:
        return AllDevices(
          sheetURL: HomePageVM.instance.getSheetURL,
        );
      case 2:
        if (GlobalVar.strAccessLevel == "1")
          return PeopleTabBar();
        else
          return PeopleForAdmin(
            fromManager: false,
            cityCode: HomePageVM.instance.getCityCode,
          );
    }
  }

  @override
  void initState() {
    HomePageVM.instance.initialize(context);
    super.initState();
  }

  @override
  void dispose() {
    HomePageVM.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: HomePageVM.instance.scafoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.grey,
            ),
            onPressed: () {
              HomePageVM.instance.scafoldKey.currentState.openDrawer();
            }),
        title: GlobalVar.strAccessLevel != null
            ?  Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(SizeConfig.b * 3.0, 0, 0, 0),
                  height: SizeConfig.v * 5,
                  width: SizeConfig.b * 80,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 222, 224, 224),
                      borderRadius: BorderRadius.circular(SizeConfig.b * 2.7)),
                  child: 
                    Consumer<ChangeWhenGetClientsList>(
                 builder: (context, object,child ){
                  return
                    Consumer<ChangeCity>(
                      builder: (context, changeList, child)=>
                      object.clientsMap == null? AppConstant.circulerProgressIndicator():
                      object.clientsMap.isEmpty? AppConstant.addClient():
            
                        DropdownButton<String>(
                      icon: Icon(Icons.arrow_drop_down_rounded),
                      elevation: 8,
                      dropdownColor: Color(0xff263238),
                      isDense: false,
                      underline: SizedBox(
                        height: 0.0,
                      ),
                      items: object.clientsMap.values.map((dropDownStringitem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringitem,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(12.0, 8.0, 4.0, 4.0),
                            width: SizeConfig.b * 80,
                            height: SizeConfig.v * 4,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 222, 224, 224)
                                    .withOpacity(0.3),
                                borderRadius:
                                    BorderRadius.circular(SizeConfig.b * 2.7)),
                            child: Text(
                              dropDownStringitem,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValueSelected) {
                        _itemSelected = newValueSelected;
                        Provider.of<ChangeCity>(context, listen: false).reinitialize();

                        object.clientsMap.forEach((key, value) {
                          
                          if (value == newValueSelected) HomePageVM.instance.setCityCode = key;
                        });
                        GlobalVar.isclientchanged = true;
                        HomePageVM.instance.callSetQuery();
                      },
                      isExpanded: true,
                      hint: Text(
                        "Demo Client",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black87),
                      ),
                      value: _itemSelected ?? null,
                  ),
                    );},
                ),
            )
            : Text(
                "Demo Client",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.black87),
              ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add_box,
                color: Colors.black,
              ),
              onPressed: () {
                if (context != null)
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SplashCarousel())
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NoticeBoard(
                            cityMap: HomePageVM.instance.getCitiesMap,
                          )));
              })
        ],
      ),
      drawer: DrawerWidget(),
      body: Consumer<ChangeWhenGetClientsList>(
        builder: (context, model, child)=> 
            model.clientsMap == null? AppConstant.circulerProgressIndicator():
            model.clientsMap.isEmpty? ClientsNotFound():
            Consumer<ChangeDrawerItems>(
              builder: (context, _, child)=>
              Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: HomePageVM.instance.isfromDrawer
                  ? HomePageVM.instance.selectedDrawerWidget
                  : _getBottomNavItem(_currentIndex)),
            ),
      ),

        bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        selectedFontSize: 14.0,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff263238),

        iconSize: 20.0,
        //unselectedFontSize: 11.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: SizeConfig.screenWidth * 23 / 360,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.memory,
                size: SizeConfig.screenWidth * 23 / 360,
              ),
              label: 'Devices'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                size: SizeConfig.screenWidth * 23 / 360,
              ),
              label: 'Team'),
        ],
        onTap: (index) {
          setState(() {
            HomePageVM.instance.isfromDrawer = false;
            _currentIndex = index;
          });
        },
      ),
    );
  }
}


const gc = Colors.black;
const tc = Color(0xff263238);
