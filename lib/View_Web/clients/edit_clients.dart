import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Controller/ViewModels/add_client_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Web/Dialogs/areYouSure.dart';
import 'package:Decon/View_Web/clients/add_client.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ClientDetails extends StatefulWidget {
   final String clientCode;
   
  ClientDetails({@required this.clientCode});
 
  @override
  _ClientDetailsState createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserDetailModel _userDetailModel;
  bool _isActive = true;
  
  _initializeData() async{
    AddClientVM.instance.init(); 
    await AddClientVM.instance.getClientDetail(widget.clientCode);
    _userDetailModel = await AddClientVM.instance.getManagerDetail();
    await AddClientVM.instance.getSeriesList();
    DataSnapshot snapshot = (await database().ref("clients/${widget.clientCode}/isActive").once('value')).snapshot;
    if(snapshot.val() == 1)
    _isActive = true;
    else 
    _isActive = false;
    
    setState(() {});
   }
   
  @override
    void initState() {
      _initializeData();  
      super.initState();
    }
 
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return Scaffold(
      backgroundColor: wc,
      body: AddClientVM.instance.seriesList == null? AppConstant.circulerProgressIndicator():
          AddClientVM.instance.seriesList.isEmpty ? AppConstant.noDataFound():
          Row(
        children: [
          Expanded(
            child: Column(
              children: [
                sh(148),
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      height: h * 135,
                      padding:
                          EdgeInsets.fromLTRB(b * 10, h * 11, b * 10, h * 11),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(h * 10),
                        color: Color(0xffc1ebff),
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
                          left: b * 62, right: b * 62, bottom: h * 127),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddClient(clientCode: widget.clientCode ,isedit: true, userDetailModel: _userDetailModel,)))
                           .then((value){
                             if(value == "Updated"){
                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ClientDetails(clientCode: widget.clientCode,)));
                             }
                           });
                        },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              height: h * 30,
                              width: b * 75,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(b * 20),
                                border: Border.all(color: dc, width: 0.5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'images/edit.svg',
                                    allowDrawingOutsideViewBox: true,
                                    color: dc,
                                    height: h * 20,
                                  ),
                                  sb(10),
                                  Text(
                                    "Edit",
                                    style: txtS(dc, 14, FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                               showAnimatedDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AreYouSure(msg: "This will ${_isActive? "deactivate": "activate"} client",)  ;
                                },
                                animationType: DialogTransitionType.scaleRotate,
                                curve: Curves.fastOutSlowIn,
                                duration: Duration(milliseconds: 400),
                              ).then((value){
                                if(value == "YES"){
                                  _isActive = !_isActive;
                                 if(!_isActive)
                                 AddClientVM.instance.onDeactivatePressed(widget.clientCode);
                                 else{
                                  print(widget.clientCode);
                                AddClientVM.instance.onActivatePressed(widget.clientCode);
                                  
                                }
                                }
                                
                                setState(() {});
                              }
                              );
                            
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              height: h * 30,
                              width: b * 108,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(b * 20),
                                border: Border.all(
                                    color: Color(0xffff000f), width: 0.5),
                              ),
                              child: Text(
                                _isActive ?"Deactivate Client" : "Activate Client",
                                 style: txtS(
                                    Color(0xffff000f), 14, FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: h * 44,
                      left: b * 62,
                      child: Row(
                        children: [
                          Container(
                            height: h * 142,
                            width: b * 142,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 16,
                                  spreadRadius: 0,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                                backgroundImage: AssetImage("assets/DECON_1.png"),
                              ),
                            // child: CachedNetworkImage(
                            //   imageUrl:
                            //       'https://images.unsplash.com/photo-1517423440428-a5a00ad493e8',
                            //   fit: BoxFit.cover,
                            //   imageBuilder: (context, imageProvider) =>
                            //       Container(
                            //     decoration: BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       image: DecorationImage(
                            //         image: imageProvider,
                            //         fit: BoxFit.cover,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: h * 19),
                            child: Text(
                              "${AddClientVM.instance.clientDetailModel.clientName??""}",
                              style: txtS(dc, 28, FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding:
                            EdgeInsets.fromLTRB(b * 30, h * 57, b * 30, h * 40),
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
                            left: b * 62, right: b * 62, bottom: h * 194),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'images/work.svg',
                                  allowDrawingOutsideViewBox: true,
                                ),
                                sb(16),
                                Text(
                                  "Department name",
                                  style: txtS(
                                      Color(0xff626262), 16, FontWeight.w400),
                                ),
                                Spacer(),
                                Text(
                                  "${AddClientVM.instance.clientDetailModel.departmentName??""}",
                                  style: txtS(dc, 16, FontWeight.w500),
                                ),
                              ],
                            ),
                            sh(28),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'images/location2.svg',
                                  allowDrawingOutsideViewBox: true,
                                ),
                                sb(19),
                                Text(
                                  "Location",
                                  style: txtS(
                                      Color(0xff626262), 16, FontWeight.w400),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: b * 40, top: h * 16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "City",
                                        style: txtS(Color(0xff626262), 16,
                                            FontWeight.w400),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${AddClientVM.instance.clientDetailModel.cityName??""}",
                                        style: txtS(dc, 16, FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  sh(10),
                                  Row(
                                    children: [
                                      Text(
                                        "District",
                                        style: txtS(Color(0xff626262), 16,
                                            FontWeight.w400),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${AddClientVM.instance.clientDetailModel.districtName??""}",
                                        style: txtS(dc, 16, FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  sh(10),
                                  Row(
                                    children: [
                                      Text(
                                        "State",
                                        style: txtS(Color(0xff626262), 16,
                                            FontWeight.w400),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${AddClientVM.instance.clientDetailModel.stateName??""}",
                                        style: txtS(dc, 16, FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
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
                            left: b * 62, right: b * 62, bottom: h * 194),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'images/profile.svg',
                                  allowDrawingOutsideViewBox: true,
                                ),
                                SizedBox(width: b * 5),
                                Text(
                                  "Manager name",
                                  style: txtS(
                                      Color(0xff626262), 16, FontWeight.w400),
                                ),
                                Spacer(),
                                Text(
                                   _userDetailModel?.name??"",
                                  style: txtS(dc, 16, FontWeight.w400),
                                ),
                              ],
                            ),
                            sh(28),
                            Row(
                              children: [
                                Icon(
                                  Icons.memory,
                                  color: Color(0xff8f8f8f),
                                ),
                                SizedBox(width: b * 5),
                                Text(
                                  "Decon Series",
                                  style: txtS(
                                      Color(0xff626262), 16, FontWeight.w400),
                                ),
                                Spacer(),
                                Text(
                                  "${AddClientVM.instance.clientDetailModel.selectedSeries?.replaceFirst(",", "")??""}",
                                  style: txtS(dc, 16, FontWeight.w400),
                                ),
                              ],
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
      ),
    );
  }
}

