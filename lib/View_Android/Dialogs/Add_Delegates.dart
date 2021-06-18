import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/ViewModels/dialog_viewmodel.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Add_Delegates extends StatefulWidget {
  @override
  _Add_Delegates createState() => _Add_Delegates();
}


class _Add_Delegates extends State<Add_Delegates> {

  final _phoneNumberController = TextEditingController();
  final _postnameController = TextEditingController();
  final _nameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  void validate(){
    if(_formKey.currentState.validate()){
       DialogVM.instance.onAddDelegatePressed(context, _nameController.text.trim(), _postnameController.text.trim(), _phoneNumberController.text.trim());
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
                        keyboardType: TextInputType.text,
                        controller: _nameController,
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
              SizedBox(height: SizeConfig.v * 2),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text("Enter Post",
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
                        keyboardType: TextInputType.text,
                        controller: _postnameController,
                        style: TextStyle(fontSize: SizeConfig.b * 4.3),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                          fillColor: Colors.white,
                          filled: true,
                          
                          isDense: true,
                          hintText: 'Post',
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
                              fontSize: SizeConfig.b * 4.07,
                              color: Colors.white)),
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
                        keyboardType: TextInputType.number,
                        controller: _phoneNumberController,
                        style: TextStyle(fontSize: SizeConfig.b * 4.3),
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
                    
                  ]),
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
