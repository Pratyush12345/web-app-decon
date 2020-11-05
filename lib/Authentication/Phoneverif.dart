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

class PhoneVerif extends StatefulWidget {
  @override
  _PhoneVerifState createState() => _PhoneVerifState();
}

class _PhoneVerifState extends State<PhoneVerif> {
  final _countryCode = TextEditingController(text: "+91");
  final _phoneNoController = TextEditingController();
  final _nameController = TextEditingController();
  String phoneNo;
  String smsCode = "";
  bool _isphoneVerif = true;
  String verificationID;
  bool codeSent = false;
  List<FocusNode> _listisAutoFocused;

  verifyPhone(context) async {
    final PhoneVerificationCompleted verfiySuccess =
        (AuthCredential cred) async {
      print("vvvvvvvvvvvvvvvv");
      print("Verify Success");
      print("vvvvvvvvvvvvvvvv");
      await Auth.instance.signInWithCred(
        cred,
        _nameController.text.trim(),
      );
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
        phoneNumber: _countryCode.text.trim() + _phoneNoController.text.trim(),
        timeout: Duration(seconds: 120),
        verificationCompleted: verfiySuccess,
        verificationFailed: verifyFailure,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve);
  }

  Widget _getOTPWidget(int pos, bool isAutoFocused, BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffDEE0E0),
          borderRadius: BorderRadius.circular(SizeConfig.b * 1)),
      alignment: Alignment.center,
      width: SizeConfig.b * 10,
      child: TextField(
        onChanged: (value) {
          if (value.length == 1) {
            setState(() {
              smsCode = smsCode + value;
              if (pos != 5)
                FocusScope.of(context)
                    .requestFocus(_listisAutoFocused[pos + 1]);
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
  void initState() {
    _listisAutoFocused = [];
    for (int i = 0; i < 6; i++) {
      _listisAutoFocused.add(FocusNode());
    }
    super.initState();
  }

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
                    color: Colors.blue.withOpacity(0.2)),
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
                  tween: Tween<Offset>(
                      begin: Offset(-1, -0.4), end: Offset(-0.7, -0.3)),
                  cycles: 1,
                  builder: (context, animatorState, child) =>
                      FractionalTranslation(
                    translation: animatorState.value,
                    child: Container(
                      height: 200.0,
                      width: 350.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(180.0),
                          color: Color(0xFFE6E7E8)),
                    ),
                  ),
                ),
                _isphoneVerif? Animator(
                  cycles: 1,
                  tween: Tween<Offset>(
                      begin: Offset(0, -0.5), end: Offset(0, -0.6)),
                  duration: Duration(milliseconds: 500),
                  builder: (context, animatorState, child) =>
                      FractionalTranslation(
                          translation: animatorState.value,
                          child: Container(
                            height: 200.0,
                            width: 200.0,
                            child: Image(
                                key: UniqueKey(),
                                width: 200.0,
                                height: 200.0,
                                image: AssetImage('assets/DECON.png')),
                          )),
                ):Center(
                  child: Text("VERIFICATION", style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: 
                      Colors.grey,
                    
                  ),),
                ),
                _isphoneVerif? Transform(
                  transform: Matrix4.translationValues(0, -60.0, 0),
                  child: Center(
                    child: Text(
                      "DECON",
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff005A87),
                      ),
                    ),
                  ),
                ):Center(
                
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
                  height: 20.0,
                ),
                _isphoneVerif
                    ? Container(
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
                      )
                    :Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _getOTPWidget(0, true, context),
                          SizedBox(
                            width: 15.0,
                          ),
                          _getOTPWidget(1, false, context),
                          SizedBox(
                            width: 15.0,
                          ),
                          _getOTPWidget(2, false, context),
                          SizedBox(
                            width: 15.0,
                          ),
                          _getOTPWidget(3, false, context),
                          SizedBox(
                            width: 15.0,
                          ),
                          _getOTPWidget(4, false, context),
                          SizedBox(
                            width: 15.0,
                          ),
                          _getOTPWidget(5, false, context),
                          SizedBox(
                            width: 15.0,
                          ),
                        ],
                      ), 
                    
                SizedBox(
                  height: 40.0,
                ),
                _isphoneVerif
                    ? Row(
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
                                hintStyle:
                                    TextStyle(fontSize: SizeConfig.b * 3.7),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(
                                SizeConfig.b * 5.09, 0, 0, 0),
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
                                hintStyle:
                                    TextStyle(fontSize: SizeConfig.b * 3.7),
                                border: InputBorder.none,
                              ),
                            ),
                          )
                        ],
                      )
                    :SizedBox(
                        height: 3.0,
                      ), 
                SizedBox(
                  height: 75.0,
                ),
                Center(
                  child: _isphoneVerif
                      ? ButtonTheme(
                          height: 45.0,
                          minWidth: 100.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                side: BorderSide(color: Colors.blue)),
                            onPressed: () async {
                              
                              
                              setState(() {
                                _isphoneVerif = false;
                              });
                              verifyPhone(context);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => EnterOTP(phoneNo: _countryCode.text.trim()+_phoneNoController.text.trim() , name: _nameController.text.trim(),)));
                            },
                            child: Text("Login"),
                            textColor: Colors.white,
                            elevation: 7.0,
                            color: Colors.blue,
                          ),
                        )
                      : ButtonTheme(
                          height: 60.0,
                          minWidth: 60.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                side: BorderSide(color: Colors.blue)),
                            onPressed: () async {
                              await Auth.instance.signInWithOTP(
                                verificationID,
                                smsCode,
                                _nameController.text.trim(),
                              );
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
