import 'package:Decon/Controller/ViewModels/dialog_viewmodel.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Models.dart';
import 'package:flutter/material.dart';


class Add_man extends StatefulWidget {
  final List<UserDetailModel> list;
  Add_man({@required this.list});
  @override
  _Add_man createState() => _Add_man();
}

class _Add_man extends State<Add_man> {
  final _phoneNoController = TextEditingController();
  final _nameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  void validate(){
    if(_formKey.currentState.validate()){
      DialogVM.instance.onAddManagerPressed(context, _nameController.text.trim(), _phoneNoController.text.trim());                
    }
    else{
      print("Not Validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); 
    var b = SizeConfig.screenWidth / 1440;
    var h = SizeConfig.screenHeight / 900;
    
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: b * 476.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(h * 10),
      ),
    
      child: Container(
        padding: EdgeInsets.fromLTRB(b * 21, h * 15, b * 21, h * 21),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(b * 9)
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              sh(4),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                            "Add Manager",
                            style: TextStyle(
                              fontSize: b * 16,
                              color: dc,
                              fontWeight: FontWeight.w500,
                            ),
                            ),
                      ),
              
            
              sh(6),
                  Text(
                  "Name",
                  style: TextStyle(
                    fontSize: b * 16,
                    color: dc,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
              sh(6),
              TextFormField(
                      
                        validator: (val){
                          if(val.isEmpty)
                          return "Name Cannot be empty";
                          else
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        controller: _nameController,
                        style: TextStyle(fontSize: b * 14, color: dc),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          hintText: 'Enter Name',
                          hintStyle: TextStyle(
                          fontSize: b * 14,
                            color: blc.withOpacity(0.25),
                          ),
                          enabledBorder: OutlineInputBorder(

                            borderSide: BorderSide(color: blc, width: 0.7),
                            borderRadius: BorderRadius.circular(b * 5),
                          ),
                          border: OutlineInputBorder(

                            borderSide: BorderSide(color: blc, width: 0.7),
                            borderRadius: BorderRadius.circular(b * 5),
                          ),
                        ),
                      ),
              sh(11),
                  Text(
                  "Mobile Number",
                  style: TextStyle(
                    fontSize: b * 16,
                    color: dc,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
              sh(6),
              TextFormField(
                        validator: (val){
                          int index = widget.list.indexWhere((element) => element.phoneNo.contains(val));
                          if(val.isEmpty)
                          return "Phone Number Cannot be empty";
                          else if(val.length!=10)
                          return "Phone Number must be of 10 digits";
                          else if(index!=-1)
                          return "Phone No already registered"; 
                          else
                          return null;
                        },
                        controller: _phoneNoController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: b * 14, color: dc),
                        decoration: InputDecoration(
                          
                          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          hintText: 'Enter Phone Number',
                          hintStyle: TextStyle(
                          fontSize: b * 14,
                            color: blc.withOpacity(0.25),
                          ),
                          enabledBorder: OutlineInputBorder(

                            borderSide: BorderSide(color: blc, width: 0.7),
                            borderRadius: BorderRadius.circular(b * 5),
                          ),
                          border: OutlineInputBorder(

                            borderSide: BorderSide(color: blc, width: 0.7),
                            borderRadius: BorderRadius.circular(b * 5),
                          ),),
                      ),
              sh(20),        
              MaterialButton(
              color: Color(0xff00A3FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(b * 6),
              ),
              padding: EdgeInsets.zero,
              onPressed: () {
                validate();
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: b * 16,
                    fontWeight: FontWeight.w500,
                  ),
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
