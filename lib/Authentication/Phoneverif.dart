import 'package:Decon/Authentication/EnterOtp.dart';
import 'package:animator/animator.dart';
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

class PhoneVerif extends StatefulWidget {
  @override
  _PhoneVerifState createState() => _PhoneVerifState();
}

class _PhoneVerifState extends State<PhoneVerif> {
  final _countryCode = TextEditingController(text: "+91");
  final _phoneNoController = TextEditingController();
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Animator<Offset>(
            tween: Tween<Offset>(begin: Offset(1, 1.2), end: Offset(0.7, 1.2)),
            cycles: 1,
            builder: (context, animatorState, child) => FractionalTranslation(
              translation: animatorState.value,
              child: Container(
                height: 300.0,
                width: 400.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150.0),
                    color: Colors.blue.withOpacity(0.2) ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              padding: EdgeInsets.all(22.0),
              children: [
                Animator<Offset>(
                        tween: Tween<Offset>(begin: Offset(-1, -0.4), end: Offset(-0.6, -0.3)),
                        cycles: 1,
                        builder: (context, animatorState, child) =>
                            FractionalTranslation(
                          translation: animatorState.value,
                          child: Container(
                            height: 300.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(180.0),
                color: Color(0xFFE6E7E8)),
                          ),
                        ),
                      ),
                
                Center(
                  child: Text("DECON", style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: 
                      Color(0xff005A87),
                    
                  ),),
                ),      
                SizedBox(
                  height: 50.0,
                ),      
                Container(
                  padding:
                            EdgeInsets.fromLTRB(SizeConfig.b * 5.09, 0, 0, 0),
                        
                  decoration: BoxDecoration(
                            color: Color(0xffDEE0E0),
                            borderRadius:
                                BorderRadius.circular(SizeConfig.b * 1)),
                      alignment: Alignment.center,
                      width: SizeConfig.b * 80,
                      
                  child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                            
                            hintText: 'Enter Your Name',
                            hintStyle: TextStyle(fontSize: SizeConfig.b * 3.7),
                            border: InputBorder.none,
                          ),
                      
                    ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                            color: Color(0xffDEE0E0),
                            borderRadius:
                                BorderRadius.circular(SizeConfig.b * 1)),
                      alignment: Alignment.center,
                      width: SizeConfig.b * 10,
                          
                      child: TextField(
                          autofocus: false,
                           controller: _countryCode,
                          style: TextStyle(fontSize: SizeConfig.b * 4),
                          decoration: InputDecoration(
                            
                            hintStyle: TextStyle(fontSize: SizeConfig.b * 3.7),
                            border: InputBorder.none,
                          ),
                          
                        ),
                    ),
                    SizedBox(width: 30.0,),
                    Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.fromLTRB(SizeConfig.b * 5.09, 0, 0, 0),
                        width: SizeConfig.b * 70,
                        decoration: BoxDecoration(
                            color: Color(0xffDEE0E0),
                            borderRadius:
                                BorderRadius.circular(SizeConfig.b * 1)),
                        child: TextField(
                          controller: _phoneNoController,
                          style: TextStyle(fontSize: SizeConfig.b * 4),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            
                            hintText: 'Enter Your Mobile Number',
                            hintStyle: TextStyle(fontSize: SizeConfig.b * 3.7),
                            border: InputBorder.none,
                          ),
                        ),
                      ),  
                  ],
                ),
                SizedBox(
                  height: 75.0,
                ),
                Center(
                 
                  child: ButtonTheme(
                         height: 45.0,
                         minWidth: 100.0,
                                      child: RaisedButton(
                          
                          shape: RoundedRectangleBorder(
                            
                            borderRadius: BorderRadius.circular(24.0),
                            side: BorderSide(color: Colors.blue)
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EnterOTP(phoneNo: _countryCode.text.trim()+_phoneNoController.text.trim() , name: _nameController.text.trim(),)));
                          },
                          child: Text("Login"),
                          textColor: Colors.white,
                          elevation: 7.0,
                          color: Colors.blue,
                        ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
