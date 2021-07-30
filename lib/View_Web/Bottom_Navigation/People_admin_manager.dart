import 'package:Decon/Controller/Providers/People_provider.dart';
import 'package:Decon/Controller/Providers/peopleHoverProvider.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Controller/ViewModels/Services/test.dart';
import 'package:Decon/Controller/ViewModels/people_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Web/Bottom_Navigation/All_people.dart';
import 'package:Decon/View_Web/Dialogs/Add_Admin.dart';
import 'package:Decon/View_Web/Dialogs/Add_Manager.dart';
import 'package:Decon/View_Web/Dialogs/Replace_Admin.dart';
import 'package:Decon/View_Web/Dialogs/Replace_Manager.dart';
import 'package:Decon/View_Web/profile_screen.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
class PeopleManagerAdmin extends StatefulWidget {
  const PeopleManagerAdmin({ Key key }) : super(key: key);

  @override
  _PeopleManagerAdminState createState() => _PeopleManagerAdminState();
}

class _PeopleManagerAdminState extends State<PeopleManagerAdmin> {
   List<UserDetailModel> _listUserDetailModelAdmins = [];
  Map<String ,ClientDetailModel> _listClientDetailModel = {};
  List<UserDetailModel> _listUserDetailModelManager;
  TextEditingController _managerSearch = TextEditingController();
  TextEditingController _adminSearch = TextEditingController();
  @override
  void initState() {
    super.initState();
    PeopleVM.instance.init();
  }

  @override
  void dispose() {
    
    super.dispose();
  } 

  Future showManagerDialog(BuildContext context) {
    return showAnimatedDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Add_man(list: _listUserDetailModelManager??[],);
        },   
        animationType: DialogTransitionType.scaleRotate,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),);
  }

  Future showAdminDialog(BuildContext context) {
    return showAnimatedDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Add_admin(list: _listUserDetailModelAdmins??[],);
        },
        animationType: DialogTransitionType.scaleRotate,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),);
  }

  Future showReplaceAdminDialog(BuildContext context, String clientVisible, String uid) {
    return showAnimatedDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Replace_Admin(
            clientVisible: clientVisible ,
            uid: uid,
            list: _listUserDetailModelAdmins,
          );
        },
        animationType: DialogTransitionType.scaleRotate,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),);
  }
  
  Future showReplaceManagerDialog(BuildContext context, String clientVisible, String uid) {
    return showAnimatedDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Replace_Manager(
            clientVisible: clientVisible ,
            uid: uid,
            list: _listUserDetailModelManager,
          );
        },     
        animationType: DialogTransitionType.scaleRotate,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),);
  }
  _getClientDetail(String clientCode, String uid) async{
   ClientDetailModel clientDetailModel = await PeopleVM.instance.getClientDetail(clientCode);
   _listClientDetailModel[uid] = (clientDetailModel);
   Provider.of<PeopleProvider>(context, listen: false).changeClientDetail(_listClientDetailModel);

  }

 
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
   var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return Row(
        children: [
          Expanded(
            child: Column(
              children: [
                sh(80),
                
                Expanded(
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding:
                            EdgeInsets.fromLTRB(b * 40, h * 40, b * 40, h * 40),
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
                        margin: EdgeInsets.only(
                            left: b * 32, right: b * 17, bottom: h * 55),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            sh(30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: b * 40),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              flex: 2,
              child: Text(
                "Managers",
                style: txtS(Color(0xff858585), 16, FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: dc, width: 0.5),
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(b * 60),
                ),
                child: TextField(
                  onChanged: (val){
                   _listUserDetailModelManager = PeopleVM.instance.onSearchManager(val);
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
                    hintText: 'Search by Name/Phone No',
                    hintStyle: TextStyle(
                      fontSize: h * 14,
                      color: Color(0xff858585),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: b * 12, horizontal: b * 10),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ]),
        ),
        sh(15),
        Expanded(
          flex: 4,
          child: StreamBuilder<QueryEvent>(
            stream: database().ref("managers").onValue,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                 Map datamap = snapshot.data.snapshot.val();
                 if(!PeopleVM.instance.isManagerSearched){
                  _listUserDetailModelManager = [];
                  datamap?.forEach((key, value) {  
                  _listUserDetailModelManager.add(UserDetailModel.fromJson(key.toString(), value));
                  });
                 PeopleVM.instance.setManagerList = _listUserDetailModelManager;
                 }
                if(snapshot.data.snapshot.val() !=null)
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: b * 22, vertical: h * 13),
                  itemCount: _listUserDetailModelManager.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    
                    return InkWell(
                      onHover: (ishover){
                        Provider.of<PeopleHoverProvider>(context, listen: false).onPeopleHovered(ishover? _listUserDetailModelManager[index].key : "-1");   
                      },
                      onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile(myProfile: false, userDetailModel: _listUserDetailModelManager[index], )));
                      },
                      child: Consumer<PeopleHoverProvider>(
                        builder: (context, model, child)=>
                         Transform.translate(
                           offset: model.idHovered == _listUserDetailModelManager[index].key ? Offset(0, -5.0) :  Offset.zero,
                           child: Transform.scale(
                             scale: model.idHovered == _listUserDetailModelManager[index].key ? 1.05 : 1.0,
                             child: Container(
                              margin: EdgeInsets.only(bottom: h * 10),
                              decoration: BoxDecoration(
                                color: Color(0xfff5f5f5),
                                borderRadius: BorderRadius.circular(h * 10),
                              ),
                              padding:
                                  EdgeInsets.fromLTRB(b * 22, h * 16, b * 22, h * 16),
                              child: Row(children: [
                                Container(
                                  height: h * 45,
                                  width: b * 45,
                                  decoration: BoxDecoration(
                                    color: dc,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                sb(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${_listUserDetailModelManager[index].name}",
                                      style: txtS(blc, 18, FontWeight.w700),
                                    ),
                                    sh(7),
                                    Text(
                                      "${_listUserDetailModelManager[index].phoneNo}",
                                      style: txtS(Color(0xff858585), 16, FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 500),
                                  child: model.idHovered == _listUserDetailModelManager[index].key ? 
                                   IconButton(icon: Icon(Icons.edit), 
                                   onPressed:(){
                                     showReplaceManagerDialog(
                                                        context,
                                                        _listUserDetailModelManager[index].clientsVisible,
                                                        _listUserDetailModelManager[index].key,
                                                        );
                                   } ) : SizedBox()
                                   ),
                                SizedBox(width: 20.0,)
                              ]),
                        ),
                           ),
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
              
            }
          ),
        ),
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                showManagerDialog(context);
               },
              child: Container(
                margin: EdgeInsets.only(
                    bottom: h * 40, left: b * 170, right: b * 170, top: h * 32),
                decoration: BoxDecoration(
                  color: blc,
                  border: Border.all(color: blc, width: 0.5),
                  borderRadius: BorderRadius.circular(h * 6),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Add Manager",
                  style: txtS(wc , 18, FontWeight.w500),
                ),
              ),
            ),
          ),
                        
                            
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding:
                            EdgeInsets.fromLTRB(b * 40, h * 40, b * 40, h * 40),
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
                        margin: EdgeInsets.only(
                            left: b * 32, right: b * 17, bottom: h * 55),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            sh(30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: b * 40),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              flex: 2,
              child: Text(
                "Admins",
                style: txtS(Color(0xff858585), 16, FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: dc, width: 0.5),
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(b * 60),
                ),
                child: TextField(
                  onChanged: (val){
                   _listUserDetailModelAdmins = PeopleVM.instance.onSearchAdmin(val);
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
                    hintText: 'Search by Name/Phone No',
                    hintStyle: TextStyle(
                      fontSize: h * 14,
                      color: Color(0xff858585),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: b * 12, horizontal: b * 10),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ]),
        ),
        sh(15),
        Expanded(
          flex: 4,
          child: StreamBuilder<QueryEvent>(
            stream: database().ref("admins").onValue,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                  Map datamap = snapshot.data.snapshot.val();
                                          if(!PeopleVM.instance.isAdminSearched){
                                          _listUserDetailModelAdmins = [];
                                          datamap?.forEach((key, value) {
                                            UserDetailModel userDetailModel = UserDetailModel.fromJson(key.toString(), value); 
                                            _listUserDetailModelAdmins.add(userDetailModel);
                                          PeopleVM.instance.setAdminList = _listUserDetailModelAdmins;  
                                          _getClientDetail(userDetailModel.clientsVisible, userDetailModel.key);
                                          });
                                          }
                if(snapshot.data.snapshot.val() !=null)
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: b * 22, vertical: h * 13),
                  itemCount: _listUserDetailModelAdmins.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    
                    return Consumer<PeopleProvider>(
                    builder: (context, model, child)=>
                    InkWell(
                      onHover: (ishover){
                        Provider.of<PeopleHoverProvider>(context, listen: false).onPeopleHovered(ishover? _listUserDetailModelAdmins[index].key : "-1");   
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
                                                      // Navigator.of(context).push(
                                                      //   MaterialPageRoute(
                                                      //     builder: (context) =>
                                                      //        TestPage(
                                                      //          clientCode:_listUserDetailModelAdmins[index].clientsVisible,
                                                      //         clientDetailModel: model.listClientDetailModel[_listUserDetailModelAdmins[index].key],
                                                               
                                                      //        )
                                                      //   ),
                                                      // );
                                                    },
                                           
                      child: Consumer<PeopleHoverProvider>(
                        builder: (context, model, child)=>
                         Transform.translate(
                          offset: model.idHovered == _listUserDetailModelAdmins[index].key ? Offset(0, -5.0) :  Offset.zero ,
                          child: Transform.scale(
                            scale: model.idHovered == _listUserDetailModelAdmins[index].key ? 1.05 : 1.0,
                            child: Container(
                              margin: EdgeInsets.only(bottom: h * 10),
                              decoration: BoxDecoration(
                                color: Color(0xfff5f5f5),
                                borderRadius: BorderRadius.circular(h * 10),
                              ),
                              padding:
                                  EdgeInsets.fromLTRB(b * 22, h * 16, b * 22, h * 16),
                              child: Row(children: [
                                Container(
                                  height: h * 45,
                                  width: b * 45,
                                  decoration: BoxDecoration(
                                    color: dc,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                sb(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${_listUserDetailModelAdmins[index].name}",
                                      style: txtS(blc, 18, FontWeight.w700),
                                    ),
                                    sh(7),
                                    Text(
                                      "${_listUserDetailModelAdmins[index].delegate}",
                                      style: txtS(Color(0xff858585), 16, FontWeight.w500),
                                    ),
                                    sh(7),
                                    Text(
                                      "${_listUserDetailModelAdmins[index].phoneNo}",
                                      style: txtS(Color(0xff858585), 16, FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 500),
                                  child: model.idHovered == _listUserDetailModelAdmins[index].key ? 
                                   IconButton(icon: Icon(Icons.edit), 
                                   onPressed:(){
                                     showReplaceAdminDialog(
                                                          context,
                                                          _listUserDetailModelAdmins[index].clientsVisible,
                                                          _listUserDetailModelAdmins[index].key,
                                                          );
                                   } ) : SizedBox()
                                   ),
                                SizedBox(width: 20.0,)
                              ]),
                            ),
                          ),
                        ),
                      ),
                    )
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
              
            }
          ),
        ),
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                showAdminDialog(context);
               },
              child: Container(
                margin: EdgeInsets.only(
                    bottom: h * 40, left: b * 170, right: b * 170, top: h * 32),
                decoration: BoxDecoration(
                  color: blc,
                  border: Border.all(color: blc, width: 0.5),
                  borderRadius: BorderRadius.circular(h * 6),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Add Admin",
                  style: txtS(wc , 18, FontWeight.w500),
                ),
              ),
            ),
          ),
                        
                            
                          ],
                        ),
                      ),
                    ),
                    
                  ]),
                ),
                
              ],
            ),
          ),
        ],
      );
  }
}