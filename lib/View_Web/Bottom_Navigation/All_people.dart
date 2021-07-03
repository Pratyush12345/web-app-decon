import 'package:Decon/Controller/Providers/People_provider.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/ViewModels/add_client_viewmodel.dart';
import 'package:Decon/Controller/ViewModels/all_people_viewmodel.dart';
import 'package:Decon/Controller/ViewModels/people_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/View_Web/Dialogs/Add_Delegates.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Web/profile_screen.dart';
import 'package:firebase/firebase.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
    PeopleVM.instance.init();
    AllPeopleVM.instance.init();
    _listOfAdminTeam = [];
    _listOfManagerTeam = [];
    print("selected manager==========${widget.clientDetailModel?.selectedManager}");
    await AllPeopleVM.instance.getManagerDetail(widget.clientDetailModel?.selectedManager);
    print("11111111111111");
    await AllPeopleVM.instance.getAdminDetail(widget.clientDetailModel?.selectedAdmin);
    print("22222222222222222");
    setState(() { });
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  Future showDelegatesDialog(BuildContext context) {
    return showAnimatedDialog(
        barrierDismissible: true,
        context: context,  
        animationType: DialogTransitionType.scaleRotate,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),
        builder: (context) {
          return Add_Delegates(list: GlobalVar.strAccessLevel=="2" ? _listOfManagerTeam : _listOfAdminTeam,
          adminDetail: AllPeopleVM.instance.adminDetailModel);
        });
  }

  Future showDeleteDialog(BuildContext context) {
    return showAnimatedDialog(
        context: context,
        animationType: DialogTransitionType.scaleRotate,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),
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
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return Scaffold(
      body: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: b * 68, vertical: h* 20),
            child: Row(
              children: [
                Container(
                  width: b * 325,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: dc, width: 0.5),
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(b * 60),
                  ),
                  child: TextField(
                    onChanged: (val){
                      _listOfManagerTeam = PeopleVM.instance.onSearchManagerTeam(val);
                      _listOfAdminTeam = PeopleVM.instance.onSearchAdminTeam(val);
                      setState(() {});
                    },
                    style: TextStyle(fontSize: b * 12, color: dc),
                    decoration: InputDecoration(
                      prefixIcon: InkWell(
                        child: Icon(Icons.search, color: blc),
                        onTap: null,
                      ),
                      isDense: true,
                      isCollapsed: true,
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 35, maxHeight: 30),
                      hintText: 'Search by Name',
                      hintStyle: TextStyle(
                        fontSize: b * 12,
                        color: Color(0xff858585),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: h * 17, horizontal: b * 10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Spacer(),
                MaterialButton(
                  color: blc,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(h * 6),
                  ),
                  onPressed: () {
                     showDelegatesDialog(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: h * 11, horizontal: b * 60),
                    alignment: Alignment.center,
                    child: Text(
                      'Add',
                      style: txtS(wc, 18, FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
          sh(30),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(b * 68, 0, b * 68, h * 0),
            padding: EdgeInsets.fromLTRB(b * 72, h * 15, b * 72, h * 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(h * 10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: 
            AllPeopleVM.instance.managerDetailModel == null? AppConstant.progressIndicator():
            AllPeopleVM.instance.managerDetailModel.key == null? AppConstant.noDataFound(): 
            Row(
              children: [
                Container(
                              height: h * 45,
                              width: b * 45,
                              decoration: BoxDecoration(
                                color: dc,
                                shape: BoxShape.circle,
                              ),
                            ),
                sb(23),
                
                       
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AllPeopleVM.instance.managerDetailModel.name??""}",
                      style: txtS(dc, 20, FontWeight.w500),
                    ),
                    // Text(
                    //   "${AllPeopleVM.instance.managerDetailModel.phoneNo??""}",
                    //   style: TextStyle(
                    //     color: blc,
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: h * 14,
                    //     fontStyle: FontStyle.italic,
                    //   ),
                    // ),
                  ],
                ),
                Spacer(),
                Text(
                  "${AllPeopleVM.instance.managerDetailModel.post??""}",
                  style: TextStyle(
                    color: dc,
                    fontWeight: FontWeight.w400,
                    fontSize: h * 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Spacer(),
                Text(
                  "${AllPeopleVM.instance.managerDetailModel.phoneNo??""}",
                  style: txtS(blc, 20, FontWeight.w700),
                ),
              ],
            ),
          ),
          sh(12),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(b * 68, 0, b * 68, h * 0),
            padding: EdgeInsets.fromLTRB(b * 72, h * 15, b * 72, h * 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(h * 10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child:
            AllPeopleVM.instance.adminDetailModel == null? AppConstant.progressIndicator():
            AllPeopleVM.instance.adminDetailModel.key == null? AppConstant.noDataFound(): 
                        Row(
              children: [
                 Container(
                              height: h * 45,
                              width: b * 45,
                              decoration: BoxDecoration(
                                color: dc,
                                shape: BoxShape.circle,
                              ),
                            ),
               
                sb(23),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AllPeopleVM.instance.adminDetailModel.name??""}",
                      style: txtS(dc, 20, FontWeight.w500),
                    ),
                    // Text(
                    //   "Manager",
                    //   style: TextStyle(
                    //     color: blc,
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: h * 14,
                    //     fontStyle: FontStyle.italic,
                    //   ),
                    // ),
                  ],
                ),
                Spacer(),
                Text(
                  "${AllPeopleVM.instance.adminDetailModel.post??""}",
                  style: TextStyle(
                    color: dc,
                    fontWeight: FontWeight.w400,
                    fontSize: h * 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Spacer(),
                Text(
                  "${AllPeopleVM.instance.adminDetailModel.phoneNo??""}",
                  style: txtS(blc, 20, FontWeight.w700),
                ),
              ],
            ),
          ),
          sh(33),
          Padding(
            padding: EdgeInsets.only(left: b * 72),
            child: Consumer<AfterManagerChangeProvider>(
              builder: (context, model, child)=>
               Text(
                "Manager Team    Total (${model.listManager.length})",
                style: txtS(dc, 18, FontWeight.w500),
              ),
            ),
          ),
          sh(10),
          Expanded(
            child: StreamBuilder<QueryEvent>(
              stream: database().ref("managerTeam").orderByChild("headUid").equalTo("${widget.clientDetailModel?.selectedManager}").onValue,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  if(!PeopleVM.instance.isManagerTeamSearched){
                              _listOfManagerTeam = [];
                            (snapshot.data.snapshot.val() as Map)?.forEach((key, value) { 
                              UserDetailModel _usermodel = UserDetailModel.fromJson(key, value);
                              _usermodel?.clientsVisible = AllPeopleVM.instance.managerDetailModel?.clientsVisible;
                              _listOfManagerTeam.add(_usermodel);
                            });
                            PeopleVM.instance.setManagerTeamList = _listOfManagerTeam;  
                            }
                            WidgetsBinding.instance.addPostFrameCallback((_){
                            Provider.of<AfterManagerChangeProvider>(context, listen:  false).afterManagerChangeProvider(_listOfManagerTeam);  
                            });
                          
                if(snapshot.data.snapshot.val()!=null)            
                return ListView.builder(
                  itemCount: _listOfManagerTeam.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(b * 72, h * 5, b * 72, h * 15),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile(myProfile: false, userDetailModel: _listOfManagerTeam[index], )));
                                  },
                                  onLongPress: () {
                                    if(GlobalVar.strAccessLevel == "2" ||GlobalVar.strAccessLevel == "1")
                                    showDeleteDialog(context).then((value) async {
                                    
                                      if (value == "Yes") {
                                          database().ref("managerTeam/${_listOfManagerTeam[index].key}").remove(); 
                                      }
                                    });
                                  },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(b * 0, h * 15, b * 0, h * 15),
                        margin: EdgeInsets.fromLTRB(b * 32, 0, b * 32, h * 0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: dc, width: 0.3),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                                    height: h * 45,
                                    width: b * 45,
                                    decoration: BoxDecoration(
                                      color: dc,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                            sb(23),
                            Text(
                               '${_listOfManagerTeam[index].name}',
                              style: txtS(dc, 18, FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                               '${_listOfManagerTeam[index].post}',
                              style: TextStyle(
                                color: dc,
                                fontWeight: FontWeight.w400,
                                fontSize: h * 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Spacer(),
                            Text(
                               '${_listOfManagerTeam[index].phoneNo}',
                              style: txtS(blc, 16, FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                else
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
              }
            ),
          ),
        sh(33),
          Padding(
            padding: EdgeInsets.only(left: b * 72),
            child: Consumer<AfterAdminChangeProvider>(
              builder: (context, model, child)=>
              Text(
                "Admin Team    Total (${model.listAdmin.length})",
                style: txtS(dc, 18, FontWeight.w500),
              ),
            ),
          ),
          sh(10),
          Expanded(
            child: StreamBuilder<QueryEvent>(
              stream: database().ref("adminTeam").orderByChild("headUid").equalTo("${widget.clientDetailModel?.selectedAdmin}").onValue,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  if(!PeopleVM.instance.isAdminTeamSearched){
                          _listOfAdminTeam = [];
                        (snapshot.data.snapshot.val() as Map)?.forEach((key, value) {
                          UserDetailModel _usermodel = UserDetailModel.fromJson(key, value);
                         _usermodel.clientsVisible = AllPeopleVM.instance.adminDetailModel.clientsVisible;
                               
                          _listOfAdminTeam.add(_usermodel);
                        });
                        PeopleVM.instance.setAdminTeamList = _listOfAdminTeam;
                        }
                        WidgetsBinding.instance.addPostFrameCallback((_){
                         Provider.of<AfterAdminChangeProvider>(context, listen:  false).afterAdminChangeProvider(_listOfAdminTeam);  
                         });
                      
                
                if(snapshot.data.snapshot.val()!=null)            
                return ListView.builder(
                  itemCount: _listOfAdminTeam.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(b * 72, h * 5, b * 72, h * 15),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell( 
                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile(myProfile: false, userDetailModel: _listOfAdminTeam[index], )));
                                  },
                               onLongPress: () {
                                if(GlobalVar.strAccessLevel == "3" ||GlobalVar.strAccessLevel == "1" )
                                showDeleteDialog(context).then((value) async {
                                
                                  if (value == "Yes") {
                                      database().ref("adminTeam/${_listOfAdminTeam[index].key}").remove(); 
                                  }
                                });
                              },
                      
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(b * 0, h * 15, b * 0, h * 15),
                        margin: EdgeInsets.fromLTRB(b * 32, 0, b * 32, h * 0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: dc, width: 0.3),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                                    height: h * 45,
                                    width: b * 45,
                                    decoration: BoxDecoration(
                                      color: dc,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                            sb(23),
                            Text(
                               '${_listOfAdminTeam[index].name}',
                              style: txtS(dc, 18, FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                               '${_listOfAdminTeam[index].post}',
                              style: TextStyle(
                                color: dc,
                                fontWeight: FontWeight.w400,
                                fontSize: h * 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Spacer(),
                            Text(
                               '${_listOfAdminTeam[index].phoneNo}',
                              style: txtS(blc, 16, FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                else
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
              }
            ),
          ),

          
        ]),
      ),
    ); 
    
  }
}
