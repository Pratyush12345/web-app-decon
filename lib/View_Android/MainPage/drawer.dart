import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Android/DrawerFragments/AboutVysion.dart';
import 'package:Decon/View_Android/DrawerFragments/AddDevice/AddDevice.dart';
import 'package:Decon/View_Android/DrawerFragments/Contact.dart';
import 'package:Decon/View_Android/DrawerFragments/DeviceSetting/DeviceSetting.dart';
import 'package:Decon/View_Android/DrawerFragments/HealthReport.dart';
import 'package:Decon/View_Android/DrawerFragments/Home.dart';
import 'package:Decon/View_Android/DrawerFragments/Statistics/Statistics.dart';
import 'package:Decon/View_Android/DrawerFragments/all_clients.dart';
import 'package:Decon/View_Android/MainPage/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
Future showErrorDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text('Are You Sure?'), actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop("Yes");
              },
              elevation: 5.0,
              child: Text('YES'),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop("No");
              },
              elevation: 5.0,
              child: Text('NO'),
            )
          ]);
        });
  }

    _onSelectedItem(int index, Widget widget) {
      HomePageVM.instance.isfromDrawer = true;
      HomePageVM.instance.selectedDrawerIndex = index;
      HomePageVM.instance.selectedDrawerWidget = widget;
      Provider.of<ChangeDrawerItems>(context, listen: false).changeDrawerItem();
      HomePageVM.instance.scafoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
     final drawerItems = [
      if(GlobalVar.strAccessLevel == "1")
      Item(
         title: Text("All Clients",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
         icon: Icon(
            Icons.pending,
            color: gc,
          ),
         screen: AllClients()
          ),
      
      Item(
         title: Text("Home",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
         icon: Icon(
            Icons.home,
            color: gc,
          ),
         screen: Home()
          ),
      Item(
         title: Text("Device Settings",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
         icon: Icon(
            Icons.settings,
            color: tc,
          ),
         screen: DeviceSettings(
          cityCode: HomePageVM.instance.getCityCode,
        )),
         
      Item(
         title: Text("Statistics",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
         icon: Icon(
            Icons.assessment,
            color: tc,
          ),
          screen: Stats(sheetURL: HomePageVM.instance.getSheetURL)
          ),
      Item(
         title: Text("Maintainence Report",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
         icon: Icon(
            Icons.build,
            color: tc,
          ),
          screen: HealthReport()),
      Item(
         title: Text("Add Devices",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
         icon: Icon(
            Icons.add,
            color: tc,
          ),
          screen: AddDevice() ),
      Item(
         title: Text("About Vysion",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
         icon: Icon(
            Icons.verified_user,
            color: tc,
          ),
          screen: AboutVysion() ),
      Item(
         title: Text("Contact Us",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
         icon: Icon(
            Icons.settings_phone,
            color: tc,
          ),
          screen: Contact() ),
      Item(
         title: Text("Log Out",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
         icon: Icon(
            Icons.logout,
            color: tc,
          )),
    ];
    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      if (i != drawerItems.length-1) {
        drawerOptions.add(ListTile(
          leading: drawerItems[i].icon,
          title: drawerItems[i].title,
          selected: i == HomePageVM.instance.selectedDrawerIndex,
          onTap: () {
            _onSelectedItem(i, drawerItems[i].screen);
          },
        ));
      } else {
        drawerOptions.add(ListTile(
          leading: drawerItems[i].icon,
          title: drawerItems[i].title,
          selected: i == HomePageVM.instance.selectedDrawerIndex,
          onTap: () {
            Navigator.of(context).pop();
            showErrorDialog(context).then((onValue) {
              if (onValue == "Yes") {
                Auth.instance.signOut();
              }
            });
          },
        ));
      }
    }
    SizeConfig().init(context);
    return Drawer(
        child: Container(
          color: Color(0xffF4F3F3),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                margin: EdgeInsets.fromLTRB(0, 0, 0, SizeConfig.v * 1.25),
                padding: EdgeInsets.fromLTRB(
                    SizeConfig.b * 1.2,
                    SizeConfig.v * 1.25,
                    SizeConfig.b * 0.8,
                    SizeConfig.v * 1.25),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: SizeConfig.b * 3),
                            CircleAvatar(
                              radius: SizeConfig.b * 11,
                              backgroundImage: AssetImage("assets/f.png"),
                            ),
                            SizedBox(width: SizeConfig.b * 3),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text("${GlobalVar.userDetail.name ?? ""}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: SizeConfig.b * 5.09)),
                                  SizedBox(height: SizeConfig.v * 1.5),
                                  Text(
                                      "${FirebaseAuth.instance.currentUser?.phoneNumber ?? ""}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: SizeConfig.b * 4.08)),
                                ]))
                          ]),
                    ]),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color(0xff263238),
                      Color(0xff005A87),
                    ])),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: drawerOptions,
              )
            ],
          ),
        ),
      );
  }
}