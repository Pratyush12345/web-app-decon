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
  final TextEditingController search = TextEditingController();
                                                        
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
          return Add_Delegates(list: GlobalVar.strAccessLevel=="2" ? _listOfManagerTeam : _listOfAdminTeam,
          adminDetail: AllPeopleVM.instance.adminDetailModel);
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
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Scaffold(
      appBar: AppBar(
              title: Text(
                widget.clientDetailModel == null? AppConstant.circulerProgressIndicator():
                widget.clientDetailModel.cityName == null? AppConstant.noDataFound(): 
                
                "${widget.clientDetailModel.clientName}"),
            ),
      floatingActionButton:GlobalVar.strAccessLevel == "1" || GlobalVar.strAccessLevel == "2" || GlobalVar.strAccessLevel == "3"
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
      body: SingleChildScrollView(
         
        padding: EdgeInsets.symmetric(horizontal: b * 22),
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh(18),
              Container(
                alignment: Alignment.center,
                width: b * 340,
                decoration: BoxDecoration(
                  border: Border.all(color: dc, width: 0.5),
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(b * 60),
                ),
                child: TextField(
                  controller: search,
                  style: TextStyle(fontSize: b * 14, color: dc),
                  decoration: InputDecoration(
                    prefixIcon: InkWell(
                      child: Icon(Icons.search, color: Colors.black),
                      onTap: null,
                    ),
                    isDense: true,
                    isCollapsed: true,
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 40, maxHeight: 24),
                    hintText: 'Search by Name',
                    hintStyle: TextStyle(
                      fontSize: b * 14,
                      color: Color(0xff858585),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: h * 12, horizontal: b * 13),
                    border: InputBorder.none,
                  ),
                ),
              ),
              
            sh(25),
              Text(
                "Manager",
                style: txtS(dc, 14, FontWeight.w400),
              ),
              sh(8),
              Container(
                margin: EdgeInsets.only(bottom: h * 8),
                padding: EdgeInsets.symmetric(
                    vertical: h * 14.45, horizontal: b * 17),
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(b * 10),
                  border: Border.all(
                    color: Color(0xff065e87),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: h * 46,
                      width: b * 46,
                      decoration: BoxDecoration(
                        color: Color(0xff6d6d6d),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Spacer(),
                    AllPeopleVM.instance.managerDetailModel == null? AppConstant.circulerProgressIndicator():
                   AllPeopleVM.instance.managerDetailModel.key == null? AppConstant.noDataFound(): 
                   
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${AllPeopleVM.instance.managerDetailModel.name??""}",
                          style:
                              txtS(Color(0xff065e87), 15.51, FontWeight.w500),
                        ),
                        Text(
                          "${AllPeopleVM.instance.managerDetailModel.phoneNo??""}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              txtS(Color(0xff858585), 11.63, FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
            sh(16),
              Text(
                "Admin",
                style: txtS(dc, 14, FontWeight.w400),
              ),
              sh(8),
              Container(
                margin: EdgeInsets.only(bottom: h * 8),
                padding: EdgeInsets.symmetric(
                    vertical: h * 14.45, horizontal: b * 17),
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(b * 10),
                  border: Border.all(
                    color: Color(0xff065e87),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: h * 46,
                      width: b * 46,
                      decoration: BoxDecoration(
                        color: Color(0xff6d6d6d),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Spacer(),
                    AllPeopleVM.instance.adminDetailModel == null? AppConstant.circulerProgressIndicator():
                   AllPeopleVM.instance.adminDetailModel.key == null? AppConstant.noDataFound(): 
                   
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${AllPeopleVM.instance.adminDetailModel.name??""}",
                          style:
                              txtS(Color(0xff065e87), 15.51, FontWeight.w500),
                        ),
                        Text(
                          "${AllPeopleVM.instance.adminDetailModel.delegate??""}",
                          style:
                              txtS(Color(0xff065e87), 15.51, FontWeight.w500),
                        ),
                        Text(
                          "${AllPeopleVM.instance.adminDetailModel.phoneNo??""}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              txtS(Color(0xff858585), 11.63, FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
            SizedBox(width: SizeConfig.b * 5),
            Row(
                children: [
                  Text(
                    "Manager Team",
                    style: txtS(dc, 13.57, FontWeight.w400),
                  ),
                  Spacer(),
                  Text(
                    "Total:${_listOfAdminTeam?.length??0}",
                    style: txtS(Color(0xff858585), 12, FontWeight.w400),
                  ),
                ],
              ),
            SizedBox(height: SizeConfig.v * 1),
            Container(
              height: h *200,
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
                    
                    child: Container(
                      margin: EdgeInsets.only(bottom: h * 8),
                      padding: EdgeInsets.symmetric(
                          vertical: h * 11, horizontal: b * 17),
                      decoration: BoxDecoration(
                        color: Color(0xfff1f1f1),
                        borderRadius: BorderRadius.circular(b * 10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: h * 36,
                            width: b * 36,
                            decoration: BoxDecoration(
                              color: Color(0xff6d6d6d),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: b * 10),
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_listOfManagerTeam[index].name}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: txtS(dc, 15.51, FontWeight.w400),
                                ),
                                Text(
                                   _listOfManagerTeam[index].post.split("@")[0],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: txtS(Color(0xff858585), 11.63,
                                      FontWeight.w400),
                                ),
                                Text(
                                  _listOfManagerTeam[index].phoneNo,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: txtS(Color(0xff858585), 11.63,
                                      FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ); 
                             
                            });  else
                          return AppConstant.noDataFound();
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
            SizedBox(height: 10.0,),
            Row(
                children: [
                  Text(
                    "Admin Team",
                    style: txtS(dc, 13.57, FontWeight.w400),
                  ),
                  Spacer(),
                  Text(
                    "Total:${_listOfAdminTeam?.length??0}",
                    style: txtS(Color(0xff858585), 12, FontWeight.w400),
                  ),
                ],
              ),
            Container(
              height: h *200,
              child:StreamBuilder<Event>(
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
                    
                    child: Container(
                      margin: EdgeInsets.only(bottom: h * 8),
                      padding: EdgeInsets.symmetric(
                          vertical: h * 11, horizontal: b * 17),
                      decoration: BoxDecoration(
                        color: Color(0xfff1f1f1),
                        borderRadius: BorderRadius.circular(b * 10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: h * 36,
                            width: b * 36,
                            decoration: BoxDecoration(
                              color: Color(0xff6d6d6d),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: b * 10),
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _listOfAdminTeam[index].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: txtS(dc, 15.51, FontWeight.w400),
                                ),
                                Text(
                                  _listOfAdminTeam[index].post.split("@")[0],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: txtS(Color(0xff858585), 11.63,
                                      FontWeight.w400),
                                ),
                                Text(
                                  _listOfAdminTeam[index].phoneNo,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: txtS(Color(0xff858585), 11.63,
                                      FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                        });  else
                      return AppConstant.noDataFound();
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
            )
          ],
        ),
      ),
    );
  }
}
