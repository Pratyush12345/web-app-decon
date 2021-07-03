import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
class Profile extends StatefulWidget {
  final bool myProfile;
  final UserDetailModel userDetailModel;
  Profile({@required this.myProfile,@required this.userDetailModel});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                sh(148),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: b * 32, right: b * 32, bottom: h * 116),
                      alignment: Alignment.centerRight,
                      height: h * 139,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(h * 10),
                        color: Color(0xffc1ebff),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff34546a),
                            dc,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: h * 47,
                      left: b * 108,
                      child: Container(
                        height: h * 165,
                        width: b * 165,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 16,
                              spreadRadius: 0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://images.unsplash.com/photo-1517423440428-a5a00ad493e8',
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin:
                                EdgeInsets.fromLTRB(b * 32, 0, b * 47, h * 0),
                            padding: EdgeInsets.fromLTRB(
                                b * 21, h * 30, b * 21, h * 30),
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
                            child: Column(
                              children: [
                                Text(
                                  "${widget.userDetailModel.name??""}",
              
                                  style: txtS(blc, 28, FontWeight.w700),
                                ),
                                sh(19),
                                Text(
                                  "${widget.userDetailModel.post??""}",
              
                                  style: txtS(dc, 20, FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            alignment: Alignment.center,
                            margin:
                                EdgeInsets.fromLTRB(b * 32, 0, b * 47, h * 231),
                            padding: EdgeInsets.fromLTRB(
                                b * 21, h * 23, b * 21, h * 23),
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
                            child: Row(
                              children: [
                                Text(
                                  "Phone Number",
                                  style: txtS(
                                      Color(0xff626262), 16, FontWeight.w400),
                                ),
                                Spacer(),
                                Text(
                                  "${widget.userDetailModel.phoneNo??""}",
                                   style: txtS(dc, 16, FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(b * 47, 0, b * 32, h * 231),
                        padding:
                            EdgeInsets.fromLTRB(b * 50, h * 45, b * 50, h * 45),
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Post",
                                  style: txtS(
                                      Color(0xff626262), 16, FontWeight.w400),
                                ),
                                Spacer(),
                                Text(
                                  widget.userDetailModel.post == "Admin" ? "${widget.userDetailModel.delegate??""}" :"${widget.userDetailModel.post??""}",
                        
                                  style: txtS(dc, 16, FontWeight.w400),
                                ),
                              ],
                            ),
                            // sh(40),
                            // Row(
                            //   children: [
                            //     Text(
                            //       "Email Address",
                            //       style: txtS(
                            //           Color(0xff626262), 16, FontWeight.w400),
                            //     ),
                            //     Spacer(),
                            //     Text(
                            //       "ritesh.shuklalmp2018@gmail.com",
                            //       style: txtS(dc, 16, FontWeight.w400),
                            //     ),
                            //   ],
                            // ),
                            sh(40),
                            Row(
                              children: [
                                Text(
                                  "Assigned Clients",
                                  style: txtS(
                                      Color(0xff626262), 16, FontWeight.w400),
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.userDetailModel.post == "SuperAdmin" ? "All Clients" :"${widget.userDetailModel.clientsVisible.replaceFirst(",", "")??""}",
                        
                                      style: txtS(dc, 16, FontWeight.w400),
                                    ),
                                    // Text(
                                    //   "Jodhpur",
                                    //   style: txtS(dc, 16, FontWeight.w400),
                                    // ),
                                  ],
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

