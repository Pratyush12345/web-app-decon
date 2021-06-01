import 'package:Decon/Models/Models.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Add_admin extends StatefulWidget {
  final int cityLength;
  Add_admin({@required this.cityLength});
  @override
  _Add_admin createState() => _Add_admin();
}


class _Add_admin extends State<Add_admin> {
  final _phoneNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _adminpostController = TextEditingController();
  final _stateNameController = TextEditingController();
  final _cityNameController = TextEditingController();
  final _sheetURLController = TextEditingController();
  final dbRef = FirebaseDatabase.instance;
  String errorname = "",
      errorcityname = "",
      errorstatename = "",
      errorphoneno = "",
      errorpost = "",
      errorsheeturl = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Card(
        margin: EdgeInsets.fromLTRB(
            SizeConfig.screenWidth * 0.05,
            SizeConfig.screenHeight * 0.2,
            SizeConfig.screenWidth * 0.05,
            SizeConfig.screenHeight * 0.21),
        elevation: 5,
        color: Color(0xff263238),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.b * 2.25),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(SizeConfig.b * 2.5, SizeConfig.v * 0.5,
              SizeConfig.b * 2.5, SizeConfig.v * 3),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.v * 2.5),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.fromLTRB(SizeConfig.b * 5.09, 0, 0, 0),
                      width: SizeConfig.b * 40,
                      decoration: BoxDecoration(
                          color: Color(0xffDEE0E0),
                          borderRadius:
                              BorderRadius.circular(SizeConfig.b * 1)),
                      child: TextField(
                        controller: _cityNameController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: SizeConfig.b * 4.3),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'City Name',
                          hintStyle: TextStyle(fontSize: SizeConfig.b * 4),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (errorcityname != "")
                      Text(
                        errorcityname,
                        style: TextStyle(fontSize: 12.0, color: Colors.red),
                      ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.fromLTRB(SizeConfig.b * 5.09, 0, 0, 0),
                      width: SizeConfig.b * 40,
                      decoration: BoxDecoration(
                          color: Color(0xffDEE0E0),
                          borderRadius:
                              BorderRadius.circular(SizeConfig.b * 1)),
                      child: TextField(
                        controller: _stateNameController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: SizeConfig.b * 4.3),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'State Name',
                          hintStyle: TextStyle(fontSize: SizeConfig.b * 4),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (errorstatename != "")
                      Text(
                        errorstatename,
                        style: TextStyle(fontSize: 12.0, color: Colors.red),
                      ),
                  ],
                ),
              ]),
              SizedBox(height: SizeConfig.v * 1.5),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Name of Admin",
                        style: TextStyle(
                            fontSize: SizeConfig.b * 4.07,
                            color: Colors.white)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: SizeConfig.b * 4.3),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Enter Name',
                              hintStyle: TextStyle(fontSize: SizeConfig.b * 4),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        if (errorname != "")
                          Text(
                            errorname,
                            style: TextStyle(fontSize: 12.0, color: Colors.red),
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
                          padding:
                              EdgeInsets.fromLTRB(SizeConfig.b * 5.09, 0, 0, 0),
                          width: SizeConfig.b * 50,
                          decoration: BoxDecoration(
                              color: Color(0xffDEE0E0),
                              borderRadius:
                                  BorderRadius.circular(SizeConfig.b * 1)),
                          child: TextField(
                            controller: _adminpostController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: SizeConfig.b * 4.3),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Enter Post',
                              hintStyle: TextStyle(fontSize: SizeConfig.b * 4),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        if (errorpost != "")
                          Text(
                            errorpost,
                            style: TextStyle(fontSize: 12.0, color: Colors.red),
                          ),
                      ],
                    ),
                  ]),
              SizedBox(height: SizeConfig.v * 1.5),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Sheet URL",
                        style: TextStyle(
                            fontSize: SizeConfig.b * 4.07,
                            color: Colors.white)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            keyboardType: TextInputType.text,
                            controller: _sheetURLController,
                            style: TextStyle(fontSize: SizeConfig.b * 4.3),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Sheet URL',
                              hintStyle: TextStyle(fontSize: SizeConfig.b * 4),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        if (errorsheeturl != "")
                          Text(
                            errorsheeturl,
                            style: TextStyle(fontSize: 12.0, color: Colors.red),
                          ),
                      ],
                    ),
                  ]),
              SizedBox(height: SizeConfig.v * 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mobile Number",
                      style: TextStyle(
                          fontSize: SizeConfig.b * 4.07, color: Colors.white)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          controller: _phoneNumberController,
                          style: TextStyle(fontSize: SizeConfig.b * 4.3),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Phone Number',
                            hintStyle: TextStyle(fontSize: SizeConfig.b * 4),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (errorphoneno != "")
                        Text(
                          errorphoneno,
                          style: TextStyle(fontSize: 12.0, color: Colors.red),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.v * 4),
              SizedBox(
                  width: SizeConfig.screenWidth * 100 / 360,
                  child: MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        if (_cityNameController.text == "") {
                          setState(() {
                            errorcityname = "City Name is required";
                          });
                        } else {
                          errorcityname = "";
                          if (_stateNameController.text == "") {
                            setState(() {
                              errorstatename = "State Name is required";
                            });
                          } else {
                            errorstatename = "";
                            if (_nameController.text == "") {
                              setState(() {
                                errorname = "Name is reuired";
                              });
                            } else {
                              errorname = "";
                              if (_adminpostController.text == "") {
                                setState(() {
                                  errorpost = "Post is Required";
                                });
                              } else {
                                errorpost = "";
                                if (_sheetURLController.text == "") {
                                  setState(() {
                                    errorsheeturl = "Sheet Url is required";
                                  });
                                } else {
                                  errorsheeturl = "";
                                  if (_phoneNumberController.text == "") {
                                    setState(() {
                                      errorphoneno = "Phone No required";
                                    });
                                  } else if (_phoneNumberController
                                          .text.length !=
                                      10) {
                                    setState(() {
                                      errorphoneno =
                                          "Phone No should be of 10 digits";
                                    });
                                  } else {
                                    dbRef
                                        .reference()
                                        .child("clientsList")
                                        .update({
                                      "C${widget.cityLength}":
                                          _cityNameController.text
                                    });
                                    dbRef
                                        .reference()
                                        .child(
                                            "clients/C${widget.cityLength}/DeviceSettings")
                                        .update(DeviceSettingModel(
                                                "4.0",
                                                "1.0",
                                                "2.0",
                                                "3.0",
                                                "3.0",
                                                "50.0",
                                                "20.0")
                                            .toJson());
                                    dbRef
                                        .reference()
                                        .child("clients/C${widget.cityLength}")
                                        .update({
                                      "sheetURL": _sheetURLController.text,
                                      "stateName": _stateNameController.text,
                                    });
                                    dbRef
                                        .reference()
                                        .child("admins")
                                        .push()
                                        .update({
                                      "name": _nameController.text,
                                      "phoneNo":
                                          "+91${_phoneNumberController.text}",
                                      "post":
                                          "Admin@${_adminpostController.text}",
                                       
                                      "clientsVisible": "C${widget.cityLength}"
                                    });
                                    FirebaseFirestore.instance
                                        .collection('CurrentLogins')
                                        .doc(
                                            "+91${_phoneNumberController.text}")
                                        .set({
                                      "value":
                                          "Admin@${_adminpostController.text}_ByManager"
                                    });
                                    Navigator.of(context).pop();
                                  }
                                }
                              }
                            }
                          }
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Color(0xff00A3FF),
                      child: Text('ADD',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.b * 4.2,
                              fontWeight: FontWeight.w400)))),
            ],
          ),
        ),
      ),
    );
  }
}
