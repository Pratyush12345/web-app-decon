import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Controller/ViewModels/Services/test.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Web/Bottom_Navigation/AllDevices.dart';
import 'package:Decon/View_Web/Dialogs/areYouSure.dart';
import 'package:Decon/View_Web/DrawerFragments/AboutVysion.dart';
import 'package:Decon/View_Web/DrawerFragments/AddDevice/AddDevice.dart';
import 'package:Decon/View_Web/DrawerFragments/Contact.dart';
import 'package:Decon/View_Web/DrawerFragments/Device_Setting.dart';
import 'package:Decon/View_Web/DrawerFragments/HealthReport.dart';
import 'package:Decon/View_Web/DrawerFragments/Home.dart';
import 'package:Decon/View_Web/DrawerFragments/Statistics/Statistics.dart';
import 'package:Decon/View_Web/MainPage/HomePage.dart';
import 'package:Decon/View_Web/clients/all_clients.dart';
import 'package:Decon/View_Web/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

    _onSelectedItem( Widget widget) {
      HomePageVM.instance.isfromDrawer = true;
      HomePageVM.instance.selectedDrawerWidget = widget;
      Provider.of<ChangeDrawerItems>(context, listen: false).changeDrawerItem();
      HomePageVM.instance.scafoldKey.currentState.openEndDrawer();
  }
   showAreYouSureDialog(context){
     showAnimatedDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AreYouSure(msg: "Are You Sure, Want to Log out.",)  ;
                                },
                                animationType: DialogTransitionType.scaleRotate,
                                curve: Curves.fastOutSlowIn,
                                duration: Duration(milliseconds: 400),
                              ).then((value){
                                if(value == "YES"){
                                Auth.instance.signOut();
               
                                
                              }
                              }
                              );
   }
  
   Widget row(ico, String tit, dynamic nextPage, context) {
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Container(
      margin: EdgeInsets.only(left: b * 11, right: b * 16),
      child: Material(
        color: Color(0xffFfffff),
        child: InkWell(
          borderRadius: BorderRadius.circular(b * 33),
          onTap: () {
            
            _onSelectedItem( nextPage);
          },
          highlightColor: Color(0xffa9e0ff).withOpacity(0.5),
          splashColor: Color(0xffa9e0ff).withOpacity(0.5),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: h * 14, horizontal: b * 16),
            child: Row(
              children: [
                Icon(ico, color: Colors.black),
                SizedBox(width: b * 20),
                Text(
                  tit,
                  style: txtS(Colors.black, 16, FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {

     SizeConfig().init(context);
     var h = SizeConfig.screenHeight / 812;
     var b = SizeConfig.screenWidth / 375;

    return Drawer(
        child: Container(
          color: Color(0xFFFfffff),
          child: Column(
            children: <Widget>[
            Container(
            color: blc,
            height: h * 0.5,
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile(myProfile: true, userDetailModel: GlobalVar.userDetail, )));
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: b * 11, bottom: h * 35, top: h * 40, right: b * 12),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  height: h * 60,
                  width: b * 60,
                  child: CircleAvatar(
                                radius: SizeConfig.b * 11,
                                backgroundImage: AssetImage("assets/f.png"),
                              ),
                  decoration: BoxDecoration(
                    color: blc,
                    shape: BoxShape.circle,
                  ),
                ),
                Spacer(),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(
                    "${GlobalVar.userDetail.name ?? ""}",
                    style: txtS(blc, 18, FontWeight.w700),
                  ),
                  Text(
                    "${FirebaseAuth.instance.currentUser?.phoneNumber ?? ""}",
                    style: txtS(Colors.black, 12, FontWeight.w400),
                  ),
                ]),
              ]),
            ),
          ),
          Container(
            color: blc,
            height: h * 0.5,
          ),
          sh(18),
          if(GlobalVar.strAccessLevel == "1")
          row(Icons.view_list, 'Client List', AllClients(), context),
          row(Icons.home, 'Home', Home(), context),
          row(Icons.settings, 'Device Settings', DeviceSetting(), context),
          row(Icons.assessment, 'Statistics', Devices(), context),
          row(Icons.build, 'Maintainence Report', HealthReport(), context),
          row(Icons.add, 'Add Device', AddDevice(), context),
          row(Icons.verified, 'About Vysion', AboutVysion(), context),
          row(Icons.settings_phone, 'Contact Us', ContactUs(), context),
          Spacer(),
          Container(
            margin:
                EdgeInsets.only(left: b * 11, right: b * 16, bottom: h * 10),
            child: Material(
              color: Color(0xffFfffff),
              child: InkWell(
                borderRadius: BorderRadius.circular(b * 33),
                onTap: () {
              Navigator.of(context).pop();
              
               showAreYouSureDialog(context);
                },
                highlightColor: Colors.red.withOpacity(0.4),
                splashColor: Colors.red.withOpacity(0.4),
                child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: h * 14, horizontal: b * 16),
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: b * 20),
                  Text(
                    "Log Out",
                    style: txtS(Colors.red, 16, FontWeight.w400),
                  ),
                ],
              ),
                ),
              ),
            ),
          )
            ],
          ),
        ),
      );
  }
}