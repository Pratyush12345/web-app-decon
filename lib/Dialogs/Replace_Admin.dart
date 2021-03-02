import 'package:Decon/Services/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double b;
  static double v;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    b = screenWidth / 100;
    v = screenHeight / 100;
  }
}

class Replace_Admin extends StatefulWidget {
  final String cityCode;
  final String cityName;
  final String stateName;
  final String phoneNo;
  Replace_Admin({this.cityCode, this.cityName, this.stateName, this.phoneNo});
  @override
  _Replace_Admin createState() => _Replace_Admin();
}

class _Replace_Admin extends State<Replace_Admin> {
  final _phoneNoController = TextEditingController();
  final _nameController = TextEditingController();
  final _adminpostController = TextEditingController();

  String errorname = "", errorphoneno = "", errorpost = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.fromLTRB(
                SizeConfig.screenWidth * 0.05,
                SizeConfig.screenHeight * 0.25,
                SizeConfig.screenWidth * 0.05,
                SizeConfig.screenHeight * 0.27),
            elevation: 5,
            color: Color(0xff263238),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SizeConfig.b * 2.25),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(SizeConfig.b * 2.5,
                  SizeConfig.v * 0.5, SizeConfig.b * 2.5, SizeConfig.v * 3),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.v * 2.5),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Name",
                            style: TextStyle(
                                fontSize: SizeConfig.b * 4.07,
                                color: Colors.white)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(
                                  SizeConfig.b * 5.09, 0, 0, 0),
                              width: SizeConfig.b * 50,
                              decoration: BoxDecoration(
                                  color: Color(0xffDEE0E0),
                                  borderRadius:
                                      BorderRadius.circular(SizeConfig.b * 1)),
                              child: TextField(
                                controller: _nameController,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: SizeConfig.b * 4.3),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Enter Name',
                                  hintStyle:
                                      TextStyle(fontSize: SizeConfig.b * 4),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            if (errorname != "")
                              Text(
                                errorname,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.red),
                              ),
                          ],
                        ),
                      ]),
                  SizedBox(height: SizeConfig.v * 1.5),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Post",
                            style: TextStyle(
                                fontSize: SizeConfig.b * 4.07,
                                color: Colors.white)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(
                                  SizeConfig.b * 5.09, 0, 0, 0),
                              width: SizeConfig.b * 50,
                              decoration: BoxDecoration(
                                  color: Color(0xffDEE0E0),
                                  borderRadius:
                                      BorderRadius.circular(SizeConfig.b * 1)),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: _adminpostController,
                                style: TextStyle(fontSize: SizeConfig.b * 4.3),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Enter Post',
                                  hintStyle:
                                      TextStyle(fontSize: SizeConfig.b * 4),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            if (errorpost != "")
                              Text(
                                errorpost,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.red),
                              ),
                          ],
                        ),
                      ]),
                  SizedBox(height: SizeConfig.v * 4),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mobile Number",
                            style: TextStyle(
                                fontSize: SizeConfig.b * 4.07,
                                color: Colors.white)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(
                                  SizeConfig.b * 5.09, 0, 0, 0),
                              width: SizeConfig.b * 50,
                              decoration: BoxDecoration(
                                  color: Color(0xffDEE0E0),
                                  borderRadius:
                                      BorderRadius.circular(SizeConfig.b * 1)),
                              child: TextField(
                                controller: _phoneNoController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: SizeConfig.b * 4.3),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Enter Phone Number',
                                  hintStyle:
                                      TextStyle(fontSize: SizeConfig.b * 4),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            if (errorphoneno != "")
                              Text(
                                errorphoneno,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.red),
                              ),
                          ],
                        ),
                      ]),
                  SizedBox(height: SizeConfig.v * 4),
                  SizedBox(
                    width: SizeConfig.screenWidth * 120 / 360,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        if (_phoneNoController.text == "") {
                          setState(() {
                            errorname = "Name is required";
                          });
                        } else {
                          errorname = "";
                          if (_adminpostController.text == "") {
                            setState(() {
                              errorpost = "Post is required";
                            });
                          } else {
                            errorpost = "";

                            if (_phoneNoController.text == "") {
                              setState(() {
                                errorphoneno = "Phone No required";
                              });
                            } else if (_phoneNoController.text.length != 10) {
                              setState(() {
                                errorphoneno =
                                    "Phone No should be of 10 digits";
                              });
                            } else {
                              FirebaseFirestore.instance
                                  .collection('CurrentLogins')
                                  .doc("+91${_phoneNoController.text}")
                                  .set({
                                "value":
                                    "Admin@${_adminpostController.text}_${widget.cityName}_${widget.cityCode}_None_${widget.stateName}"
                              });

                              DataSnapshot snapshot = await FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child("/adminsList/")
                                  .orderByChild("phoneNo")
                                  .equalTo(widget.phoneNo)
                                  .once();

                              Map _map = snapshot.value;

                              _map.forEach((key, value) {
                                FirebaseDatabase.instance
                                    .reference()
                                    .child("/adminsList/$key")
                                    .remove();
                              });
                              FirebaseDatabase.instance
                                  .reference()
                                  .child("adminsList")
                                  .push()
                                  .update({
                                "name": _nameController.text,
                                "phoneNo": "+91${_phoneNoController.text}",
                                "post": "Admin@${_adminpostController.text}",
                                "cityName": widget.cityName,
                                "stateName": widget.stateName,
                                "cityCode": widget.cityCode,
                                "rangeOfDeviceEx": "None"
                              });
                              Navigator.of(context).pop();
                            }
                          }
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Color(0xff00A3FF),
                      child: Text(
                        'Replace',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.b * 4.2,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
