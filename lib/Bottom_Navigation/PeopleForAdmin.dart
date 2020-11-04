import 'package:Decon/Dialogs/Add_Admin.dart';
import 'package:Decon/Dialogs/Add_Delegates.dart';
import 'package:Decon/Bottom_Navigation/PeopleForManager.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/Services/Auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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

class PeopleForAdmin extends StatefulWidget {
  final BuildContext menuScreenContext;
  PeopleForAdmin({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _PeopleForAdmin createState() => _PeopleForAdmin();
}

const gc = Colors.black;
const tc = Color(0xff263238);

class _PeopleForAdmin extends State<PeopleForAdmin> {
  DelegateModel _delegateModel;
  _loadFromDatabase() async{
  DataSnapshot snapshot = await FirebaseDatabase.instance.reference().child("adminsList").orderByChild("cityCode").equalTo("C1").once();
  setState(() { 
  _delegateModel = DelegateModel.fromJsonForAdmin(snapshot.value);  
  });
  
  }
  @override
  void initState() {
    _loadFromDatabase();
    super.initState();
  }
  Future showDelegatesDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Add_Delegates();
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
         floatingActionButton: Auth.instance.post == "Admin"? FloatingActionButton(
                        backgroundColor: Color(0xff0099FF),
                        onPressed: () {
                          showDelegatesDialog(context);
                        },
                        child: Icon(
                          Icons.add,
                        ),
                      ):SizedBox(height: 0.0,),
        body: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: SizeConfig.v * 3),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(width: SizeConfig.b * 5),
            Expanded(
                flex: 3,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                    width: SizeConfig.b * 45.81,
                    child: Text("${_delegateModel?.name??""}",
                        style: TextStyle(
                            fontSize: SizeConfig.b * 5.1,
                            fontWeight: FontWeight.w600))),
                SizedBox(height: SizeConfig.v * 1),
                Text("${_delegateModel?.post??""}",
                    style: TextStyle(fontSize: SizeConfig.b * 3.56)),
                SizedBox(height: SizeConfig.v * 1),
                Row(children: [
                  Container(
                      height: SizeConfig.v * 2.57,
                      width: SizeConfig.b * 4.58,
                      child: IconButton(
                          onPressed: null,
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.call,
                              color: Colors.green, size: SizeConfig.b * 4))),
                  SizedBox(width: SizeConfig.b * 3),
                  Text("${_delegateModel?.numb??""}",
                      style: TextStyle(fontSize: SizeConfig.b * 3.56)),
                ])
              ]),
            ),
            Spacer(),
            Expanded(
                flex: 2,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("${_delegateModel?.cityName??""}",
                    style: TextStyle(
                        fontSize: SizeConfig.b * 4.7, fontWeight: FontWeight.w700)),
                SizedBox(height: SizeConfig.v * 0.5),
                Text("${_delegateModel?.stateName??""}",
                    style: TextStyle(
                        fontSize: SizeConfig.b * 4.7, fontWeight: FontWeight.w700)),
              ]),
            ),
            SizedBox(width: SizeConfig.b * 5),
          ]),
          SizedBox(height: SizeConfig.v * 1),
          Expanded(
            child: Container(
                color: Color(0xff263238),
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.b * 5.1,
                    vertical: SizeConfig.v * 2.85),
                child: Column(
                  children: [
                    Row(children: [
                      Text("Team",
                          style: TextStyle(
                              fontSize: SizeConfig.b * 5.1,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                      Spacer(),
                      Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.fromLTRB(SizeConfig.b * 5.09, 0, 0, 0),
                        width: SizeConfig.b * 50,
                        decoration: BoxDecoration(
                            color: Color(0xffDEE0E0),
                            borderRadius:
                                BorderRadius.circular(SizeConfig.b * 1)),
                        child: TextField(
                          style: TextStyle(fontSize: SizeConfig.b * 4),
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Search by Name/Contact',
                            hintStyle: TextStyle(fontSize: SizeConfig.b * 3.7),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: SizeConfig.v * 3),
                    Expanded(
                        child: SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: StreamBuilder<Event>(
                              stream: FirebaseDatabase.instance
                                                .reference()
                                                .child("cities/${Auth.instance.cityCode}/posts")
                                                .onValue,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                List<DelegateModel>
                                                    _listofdelegates = List();
                                                
                                                List<String>
                                                    _pendingRequestDelegates = Auth
                                                        .instance.pref
                                                        .getStringList(
                                                            "pendingDelegatesRequest");
                                                          
                                                snapshot.data.snapshot?.value
                                                    ?.forEach((key, value) {
                                                  Map _map = {};
                                                  String rangeofDevices =
                                                      value["rangeOfDeviceEx"];
                                                  if (rangeofDevices != "None")
                                                    rangeofDevices
                                                        .replaceAll("{", "")
                                                        .replaceAll("}", "")
                                                        .split(",")
                                                        .forEach((element) {
                                                      String key =
                                                          element.split(":")[0];
                                                      String val =
                                                          element.split(":")[1];
                                                      _map[key] = val;
                                                    });
                                                  _pendingRequestDelegates?.remove(value["phoneNo"].toString());
                                                  _listofdelegates.add(DelegateModel(
                                                      uid: key,
                                                      stateName:
                                                          value["stateName"],
                                                      rangeOfDeviceEx: _map,
                                                      cityName: value["cityName"],
                                                      numb: value["phoneNo"],
                                                      post: value["post"],
                                                      name: value["name"]));
                                                });  
                                return Column(
                                  children: [
                                    if (_pendingRequestDelegates!=null&& _pendingRequestDelegates?.length!=0)
                                                      Container(
                                                        color: Color(0xff0099FF),
                                                        width:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .width,
                                                        height:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "${_pendingRequestDelegates?.length} Pending Request",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                    ListView.builder(
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: _listofdelegates.length,
                                        itemBuilder: (BuildContext ctxt, int index) {
                                          return Column(children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0x35C4C4C4),
                                                  borderRadius: BorderRadius.circular(
                                                      SizeConfig.b * 1.2),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: SizeConfig.b * 5.1,
                                                    vertical: SizeConfig.v * 0.8),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Row(children: [
                                                        Container(
                                                            width: SizeConfig.b * 45,
                                                            child: Text(
                                                                _listofdelegates[index].name,
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize:
                                                                        SizeConfig.b *
                                                                            4.071,
                                                                    fontWeight: FontWeight
                                                                        .w400))),
                                                        Spacer(),
                                                        Text(_listofdelegates[index].post,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize:
                                                                    SizeConfig.b * 3.054,
                                                                fontWeight:
                                                                    FontWeight.w400)),
                                                      ]),
                                                      SizedBox(height: SizeConfig.v * 1),
                                                      Row(children: [
                                                        Container(
                                                            height: SizeConfig.b * 4,
                                                            width: SizeConfig.b * 4.58,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        SizeConfig.b *
                                                                            1.2),
                                                                color: Color(0x804ADB58)),
                                                            child: IconButton(
                                                                onPressed: null,
                                                                padding: EdgeInsets.zero,
                                                                icon: Icon(Icons.call,
                                                                    color: Colors.white,
                                                                    size: SizeConfig.b *
                                                                        3.5))),
                                                        SizedBox(width: SizeConfig.b * 3),
                                                        Text(_listofdelegates[index].numb,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize:
                                                                    SizeConfig.b * 3.56)),
                                                      ]),
                                                    ])),
                                            SizedBox(height: SizeConfig.v * 1),
                                          ]);
                                        }),
                                  ],
                                );
                                }else{
                                  return Center(
                                                  child:
                                                      Text('${snapshot.error}'),
                                                );
                                }     
                              }
                            )))
                  ],
                )),
          )
        ]),
      ),
    );
  }
}

