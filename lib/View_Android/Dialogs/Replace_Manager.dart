import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Controller/ViewModels/dialog_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class Replace_Manager extends StatefulWidget {
  final String clientVisible;
  final String uid;
  Replace_Manager({this.clientVisible, this.uid});
  @override
  _Replace_Manager createState() => _Replace_Manager();
}

class _Replace_Manager extends State<Replace_Manager> {
  
  final _phoneNoController = TextEditingController();
  final _nameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  void validate() async{
    if(_formKey.currentState.validate()){
          
    DialogVM.instance.onReplaceManagerPressed(context, _nameController.text.trim(), widget.clientVisible,
     _phoneNoController.text.trim(), widget.uid);
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
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: SizeConfig.b * 4.3),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          hintText: 'Enter Name',
                          hintStyle:
                              TextStyle(fontSize: SizeConfig.b * 4),
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
                      child: Text("Phone Number",
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
                        controller: _phoneNoController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: SizeConfig.b * 4.3),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                            fillColor: Colors.white,
                            filled: true,
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
              SizedBox(
                width: SizeConfig.screenWidth * 120 / 360,
                child: MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    validate();
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
      ),
    );
  }
}
