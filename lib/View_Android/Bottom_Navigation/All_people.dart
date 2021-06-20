import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/ViewModels/all_people_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/View_Android/Dialogs/Add_Delegates.dart';
import 'package:Decon/Models/Models.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class AllPeople extends StatefulWidget {
  final String clientCode; 
  final ClientDetailModel clientDetailModel;
  AllPeople( 
      {Key key, @required this.clientCode, @required  this.clientDetailModel})
      : super(key: key);

  @override
  _AllPeople createState() => _AllPeople();
}


class _AllPeople extends State<AllPeople> {
  List<UserDetailModel> _listOfAdminTeam = [];
  List<UserDetailModel> _listOfManagerTeam = [];
                                                          
  _initialize() async{
    AllPeopleVM.instance.init();
    _listOfAdminTeam = [];
    _listOfManagerTeam = [];
    await AllPeopleVM.instance.getManagerDetail(widget.clientDetailModel?.selectedManager);
    await AllPeopleVM.instance.getAdminDetail(widget.clientDetailModel?.selectedAdmin);
    setState(() { });
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  Future showDelegatesDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Add_Delegates(list: GlobalVar.strAccessLevel=="2" ? _listOfManagerTeam : _listOfAdminTeam,);
        });
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
    return Scaffold(
      appBar: AppBar(
              title: Text("Team"),
            ),
      floatingActionButton: GlobalVar.strAccessLevel == "2" || GlobalVar.strAccessLevel == "3"
          ? FloatingActionButton(
              backgroundColor: Color(0xff0099FF),
              onPressed: () {
                showDelegatesDialog(context);
              },
              child: Icon(
                Icons.add,
              ),
            )
          : SizedBox(
              height: 0.0,
            ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.v * 3),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              SizedBox(width: SizeConfig.b * 5),
              Expanded(
                flex: 3,
                child:
                   AllPeopleVM.instance.managerDetailModel == null? AppConstant.circulerProgressIndicator():
                   AllPeopleVM.instance.managerDetailModel.key == null? AppConstant.noDataFound(): 
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.b * 45.81,
                        child: Text(
                          "${AllPeopleVM.instance.managerDetailModel.name??""}",
                          style: TextStyle(
                              fontSize: SizeConfig.b * 5.1,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: SizeConfig.v * 1),
                      Text(
                          "${AllPeopleVM.instance.managerDetailModel.post??""}",
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
                                    color: Colors.green,
                                    size: SizeConfig.b * 4))),
                        SizedBox(width: SizeConfig.b * 3),
                        Text(
                            "${AllPeopleVM.instance.managerDetailModel.phoneNo??""}",
                            style: TextStyle(fontSize: SizeConfig.b * 3.56)),
                      ])
                    ]),
              ),
              Spacer(),
              Expanded(
                flex: 2,
                child: widget.clientDetailModel == null? AppConstant.circulerProgressIndicator():
                   widget.clientDetailModel.cityName == null? AppConstant.noDataFound(): 
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.clientDetailModel.cityName ??""}",
                          style: TextStyle(
                              fontSize: SizeConfig.b * 4.7,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: SizeConfig.v * 0.5),
                      Text("${widget.clientDetailModel.stateName ??""}",
                          style: TextStyle(
                              fontSize: SizeConfig.b * 4.7,
                              fontWeight: FontWeight.w700)),
                    ]),
              ),
              SizedBox(width: SizeConfig.b * 5),
            ]),
            SizedBox(width: SizeConfig.b * 5),
            
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              SizedBox(width: SizeConfig.b * 5),
              Expanded(
                flex: 3,
                child:
                   AllPeopleVM.instance.adminDetailModel == null? AppConstant.circulerProgressIndicator():
                   AllPeopleVM.instance.adminDetailModel.key == null? AppConstant.noDataFound(): 
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.b * 45.81,
                        child: Text(
                          "${AllPeopleVM.instance.adminDetailModel.name??""}",
                          style: TextStyle(
                              fontSize: SizeConfig.b * 5.1,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: SizeConfig.v * 1),
                      Text(
                          "${AllPeopleVM.instance.adminDetailModel.delegate??""}",
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
                                    color: Colors.green,
                                    size: SizeConfig.b * 4))),
                        SizedBox(width: SizeConfig.b * 3),
                        Text(
                            "${AllPeopleVM.instance.adminDetailModel.phoneNo??""}",
                            style: TextStyle(fontSize: SizeConfig.b * 3.56)),
                      ])
                    ]),
              ),
              Spacer(),
              Expanded(
                flex: 2,
                child: widget.clientDetailModel == null? AppConstant.circulerProgressIndicator():
                   widget.clientDetailModel.cityName == null? AppConstant.noDataFound(): 
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.clientDetailModel.cityName ??""}",
                          style: TextStyle(
                              fontSize: SizeConfig.b * 4.7,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: SizeConfig.v * 0.5),
                      Text("${widget.clientDetailModel.stateName ??""}",
                          style: TextStyle(
                              fontSize: SizeConfig.b * 4.7,
                              fontWeight: FontWeight.w700)),
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
                      Text("Manager Team",
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
                          stream: FirebaseDatabase.instance.reference().child("managerTeam").orderByChild("headUid").equalTo("${widget.clientDetailModel?.selectedManager}").onValue,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                                (snapshot.data.snapshot.value as Map)?.forEach((key, value) { 
                                  _listOfManagerTeam.add(UserDetailModel.fromJson(key, value));
                                });
                              if(snapshot.data.snapshot.value!=null)
                              return ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: _listOfManagerTeam.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return InkWell(
                                      onLongPress: () {
                                        if(GlobalVar.strAccessLevel == "2")
                                        showDeleteDialog(context).then((value) async {
                                        
                                          if (value == "Yes") {
                                              FirebaseDatabase.instance.reference().child("managerTeam/${_listOfManagerTeam[index].key}").remove(); 
                                          }
                                        });
                                      },
                                      child: Column(children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Color(0x35C4C4C4),
                                              borderRadius: BorderRadius.circular(SizeConfig.b * 1.2),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: SizeConfig.b * 5.1,
                                                vertical: SizeConfig.v * 0.8),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Container(
                                                        width: SizeConfig.b * 45,
                                                        child: Text(
                                                            _listOfManagerTeam[index].name,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: SizeConfig.b * 4.071,
                                                                fontWeight: FontWeight.w400))),
                                                    Spacer(),
                                                    Text( _listOfManagerTeam[index].post.split("@")[0],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:SizeConfig.b *3.054,
                                                            fontWeight:FontWeight.w400)),
                                                  ]),
                                                  SizedBox(height: SizeConfig.v * 1),
                                                  Row(children: [
                                                    Container(
                                                        height:SizeConfig.b * 4,
                                                        width:SizeConfig.b * 4.58,
                                                        decoration: BoxDecoration(
                                                            borderRadius:BorderRadius.circular(SizeConfig.b *1.2),
                                                            color: Color(0x804ADB58)),
                                                        child: IconButton(
                                                            onPressed: null,
                                                            padding:EdgeInsets.zero,
                                                            icon: Icon(
                                                                Icons.call,
                                                                color: Colors.white,
                                                                size: SizeConfig.b *3.5))),
                                                    SizedBox(
                                                        width:SizeConfig.b * 3),
                                                    Text(_listOfManagerTeam[index].phoneNo,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:SizeConfig.b *3.56)),
                                                  ]),
                                                ])),
                                        SizedBox(height: SizeConfig.v * 1),
                                      ]),
                                    );
                                  });  else
                                return AppConstant.whitenoDataFound();
                            }
                            else{
                              if(snapshot.hasError)
                              return Center(
                                    child: Text('${snapshot.error}'),
                                  );
                              else
                              return AppConstant.circulerProgressIndicator();   
                            }
                          },
                        ),
                      ),
                    ),
                    Row(children: [
                      Text("Admin Team",
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
                          stream: FirebaseDatabase.instance.reference().child("adminTeam").orderByChild("headUid").equalTo("${widget.clientDetailModel?.selectedAdmin}").onValue,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                                (snapshot.data.snapshot.value as Map)?.forEach((key, value) { 
                                  _listOfAdminTeam.add(UserDetailModel.fromJson(key, value));
                                });
                              if(snapshot.data.snapshot.value!=null)
                              return ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: _listOfAdminTeam.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return InkWell(
                                      onLongPress: () {
                                        if(GlobalVar.strAccessLevel == "3")
                                        showDeleteDialog(context).then((value) async {
                                        
                                          if (value == "Yes") {
                                              FirebaseDatabase.instance.reference().child("adminTeam/${_listOfAdminTeam[index].key}").remove(); 
                                          }
                                        });
                                      },
                                      child: Column(children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Color(0x35C4C4C4),
                                              borderRadius: BorderRadius.circular(SizeConfig.b * 1.2),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: SizeConfig.b * 5.1,
                                                vertical: SizeConfig.v * 0.8),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Container(
                                                        width: SizeConfig.b * 45,
                                                        child: Text(
                                                            _listOfAdminTeam[index].name,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: SizeConfig.b * 4.071,
                                                                fontWeight: FontWeight.w400))),
                                                    Spacer(),
                                                    Text( _listOfAdminTeam[index].post.split("@")[0],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:SizeConfig.b *3.054,
                                                            fontWeight:FontWeight.w400)),
                                                  ]),
                                                  SizedBox(height: SizeConfig.v * 1),
                                                  Row(children: [
                                                    Container(
                                                        height:SizeConfig.b * 4,
                                                        width:SizeConfig.b * 4.58,
                                                        decoration: BoxDecoration(
                                                            borderRadius:BorderRadius.circular(SizeConfig.b *1.2),
                                                            color: Color(0x804ADB58)),
                                                        child: IconButton(
                                                            onPressed: null,
                                                            padding:EdgeInsets.zero,
                                                            icon: Icon(
                                                                Icons.call,
                                                                color: Colors.white,
                                                                size: SizeConfig.b *3.5))),
                                                    SizedBox(
                                                        width:SizeConfig.b * 3),
                                                    Text(_listOfAdminTeam[index].phoneNo,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:SizeConfig.b *3.56)),
                                                  ]),
                                                ])),
                                        SizedBox(height: SizeConfig.v * 1),
                                      ]),
                                    );
                                  });  else
                                return AppConstant.whitenoDataFound();
                            }
                            else{
                              if(snapshot.hasError)
                              return Center(
                                    child: Text('${snapshot.error}'),
                                  );
                              else
                              return AppConstant.circulerProgressIndicator();   
                            }
                          },
                        ),
                      ),
                    ),

                    
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
