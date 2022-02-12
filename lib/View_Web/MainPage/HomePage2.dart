import 'package:Decon/Controller/Providers/drawerHoverProvider.dart';
import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Consts/client_not_found.dart';
import 'package:Decon/View_Web/Bottom_Navigation/AllDevices.dart';
import 'package:Decon/View_Web/Bottom_Navigation/All_People_dummy.dart';
import 'package:Decon/View_Web/Bottom_Navigation/All_people.dart';
import 'package:Decon/View_Web/Bottom_Navigation/People_admin_manager.dart';
import 'package:Decon/View_Web/Dialogs/areYouSure.dart';
import 'package:Decon/View_Web/DrawerFragments/AboutVysion.dart';
import 'package:Decon/View_Web/DrawerFragments/AddDevice/AddDevice.dart';
import 'package:Decon/View_Web/DrawerFragments/Contact.dart';
import 'package:Decon/View_Web/DrawerFragments/Device_Setting.dart';
import 'package:Decon/View_Web/DrawerFragments/Home.dart';
import 'package:Decon/View_Web/DrawerFragments/maintainence_report.dart';
import 'package:Decon/View_Web/DrawerFragments/monthly_report.dart';
import 'package:Decon/View_Web/clients/all_clients.dart';
import 'package:Decon/View_Web/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomePage2 extends StatefulWidget {
  HomePage2({key}): super(key: key);
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  
  String selected = "Home";
  String _itemSelected;
  @override
  void initState() {
    GlobalVar.seriesMap = GlobalVar.seriesMapWeb;
    HomePageVM.instance.selectedDrawerWidget = Home();
    HomePageVM.instance.initialize(context);
    super.initState();
  }

  @override
  void dispose() {
    HomePageVM.instance.dispose();
    super.dispose();
  }
   Widget appBar() {
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;
    return Container(
      //height: h * 50,
      padding: EdgeInsets.only(
          left: b * 29, right: b * 29, top: h * 8, bottom: h * 8),
      
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          sb(17),
          Container(
            decoration: BoxDecoration(
              color: wc,
              border: Border.all(color: blc, width: 0.5),
              borderRadius: BorderRadius.circular(h * 5),
            ),
            padding: EdgeInsets.only(left: b * 17, right: b * 10),
            child: Consumer<ChangeWhenGetClientsList>(
                   builder: (context, object,child ){
                     if(object.clientsList!=null  && _itemSelected == null)
                    _itemSelected = object.clientsList[0].clientName;
               return Consumer<ChangeClient>(
                          builder: (context, changeList, child)=>
                object.clientsList == null? AppConstant.circulerProgressIndicator():
                object.clientsList.isEmpty? AppConstant.addClient():
                         
                DropdownButton(
                  underline: SizedBox(),
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  isDense: true,
                  icon: Padding(
                    padding: EdgeInsets.only(
                        left: _itemSelected.length > 14 ? b * 10 : b * 0),
                    child: SvgPicture.asset(
                      'images/drop.svg',
                      allowDrawingOutsideViewBox: true,
                      color: blc,
                      height: h * 12,
                      width: b * 12,
                    ),
                  ),
                  items: object.clientsList.map((dropDownStringitem) {
                            return  
                            DropdownMenuItem<String>(
                              value: dropDownStringitem.clientName,
                              child: Text(
                                dropDownStringitem.clientName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87),
                              ),
                            );
                        }).toList(),
                  style: txtS(blc, 20, FontWeight.w400),
                  onChanged: (newValueSelected) {
                            _itemSelected = newValueSelected;
                             object.clientsList.forEach((value) { 
                              if (value.clientName == newValueSelected) HomePageVM.instance.setClientCode = value.clientCode;
                            });
                            GlobalVar.isclientchanged = true;
                            HomePageVM.instance.onChangeClient();
                            HomePageVM.instance.loadMap();
                        },
                  value: _itemSelected?? null,
                ),
              );
                   }
            ),
          ),
          sb(25),
          Consumer<ChangeSeries>(
            builder: (context, model, child)=>
            Container(
              decoration: BoxDecoration(
                color: dc,
                borderRadius: BorderRadius.circular(h * 5),
              ),
              padding: EdgeInsets.only(left: b * 17, right: b * 10),
              child: DropdownButton(
                underline: SizedBox(),
                iconDisabledColor: Colors.white,
                iconEnabledColor: Colors.white,
                isDense: true,
                icon: Padding(
                  padding: EdgeInsets.only(
                        left:  b * 10 ),
                    
                  child: SvgPicture.asset(
                    
                    'images/drop.svg',
                    allowDrawingOutsideViewBox: true,
                    color: Colors.white,
                    height: h * 12,
                    width: b * 12,
                  ),
                ),
                items: (model.seriesList??[]).map((e) => DropdownMenuItem<String>(
                                      child: Text(e,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                      ),
                                      value: e.toString(),
                                    )).toList(),
                style: txtS(wc, 20, FontWeight.w400),
                onTap: (){
                  print("tapped Series");
                },
                onChanged: (value) {
                  
                  print("Changed Series");
                  HomePageVM.instance.setSeriesCode = "$value";
                  HomePageVM.instance.onChangeSeries();
                 Provider.of<ChangeSeries>(context, listen: false).changeDeconSeries(value, model.seriesList);
                           HomePageVM.instance.loadMap();
                },
                value: model.selectedSeries,
                dropdownColor: Colors.black,
              ),
            ),
          ),
          sb(25),
          CircleAvatar(
                       backgroundImage: AssetImage("assets/DECON_1.png"),
                       ),
        ],
      ),
    );
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
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return Scaffold(
      key: HomePageVM.instance.scaffoldKey,
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: b * 265,
            color: dc,
            child: Column(
              children: [
                sh(45),
                InkWell(
                  onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile(myProfile: true, userDetailModel: GlobalVar.userDetail, )));
            },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: b * 25),
                        height: h * 60,
                        width: b * 60,
                        child: CircleAvatar(
                                
                                backgroundImage: AssetImage("assets/f.png"),
                              ),
                        decoration: BoxDecoration(
                          color: wc,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                             "${GlobalVar.userDetail.name ?? ""}",
                            style: txtS(wc, 18, FontWeight.w700),
                          ),
                          sh(10),
                          Text(
                             "${GlobalVar.userDetail.phoneNo ?? ""}",
                            style: txtS(wc, 14, FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                sh(60),
                panel("Home", Icons.home, Home(), true, 'images/Home.svg', 0),
                if(GlobalVar.strAccessLevel == "1")
                panel("Client List", Icons.view_list, AllClients(), false, '', 1),
                if(GlobalVar.strAccessLevel == "1")
                panel("People", Icons.people, PeopleManagerAdmin(), false, '', 2),
                if(GlobalVar.strAccessLevel != "1" && GlobalVar.strAccessLevel != null)
                panel("People", Icons.people, Consumer<ChangeClient>(
                  builder: (context, model, child)=>
                  AllPeople(
                    key: UniqueKey(),
                    clientCode: HomePageVM.instance.getClientCode,
                    clientDetailModel: model.clientDetailModel,
                    ),
                  ), false, '', 3),
                if(GlobalVar.strAccessLevel == null)
                panel("People", Icons.people, AllPeopleDummy(), false, '', 4),  
                if(GlobalVar.strAccessLevel !="3" && GlobalVar.strAccessLevel !="5")
                panel("Device Settings", Icons.settings, DeviceSetting(), false, '', 5),
                panel("Devices", Icons.memory, Devices(), false, '', 6),
                panel("Monthly Report", Icons.assessment, MonthlyReport() , false, '', 7),
                panel("Maintainence Report", Icons.build, MaintainenceReport() , false, '', 8),
                if(GlobalVar.strAccessLevel !="3" && GlobalVar.strAccessLevel !="5")
                panel("Add Device", Icons.add, AddDevice(), false, '', 9),
                panel("About Vysion", Icons.verified, AboutVysion(), false, '', 10),
                panel("Contact Us", Icons.settings_phone, ContactUs(), false, '', 11),
                Spacer(),
                logOutpanel("Log Out", Icons.logout, 10, false, '', 12),
                sh(50),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: appBar()
                   ),
                Expanded(
                  flex: 15,
                  child: Consumer<ChangeWhenGetClientsList>(
                    builder: (context, model, child)=> 
                    model.clientsList == null? AppConstant.circulerProgressIndicator():
                    model.clientsList.isEmpty? ClientsNotFound():
                    Consumer<ChangeOnActive>(
                      builder: (context, _, child)=>
                      !GlobalVar.isActive? AppConstant.deactivatedClient():
                        Consumer<ChangeDrawerItems>(
                          builder: (context, _, child){
                          return  Stack(
                            children: [
                              Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: HomePageVM.instance.selectedDrawerWidget),
                            ],
                          );
                          }
                        ),
                    )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _onSelectedItem( Widget widget) {
      HomePageVM.instance.isfromDrawer = true;
      HomePageVM.instance.selectedDrawerWidget = widget;
      Provider.of<ChangeDrawerItems>(context, listen: false).changeDrawerItem();
  }

  Widget panel(String tit, ico, dynamic nextPage, bool svg, String svgLink, int index) {
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return InkWell(
      onHover: (isHover){
        Provider.of<DrawerHoverProvider>(context, listen: false).onDrawerHovered(isHover? index: -1);  
      },
      onTap: (){
            selected = tit;
            _onSelectedItem( nextPage);
      },
      child: Consumer<ChangeDrawerItems>(
        builder: (context, _, child)=>
        Consumer<DrawerHoverProvider>(
          builder: (context, model, child)=>
           Container(
            padding: EdgeInsets.symmetric(vertical: h * 16),
            decoration: BoxDecoration(
              color: selected == tit || model.hoveredIndex == index ? Color(0xff3e535e) : Colors.transparent,
              border: Border(
                left: BorderSide(
                    color: selected == tit ? blc : Colors.transparent,
                    width: b * 6),
              ),
            ),
            child: Row(
              children: [
                sb(35),
                svg
                    ? SvgPicture.asset(
                        svgLink,
                        allowDrawingOutsideViewBox: true,
                        width: b * 24,
                        height: h * 24,
                      )
                    : Icon(ico, color: wc, size: h * 24),
                sb(18),
                Text(
                  tit,
                  style: txtS(wc, 16, FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget logOutpanel(String tit, ico, dynamic nextPage, bool svg, String svgLink, int index) {
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return InkWell(
      onHover: (isHover){
        Provider.of<DrawerHoverProvider>(context, listen: false).onDrawerHovered(isHover? index: -1);  
      },
      onTap: (){
        
               showAreYouSureDialog(context);
      },
      child: Consumer<ChangeDrawerItems>(
        builder: (context, _, child)=>
        Consumer<DrawerHoverProvider>(
          builder: (context, model ,child)=>
           Container(
            padding: EdgeInsets.symmetric(vertical: h * 16),
            decoration: BoxDecoration(
              color: selected == tit || model.hoveredIndex == index ? Color(0xff3e535e) : Colors.transparent,
              border: Border(
                left: BorderSide(
                    color: selected == tit ? blc : Colors.transparent,
                    width: b * 6),
              ),
            ),
            child: Row(
              children: [
                sb(35),
                svg
                    ? SvgPicture.asset(
                        svgLink,
                        allowDrawingOutsideViewBox: true,
                        width: b * 24,
                        height: h * 24,
                      )
                    : Icon(ico, color: wc, size: h * 24),
                sb(18),
                Text(
                  tit,
                  style: txtS(wc, 16, FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
