import 'package:Decon/Controller/Providers/People_provider.dart';
import 'package:Decon/Controller/ViewModels/people_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/View_Android/Bottom_Navigation/All_people.dart';
import 'package:Decon/View_Android/Dialogs/Add_Admin.dart';
import 'package:Decon/View_Android/Dialogs/Add_Manager.dart';
import 'package:Decon/View_Android/Dialogs/Replace_Admin.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
import 'package:Decon/View_Android/Dialogs/Replace_Manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PeopleTabBar extends StatefulWidget {
  final BuildContext menuScreenContext;
  PeopleTabBar({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _PeopleTabBar createState() => _PeopleTabBar();
}


class _PeopleTabBar extends State<PeopleTabBar> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<UserDetailModel> _listUserDetailModelAdmins = [];
  Map<String ,ClientDetailModel> _listClientDetailModel = {};
  List<UserDetailModel> _listUserDetailModelManager;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  } 

  Future showManagerDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Add_man();
        });
  }

  Future showAdminDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Add_admin();
        });
  }

  Future showReplaceAdminDialog(BuildContext context, String clientVisible, String uid) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Replace_Admin(
            clientVisible: clientVisible ,
            uid: uid,
          );
        });
  }
  
  Future showReplaceManagerDialog(BuildContext context, String clientVisible, String uid) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Replace_Manager(
            clientVisible: clientVisible ,
            uid: uid,
          );
        });
  }
  _getClientDetail(String clientCode, String uid) async{
   ClientDetailModel clientDetailModel = await PeopleVM.instance.getClientDetail(clientCode);
   _listClientDetailModel[uid] = (clientDetailModel);
   Provider.of<PeopleProvider>(context, listen: false).changeClientDetail(_listClientDetailModel);

  }

  Future showDeleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text('Delete user?'), actions: <Widget>[
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
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          TabBar(
              indicatorWeight: 2,
              indicatorColor: Color(0xff0099FF),
              labelPadding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.b * 0.76, vertical: 0),
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text(
                    'Managers',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.b * 5.09,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Tab(
                  child: Text(
                    'Admins',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.b * 5.09,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ]),
          Expanded(
              flex: 2,
              child:
                  new TabBarView(controller: _tabController, children: <Widget>[
                Scaffold(
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Color(0xff0099FF),
                    onPressed: () {
                      showManagerDialog(context);
                    },
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                  body: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(height: SizeConfig.v * 2),
                          Row(children: [
                            SizedBox(width: SizeConfig.b * 5),
                            Row(children: [
                              Icon(Icons.account_circle, color: Colors.black54),
                              SizedBox(width: SizeConfig.b * 2),
                              Text(
                                'Managers',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: SizeConfig.b * 5.09,
                                    fontWeight: FontWeight.w400),
                              )
                            ]),
                            Spacer(),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(
                                  SizeConfig.b * 5.09, 0, 0, 0),
                              width: SizeConfig.b * 53,
                              decoration: BoxDecoration(
                                  color: Color(0xffDEE0E0),
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.b * 1.1)),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    
                                  });
                                },
                                style: TextStyle(fontSize: SizeConfig.b * 4.3),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Search by Name/Contact',
                                  hintStyle:
                                      TextStyle(fontSize: SizeConfig.b * 4),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(width: SizeConfig.b * 5),
                          ]),
                          SizedBox(height: SizeConfig.v * 3),
                          Expanded(
                              child: SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  child: StreamBuilder<Event>(
                                      stream: FirebaseDatabase.instance.reference().child("managers").onValue,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          Map datamap = snapshot.data.snapshot.value;
                                          _listUserDetailModelManager = [];
                                          datamap?.forEach((key, value) {
                                            _listUserDetailModelManager.add(UserDetailModel.fromJson(key.toString(), value));
                                          });
                                        
                                        if(snapshot.data.snapshot.value!=null)
              
                                          return ListView.builder(
                                              physics: ScrollPhysics(),
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              itemCount: _listUserDetailModelManager.length,
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                return InkWell(
                                                  onLongPress: () {
                                                    {
                                                    showReplaceManagerDialog(
                                                        context,
                                                        _listUserDetailModelAdmins[index].clientsVisible,
                                                        _listUserDetailModelAdmins[index].key,
                                                        );
                                                  }
                                                  },
                                                  child: Column(children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Color(0xffECECEC),
                                                        borderRadius: BorderRadius.circular(SizeConfig.b * 1.2),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey.withOpacity(0.5),
                                                            spreadRadius: 2,
                                                            blurRadius: 3,
                                                            offset: Offset(0,2), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      margin: EdgeInsets.fromLTRB(SizeConfig.b *5.1,1,SizeConfig.b *5.1,1),
                                                      padding: EdgeInsets.fromLTRB(SizeConfig.b *5.1,SizeConfig.v * 1,SizeConfig.b *5.1,SizeConfig.v * 1),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              width:SizeConfig.b *48.5,
                                                              child: Text(
                                                                _listUserDetailModelManager[index].name,
                                                                style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: SizeConfig.b *4.071,
                                                                    fontWeight: FontWeight.w400 ),
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  _listUserDetailModelManager[index].phoneNo,
                                                                  style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize:SizeConfig.b *3.5),
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(SizeConfig.b *1.2),
                                                                    color: Color(0x804ADB58),
                                                                  ),
                                                                  height: SizeConfig.v *2.86,
                                                                  width: SizeConfig.b *5.1,
                                                                  child:IconButton(
                                                                    onPressed:null,
                                                                    padding:
                                                                        EdgeInsets.zero,
                                                                    icon: Icon(
                                                                        Icons.call,
                                                                        color: Colors.white,
                                                                        size: SizeConfig.b *4),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            SizeConfig.v * 1),
                                                  ]),
                                                );
                                              });
                                          else
                                            return AppConstant.noDataFound();     

                                        } else {
                                          if(snapshot.hasError)
                                            return Center(
                                                  child: Text('${snapshot.error}'),
                                                );
                                            else
                                            return AppConstant.circulerProgressIndicator();   
                                        }
                                      }))),
                        ],
                      )),
                ),
                Scaffold(
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Color(0xff0099FF),
                    onPressed: () {
                      showAdminDialog(context);
                    },
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                  body: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(height: SizeConfig.v * 2),
                          Row(
                            children: [
                              SizedBox(width: SizeConfig.b * 5),
                              Row(
                                children: [
                                  Icon(Icons.account_circle,
                                      color: Colors.black54),
                                  SizedBox(width: SizeConfig.b * 2),
                                  Text('Admin',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: SizeConfig.b * 5.09,
                                          fontWeight: FontWeight.w400))
                                ],
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(
                                    SizeConfig.b * 5.09, 0, 0, 0),
                                width: SizeConfig.b * 53,
                                decoration: BoxDecoration(
                                  color: Color(0xffDEE0E0),
                                  borderRadius:
                                      BorderRadius.circular(SizeConfig.b * 1),
                                ),
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      
                                    });
                                  },
                                  style:
                                      TextStyle(fontSize: SizeConfig.b * 4.3),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Search by Name/Contact',
                                    hintStyle:
                                        TextStyle(fontSize: SizeConfig.b * 4),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeConfig.b * 5),
                            ],
                          ),
                          SizedBox(height: SizeConfig.v * 3),
                          Expanded(
                              child: SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  child: StreamBuilder<Event>(
                                      stream: FirebaseDatabase.instance.reference().child("admins").onValue,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          Map datamap = snapshot.data.snapshot.value;
                                          _listUserDetailModelAdmins = [];
                                          datamap?.forEach((key, value) {
                                            UserDetailModel userDetailModel = UserDetailModel.fromJson(key.toString(), value); 
                                            _listUserDetailModelAdmins.add(userDetailModel);
                                            
                                          _getClientDetail(userDetailModel.clientsVisible, userDetailModel.key);
                                          });

                                        if(snapshot.data.snapshot.value!=null)
                                          
                                          return ListView.builder(
                                              physics: ScrollPhysics(),
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              itemCount: _listUserDetailModelAdmins.length,
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                return Consumer<PeopleProvider>(
                                                                builder: (context, model, child)=>(
                                                  InkWell(
                                                    onLongPress: () {
                                                      showReplaceAdminDialog(
                                                          context,
                                                          _listUserDetailModelAdmins[index].clientsVisible,
                                                          _listUserDetailModelAdmins[index].key,
                                                          );
                                                    },
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AllPeople(
                                                            clientCode:_listUserDetailModelAdmins[index].clientsVisible,
                                                            clientDetailModel: model.listClientDetailModel[_listUserDetailModelAdmins[index].key],
                                                                
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: Color(0xFFECECEC),
                                                            borderRadius: BorderRadius.circular(SizeConfig.b *1),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey.withOpacity(0.5),
                                                                spreadRadius: 2,
                                                                blurRadius: 3,
                                                                offset: Offset(0,2), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          margin: EdgeInsets.fromLTRB(SizeConfig.b *5.1,1,SizeConfig.b *5.1,1),
                                                          padding:EdgeInsets.fromLTRB(
                                                                  SizeConfig.b *5.1,
                                                                  SizeConfig.v *1,
                                                                  SizeConfig.b * 5.1,
                                                                  SizeConfig.v *1),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        width: SizeConfig.b *40.72,
                                                                        child:
                                                                            Text(_listUserDetailModelAdmins[index].name,
                                                                          style:TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: SizeConfig.b * 4.5,
                                                                            fontWeight: FontWeight.w700,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(height:SizeConfig.v *1),
                                                                      Text(_listUserDetailModelAdmins[index].delegate,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize: SizeConfig.b *3.1,
                                                                            fontWeight: FontWeight.w500),
                                                                      ),
                                                                      SizedBox(height:SizeConfig.v *1),
                                                                      Row(
                                                                          children: [
                                                                            Container(
                                                                              height:SizeConfig.v * 2.572,
                                                                               width: SizeConfig.b * 4.58,
                                                                              child:
                                                                                  IconButton(
                                                                                onPressed: null,
                                                                                padding: EdgeInsets.zero,
                                                                                icon: Icon(Icons.call, color: Colors.green, size: SizeConfig.b * 4),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                                width: SizeConfig.b * 2),
                                                                            Text(
                                                                              _listUserDetailModelAdmins[index].phoneNo,
                                                                              style:
                                                                                  TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: SizeConfig.b * 3.1,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ]),
                                                              ),
                                                              Spacer(),
                                                              Expanded(
                                                                flex: 1,
                                                                child: 
                                                                   Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                                      children: [
                                                                        Text("${model.listClientDetailModel[_listUserDetailModelAdmins[index].key]?.cityName??"Loading..."}",
                                                                          style:TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: SizeConfig.b *4.1,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: SizeConfig.v *1),
                                                                        Text("${model.listClientDetailModel[_listUserDetailModelAdmins[index].key]?.stateName??""}",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: SizeConfig.b * 3.0)),
                                                                      ]),
                                                                ),
                                                              
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height: SizeConfig.v * 1),
                                                      ],
                                                    ),
                                                  )
                                                                )
                                                );
                                              });
                                              else
                                               return AppConstant.noDataFound();     

                                        } else {
                                          if(snapshot.hasError)
                                            return Center(
                                                  child: Text('${snapshot.error}'),
                                                );
                                            else
                                            return AppConstant.circulerProgressIndicator();   
                                        }
                                      })))
                        ],
                      )),
                ),
              ])),
        ],
      ),
    );
  }
}
