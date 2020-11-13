import 'package:Decon/Models/Models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Add_Delegates extends StatefulWidget {
  DelegateModel delegateModel;
  Add_Delegates({@required this.delegateModel});
  @override
  _Add_Delegates createState() => _Add_Delegates();
}

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

class _Add_Delegates extends State<Add_Delegates> {
  final _phoneNumberController = TextEditingController();
  final _postnameController = TextEditingController();
  final _nameController = TextEditingController();
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
                  padding: EdgeInsets.fromLTRB(SizeConfig.b * 2.5,
                      SizeConfig.v * 0.5, SizeConfig.b * 2.5, SizeConfig.v * 3),
                  child: Column(children: [
                    
                    SizedBox(height: SizeConfig.v * 1.5),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Name",
                              style: TextStyle(
                                  fontSize: SizeConfig.b * 4.07,
                                  color: Colors.white)),
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
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Mobile Number",
                              style: TextStyle(
                                  fontSize: SizeConfig.b * 4.07,
                                  color: Colors.white)),
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
                              controller: _phoneNumberController,
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
                        ]),
                    
                    SizedBox(height: SizeConfig.v * 2),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Enter Post",
                              style: TextStyle(
                                  fontSize: SizeConfig.b * 4.07,
                                  color: Colors.white)),
                          
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(
                                SizeConfig.b * 5.09, 0, 0, 0),
                            width: SizeConfig.b * 40,
                            decoration: BoxDecoration(
                                color: Color(0xffDEE0E0),
                                borderRadius:
                                    BorderRadius.circular(SizeConfig.b * 1)),
                            child: TextField(

                              controller: _postnameController,
                              style: TextStyle(fontSize: SizeConfig.b * 4.3),
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Post',
                                hintStyle:
                                    TextStyle(fontSize: SizeConfig.b * 4),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ]),
                    SizedBox(height: SizeConfig.v * 6),
                    SizedBox(
                        child: MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: ()async{
                        FirebaseDatabase.instance.reference()
                          .child("cities/${widget.delegateModel.cityCode??"C0"}/posts").push().update({
                          "name": _nameController.text,
                          "phoneNo": "+91${_phoneNumberController.text}",
                          "post": "${_postnameController.text}",
                          "cityName": "${widget.delegateModel.cityName}",
                          "stateName": "${widget.delegateModel.stateName}"
                          });
                        FirebaseFirestore.instance
                        .collection('CurrentLogins')
                        .doc("+91${_phoneNumberController.text}")
                        .set({
                      "value":
                          "${_postnameController.text}_${widget.delegateModel.cityName}_${widget.delegateModel.cityCode}_None_${widget.delegateModel.stateName}"
                    });
                                  Navigator.of(context).pop();

                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.b * 15.3,
                                    vertical: SizeConfig.v * 1.8),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(SizeConfig.b * 6.7),
                                  color: Color(0xff00A3FF),
                                ),
                                child: Text('ADD',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: SizeConfig.b * 4.2,
                                        fontWeight: FontWeight.w400))))),
                  ]),
                )));
  }
}
