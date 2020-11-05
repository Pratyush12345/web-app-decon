import 'package:Decon/MainPage/HomePage.dart';
import 'package:Decon/Services/Auth.dart';
import 'package:animator/animator.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class EnterOTP extends StatefulWidget {
  final String phoneNo;
  final String name;
  EnterOTP({@required this.phoneNo, @required this.name});
  @override
  _EnterOTPState createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  List<FocusNode> _listisAutoFocused ;
  String phoneNo;
  String smsCode = "";
  String verificationID;
  bool codeSent = false;
  
  verifyPhone(context) async {
    final PhoneVerificationCompleted verfiySuccess =
        (AuthCredential cred) async {
      print("vvvvvvvvvvvvvvvv");
      print("Verify Success");
      print("vvvvvvvvvvvvvvvv");
      String result = await Auth.instance.signInWithCred(cred, widget.name,);
      // if(result!=null){
      //   Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
      // }
      
    };

    final PhoneVerificationFailed verifyFailure = (Exception error) {
      print("++++++++++");
      print(error);
      print("++++++++++");
    };

    final PhoneCodeSent smsCodeSent = (String verid, [int forceCodeResend]) {
      print("sssssssssssssss");
      print("sms code sent");
      print("sssssssssssssss");
      this.verificationID = verid;
    
      setState(() {
        this.codeSent = true;
        //smsCodeDialog(context);
      });
    };
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verid) {
      print("aaaaaaaaaaaaaaa");
      print("auto Retrieve");
      print("aaaaaaaaaaaaaaa");
      this.verificationID = verid;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNo,
        timeout: Duration(seconds: 120),
        verificationCompleted: verfiySuccess,
        verificationFailed: verifyFailure,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve);
  }

  @override
  void initState() {
    _listisAutoFocused = [];
    for(int i=0;i<6;i++){
      
      _listisAutoFocused.add(FocusNode());
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
    //verifyPhone(context);
    });
    verifyPhone(context);
    super.initState();
  }
  Widget _getOTPWidget(int pos, bool isAutoFocused){
    
   return Container(
                      decoration: BoxDecoration(
                            color: Color(0xffDEE0E0),
                            borderRadius:
                                BorderRadius.circular(SizeConfig.b * 1)),
                      alignment: Alignment.center,
                      width: SizeConfig.b * 10,
                          
                      child: TextField(
                          
                          onChanged: (value){
                            
                            if(value.length==1){
                              setState(() {
                                smsCode = smsCode + value;
                                if(pos!=5)
                                FocusScope.of(context).requestFocus(_listisAutoFocused[pos+1]);
                                
                              });
                            }
                          },
                          focusNode: _listisAutoFocused[pos],
                          autofocus: isAutoFocused,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number, 
                          style: TextStyle(fontSize: SizeConfig.b * 4),
                          decoration: InputDecoration(

                            counterText: "",
                            hintStyle: TextStyle(fontSize: SizeConfig.b * 3.7),
                            border: InputBorder.none,
                          ),
                          
                        ),
                    );
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
    return Scaffold(
        
        body: Stack(
        children: [
          // Animator<Offset>(
          //   tween: Tween<Offset>(begin: Offset(1, 1.2), end: Offset(0.7, 1.2)),
          //   cycles: 1,
          //   builder: (context, animatorState, child) => FractionalTranslation(
          //     translation: animatorState.value,
          //     child: Container(
          //       height: 300.0,
          //       width: 400.0,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(150.0),
          //           color: Colors.blue.withOpacity(0.2) ),
          //     ),
          //   ),
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              padding: EdgeInsets.all(24.0),
              children: [
                // Animator<Offset>(
                //         tween: Tween<Offset>(begin: Offset(-1, -0.4), end: Offset(-0.7, -0.3)),
                //         cycles: 1,
                //         builder: (context, animatorState, child) =>
                //             FractionalTranslation(
                //           translation: animatorState.value,
                //           child: Container(
                //             height: 200.0,
                //             width: 350.0,
                //             decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(180.0),
                // color: Color(0xFFE6E7E8)),
                //           ),
                //         ),
                //       ),
                
                Center(
                  child: Text("VERIFICATION", style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: 
                      Colors.grey,
                    
                  ),),
                ),      
                SizedBox(
                  height: 15.0,
                ),
                Center(
                
                  child: Text("Please type the verification code sent to your entered mobile number", style: TextStyle(
                    
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: 
                      Colors.grey,
                    
                  ),
                  textAlign: TextAlign.center,
                  ),
                ),      
                
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getOTPWidget(0,true),
                    SizedBox(width: 15.0,),
                    _getOTPWidget(1, false),
                    SizedBox(width: 15.0,),
                    _getOTPWidget(2, false),
                    SizedBox(width: 15.0,),
                    _getOTPWidget(3, false),
                    SizedBox(width: 15.0,),
                    _getOTPWidget(4, false),
                    SizedBox(width: 15.0,),
                    _getOTPWidget(5, false),
                    SizedBox(width: 15.0,),
                      
                  ],
                ),
                SizedBox(
                  height: 150.0,
                ),
                Center(
                 
                  child: ButtonTheme(
                         height: 60.0,
                         minWidth: 60.0,
                                      child: RaisedButton(
                          
                          shape: RoundedRectangleBorder(
                            
                            borderRadius: BorderRadius.circular(24.0),
                            side: BorderSide(color: Colors.blue)
                          ),
                          onPressed: () async {
                    await Auth.instance.signInWithOTP(verificationID, "123456", widget.name,);
                  },
                          child: Icon(Icons.arrow_right),
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
