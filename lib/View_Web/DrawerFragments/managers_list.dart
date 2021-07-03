import 'package:Decon/Controller/Providers/Client_provider.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Controller/ViewModels/manager_list_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Web/Dialogs/Add_Manager.dart';
import 'package:Decon/View_Web/Dialogs/dialogBoxConfirmAdd.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';

class ManagersList extends StatefulWidget {
  String managerUid;
  final String clientName;
  ManagersList({@required this.managerUid, @required this.clientName});
  @override
  _ManagersListState createState() => _ManagersListState();
}

class _ManagersListState extends State<ManagersList> {
  List<UserDetailModel> _listUserDetailModel;
  final TextEditingController search = TextEditingController();

  int _selectedIndex = -1;
  Future showManagerDialog(BuildContext context) {
    return showAnimatedDialog(
        barrierDismissible:  true,
        context: context,
        animationType: DialogTransitionType.scaleRotate,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),
        
        builder: (context) {
          return Add_man(list: _listUserDetailModel??[],);
        });
  }

  void dialogBoxConfirmAdd(BuildContext context, int index) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return DialogBoxConfirmAdd(managerName: _listUserDetailModel[index].name, clientName: widget.clientName ,);
    },
    animationType: DialogTransitionType.scaleRotate,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 400),
  ).then((value){
    if(value == "YES"){
    _selectedIndex = index;
    
    Provider.of<ChangeManager>(context, listen: false).changeManager(_listUserDetailModel[index]);
    setState(() {});
    }
  });
}

  @override
    void initState() {
      _listUserDetailModel = [];
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;


    return  Container(
      margin: EdgeInsets.only(left: b * 17, right: b * 32, bottom: h * 55),
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        sh(30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: b * 40),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              flex: 2,
              child: Text(
                "Select a Manager",
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
                  _listUserDetailModel = ManagerListVM.instance.onSearchManager(val);
                  setState(() {});
                             
                },
                  style: TextStyle(fontSize: h * 12, color: dc),
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
                      fontSize: h * 14,
                      color: Color(0xff858585),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: h * 17, horizontal: b * 10),
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
                      if(!ManagerListVM.instance.isManagerSearched){
                      _listUserDetailModel = [];
                      datamap?.forEach((key, value) {
                        _listUserDetailModel.add(UserDetailModel.fromJson(key.toString(), value));
                      });
                      if(widget.managerUid!=null){
                        _selectedIndex = _listUserDetailModel.indexWhere((element) => element.key == widget.managerUid);
                        widget.managerUid = null;
                      }
                      ManagerListVM.instance.setManagerList = _listUserDetailModel;
                      }
                if(snapshot.data.snapshot.val() !=null)
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: b * 22, vertical: h * 13),
                  itemCount: _listUserDetailModel.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    
                    return InkWell(
                      onTap: () {
                        setState(() {});
                      },
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
                                "${_listUserDetailModel[index].name}",
                                style: txtS(blc, 18, FontWeight.w700),
                              ),
                              sh(7),
                              Text(
                                "${_listUserDetailModel[index].phoneNo}",
                                style: txtS(Color(0xff858585), 16, FontWeight.w500),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("${_listUserDetailModel[index].clientsVisible.replaceFirst(",", "")??""}"),
                              Checkbox(
                                value: index == _selectedIndex, 
                                onChanged: (val){
                                  if(val){
                                  dialogBoxConfirmAdd(context, index);
                                  }
                                  else{
                                    _selectedIndex = -1;
                                    Provider.of<ChangeManager>(context, listen: false).changeManager(null);
   
                                    setState(() {});
                                     
                                  }
                                }),
                            ],
                          ),
                        ),
                        sb(20)
                        ]),
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
      ]),
    ); 
  }
}