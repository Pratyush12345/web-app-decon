import 'dart:async';
import 'package:Decon/DeconManager/CitiesList.dart';
import 'package:Decon/DrawerFragments/5_AddDevice/AddDevice.dart';
import 'package:Decon/DrawerFragments/6_AboutVysion.dart';
import 'package:Decon/Services/GlobalVariable.dart';
import 'package:Decon/Bottom_Navigation/2_AllDevices.dart';
import 'package:Decon/DrawerFragments/2_DeviceSetting/2_DeviceSetting.dart';
import 'package:Decon/Bottom_Navigation/PeopleForAdmin.dart';
import 'package:Decon/Bottom_Navigation/PeopleForManager.dart';
import 'package:Decon/DrawerFragments/7_Contact.dart';
import 'package:Decon/DrawerFragments/4_HealthReport.dart';
import 'package:Decon/DrawerFragments/1_Home.dart';
import 'package:Decon/DrawerFragments/3_Statistics/3_Statistics.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/Services/Auth.dart';
import 'package:Decon/Services/SplashCarousel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Item {
  Text title;
  Icon icon;
  Item(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  bool _isfromDrawer = true;
  HomePageState();

  List<DeviceData> _allDeviceData = [];
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  StreamSubscription<Event> _onDataAddedSubscription;
  StreamSubscription<Event> _onDataChangedSubscription;
  Query _query;
  Widget middleContainer;
  int _selectedDrawerIndex = 0, _currentIndex = 0;
  int simStatus = 0, countbattery=0, counttemp=0;
  String _itemSelected; List<String> list =[];
  Map _citiesMap;  String ccode = Auth.instance.cityCode;
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  String sheetURL;
  _getBottomNavItem(int position) {
    switch (position) {
      case 0:
        return Home(allDeviceData: _allDeviceData);
        break;
      case 1:
        return AllDevices(
          allDeviceData: _allDeviceData,
          sheetURL: sheetURL,
        );
      case 2:
        if(Auth.instance.post=="Manager")
        return People();
        else
        return PeopleForAdmin(fromManager: false, cityCode: ccode,);
    }
  }

  _getDrawerItemWidget(int position) {
    switch (position) {
      case 0:
        return Home(allDeviceData: _allDeviceData );
        break;
      case 1:
        return DeviceSettings(allDevicesList: _allDeviceData,cityCode: ccode, );
        break;
      case 2:
        return Stats(allDeviceData: _allDeviceData, sheetURL: sheetURL);
        break;
      case 3:
        return HealthReport();
        break;
      case 4:
        return AddDevice(cityCode: ccode,);
        break;
      case 5:
        return AboutVysion();
        break;
      case 6:
        return Contact();
        break;
      default:
        return "Error Ocurred";
    }
  }

  _onSelectedItem(int index) {
    setState(() {
      _isfromDrawer = true;
      _selectedDrawerIndex = index;
    });
    _scafoldKey.currentState.openEndDrawer();
    
  }
  _loadDeviceSettings(String ccode) async{
    DataSnapshot snapshot = await FirebaseDatabase.instance
        .reference()
        .child("cities/$ccode/DeviceSettings")
        .once(); 
    DeviceSettingModel deviceSettingModel =
        DeviceSettingModel.fromSnapshot(snapshot);
    Auth.instance.manholedepth = double.parse( deviceSettingModel.manholedepth);
    Auth.instance.criticalLevelAbove = double.parse(deviceSettingModel.criticallevelabove);
    Auth.instance.informativelevelabove = double.parse(deviceSettingModel.informativelevelabove);
    Auth.instance.normalLevelabove = double.parse(deviceSettingModel.nomrallevelabove);
    Auth.instance.groundlevelbelow = double.parse(deviceSettingModel.groundlevelbelow);
    Auth.instance.tempThresholdValue = double.parse(deviceSettingModel.tempthresholdvalue);
    Auth.instance.batteryThresholdvalue = double.parse(deviceSettingModel.batterythresholdvalue);
    
  }
  _getsheetURL(String cityCode) async{
   DataSnapshot snapshot = await FirebaseDatabase.instance
        .reference()
        .child("cities/$cityCode/sheetURL")
        .once();
   sheetURL = snapshot.value.toString();
  }
  _setQuery(String cityCode) async{
  
    if(Auth.instance.post=="Manager"){
     _query = _database.reference().child("cities/$cityCode/Series/S1/Devices");
     await _loadDeviceSettings(cityCode);
      _getsheetURL(cityCode);      
    }else{
    _query = _database.reference().child("cities/$cityCode/Series/S1/Devices");
    _getsheetURL(cityCode);
    }
    _onDataAddedSubscription = _query.onChildAdded.listen(onDeviceAdded);
    _onDataChangedSubscription = _query.onChildChanged.listen(onDeviceChanged);
     _allDeviceData = new List();
    
  }
  _getCitiesList() async{
   DataSnapshot citiesSnapshot =await FirebaseDatabase.instance.reference().child("citiesList").once();
   _citiesMap = citiesSnapshot.value;
   _citiesMap.forEach((key, value) { 
     list.add(value);
   });
   print(list);
   setState(() {  
   });
   
  }
  @override
  void initState() {
    if(Auth.instance.post=="Manager"){
     _getCitiesList();
     _setQuery("C0");
    }
    else{
    _setQuery(Auth.instance.cityCode??"C0");
    }
      
    super.initState();
  }

  @override
  void dispose() {
    _onDataChangedSubscription.cancel();
    _onDataAddedSubscription.cancel();
    super.dispose();
  }

  onDeviceAdded(Event event) {
    setState(() {
  
      _allDeviceData.add(DeviceData.fromSnapshot(event.snapshot));
    });
    _allDeviceData.sort((a,b)=>int.parse(a.id.split("_")[2].substring(1,2) ).compareTo(int.parse(b.id.split("_")[2].substring(1,2))));
    _allDeviceData
        .forEach((device) => print("Device is ${device.id.split("_")[2]}"));
  }

  onDeviceChanged(Event event) {
    var oldKey = _allDeviceData.singleWhere((entry) {
      return entry.id.split("_")[2] == event.snapshot.key;
    });
    setState(() {
      _allDeviceData[_allDeviceData.indexOf(oldKey)] =
          DeviceData.fromSnapshot(event.snapshot);
    });
  }

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

  @override
  Widget build(BuildContext context) {
    
    SizeConfig().init(context);
    final drawerItems = [
      Item(
          Text("Home",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
          Icon(
            Icons.home,
            color: gc,
          )),
      Item(
          Text("Device Settings",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
          Icon(
            Icons.settings,
            color: tc,
          )),
      Item(
          Text("Statistics",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
          Icon(
            Icons.assessment,
            color: tc,
          )),
      Item(
          Text("Maintainence Report",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
          Icon(
            Icons.build,
            color: tc,
          )),
      Item(
          Text("Add Devices",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
          Icon(
            Icons.add,
            color: tc,
          )),
      Item(
          Text("About Vysion",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
          Icon(
            Icons.verified_user,
            color: tc,
          )),
      Item(
          Text("Contact Us",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
          Icon(
            Icons.settings_phone,
            color: tc,
          )),
      Item(
          Text("Log Out",
              style: TextStyle(
                  color: gc,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.b * 4.08)),
          Icon(
            Icons.person,
            color: tc,
          )),
    ];
    final bottomNavTitiles = ["Home", "Devices", "Teams"];
    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      if (i != 7) {
        drawerOptions.add(ListTile(
          leading: drawerItems[i].icon,
          title: drawerItems[i].title,
          selected: i == _selectedDrawerIndex,
          onTap: () {
            _onSelectedItem(i);
          },
        ));
      } else {
        drawerOptions.add(ListTile(
          leading: drawerItems[i].icon,
          title: drawerItems[i].title,
          selected: i == _selectedDrawerIndex,
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

    return Scaffold(
      key: _scafoldKey,
        appBar: AppBar(
    backgroundColor: Colors.white,     
    leading: IconButton(icon: Icon(Icons.menu, color: Colors.grey,), onPressed: (){
      _scafoldKey.currentState.openDrawer();
    }),      
    title: Auth.instance.post=="Manager"?
         Container(
           alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(SizeConfig.b * 3.82, 0, 0, 0),
          height: SizeConfig.v * 5,
          width: SizeConfig.b * 80,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 222, 224, 224),
              borderRadius: BorderRadius.circular(SizeConfig.b * 2.7)),
          
           child: DropdownButton<String>(
                  elevation: 8,
                  dropdownColor: Color(0xff263238),
                  isDense: false,
                  underline: SizedBox(height: 0.0,),
                  items: list.map((dropDownStringitem) {
                    return DropdownMenuItem<String>(
                       
                      value: dropDownStringitem,
                      child: Container(
                    
                        padding: EdgeInsets.fromLTRB(12.0,4.0,4.0,4.0),
                        width: SizeConfig.b*80,
                        height: SizeConfig.v*4,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 222, 224, 224).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Text(
                          dropDownStringitem,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValueSelected) {
                    _itemSelected = newValueSelected;
                    
                    
                    _citiesMap.forEach((key, value) { 
                      if(value == newValueSelected)
                      ccode = key;
                    });
                    VariableGlobal.iscitychanged = true;
                    setState(() {
                     context = context;
                    _setQuery(ccode);  
                    });  
                  },
                  isExpanded: true,
                  hint: Text("Dummy City",
                  style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87
                          ),),
                  value: _itemSelected ?? null,
                ),
         )
        :Text("${Auth.instance.cityName??"Demo City"}",
        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87
                          ),),
    actions: [
      if(Auth.instance.post == "Manager")
      IconButton(icon: Icon(Icons.add_box, color: Colors.black,), onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SplashCarousel()));
        // return Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => FlareLoading(
        //         name: 'assets/gurucool.flr',
        //         onSuccess: (_) {
        //           Navigator.of(context).pop();
        //           return "done";
        //         },
        //         onError: (_, __) {},
        //         startAnimation: 'animation',
        //         until: () => Future.delayed(Duration(seconds: 10)),
        //       ),
        //     ),
        //   );

      })
    ],    
        ),
        drawer: Drawer(            
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
                              Text("${Auth.instance.displayName??""}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeConfig.b * 5.09)),
                              SizedBox(height: SizeConfig.v * 1.5),
                              Text("${FirebaseAuth.instance.currentUser?.phoneNumber??""}",
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
        ),
        body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: _isfromDrawer
          ? _getDrawerItemWidget(_selectedDrawerIndex)
          : _getBottomNavItem(_currentIndex)),
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
        ),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.memory,
          ),
          title: Text('Devices')),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.people,
          ),
          title: Text('Team')),
    ],
    onTap: (index) {
      setState(() {
        _isfromDrawer = false;
        _currentIndex = index;
        // _showTabs(_currentIndex);
      });
    },
        ),
      );
  }
}

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

const gc = Colors.black;
const tc = Color(0xff263238);
