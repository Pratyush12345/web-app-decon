import 'package:Decon/Controller/ViewModels/dialog_viewmodel.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Add_admin extends StatefulWidget {
  
  @override
  _Add_admin createState() => _Add_admin();
}


class _Add_admin extends State<Add_admin> {
  final _phoneNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _adminpostController = TextEditingController();
  final _clientController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final dbRef = FirebaseDatabase.instance;

  void validate() async{
    if(_formKey.currentState.validate()){
          

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
                                         
                                        "clientsVisible": _clientController.text.trim(),
                                    
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
    else{
      print("Not Validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
      horizontal: SizeConfig.screenWidth * 25 / 360,
      ),
     shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(SizeConfig.b * 2.25),
     ),
    
      child: Container(
        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 4.0),
        decoration: BoxDecoration(
        color: Color(0xff263238),
        borderRadius: BorderRadius.circular(SizeConfig.b * 2.25)
      ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: SizeConfig.v * 2.5),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text("Client Code",
                          style: TextStyle(
                              fontSize: SizeConfig.b * 4.07,
                              color: Colors.white)),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        validator: (val){
                        if(val.isEmpty)
                        return "Client Code Cannot be empty";
                        else
                        return null;
                      },
                        controller: _clientController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: SizeConfig.b * 4.3),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          hintText: 'Enter Client Code',
                          hintStyle: TextStyle(fontSize: SizeConfig.b * 4),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ]),
              SizedBox(height: SizeConfig.v * 1.5),
              
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text("Name",
                          style: TextStyle(
                              fontSize: SizeConfig.b * 4.07,
                              color: Colors.white)),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        validator: (val){
                        if(val.isEmpty)
                        return "Name Cannot be empty";
                        else
                        return null;
                      },
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: SizeConfig.b * 4.3),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          hintText: 'Enter Name',
                          hintStyle: TextStyle(fontSize: SizeConfig.b * 4),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    
                  ]),
              SizedBox(height: SizeConfig.v * 1.5),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text("Post",
                          style: TextStyle(
                              fontSize: SizeConfig.b * 4.07,
                              color: Colors.white)),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        validator: (val){
                        if(val.isEmpty)
                        return "Post Cannot be empty";
                        else
                        return null;
                      },
                        controller: _adminpostController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: SizeConfig.b * 4.3),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          hintText: 'Enter Post',
                          hintStyle: TextStyle(fontSize: SizeConfig.b * 4),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ]),
              SizedBox(height: SizeConfig.v * 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Mobile Number",
                        style: TextStyle(
                            fontSize: SizeConfig.b * 4.07, color: Colors.white)),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      validator: (val){
                        if(val.isEmpty)
                        return "Phone Number Cannot be empty";
                        else
                        return null;
                      },
                      controller: _phoneNumberController,
                      style: TextStyle(fontSize: SizeConfig.b * 4.3),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                          fillColor: Colors.white,
                          filled: true,
                        isDense: true,
                        hintText: 'Enter Phone Number',
                        hintStyle: TextStyle(fontSize: SizeConfig.b * 4),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  
                ],
              ),
              SizedBox(height: SizeConfig.v * 4),
              SizedBox(
                  width: SizeConfig.screenWidth * 100 / 360,
                  child: MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        validate();
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
