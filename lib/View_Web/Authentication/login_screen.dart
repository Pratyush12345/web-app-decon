import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/View_Web/Authentication/login_viewmodel.dart';
import 'package:Decon/View_Web/Authentication/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phone = TextEditingController();
  final _countryCode = TextEditingController(text: "+91");
  String _errorPhoneNo = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Image.asset('images/logo.png', height: h * 160, width: b * 140),
          sh(60),
          Text(
            'DECON',
            style: TextStyle(
              color: blc,
              fontSize: h * 26,
              fontWeight: FontWeight.w800,
              letterSpacing: 15,
            ),
          ),
          sh(70),
          Container(
            width: SizeConfig.screenWidth,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: b * 520),
            padding: EdgeInsets.symmetric(horizontal: b * 17, vertical: h * 17),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(h * 5),
              border: Border.all(color: blc, width: 1),
            ),
            child: TextFormField(
              controller: phone,
              keyboardType: TextInputType.number,
              style: TextStyle(
                  fontSize: h * 20,
                  color: dc,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 22),
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Enter Phone Number',
                hintStyle: TextStyle(
                  fontSize: h * 16,
                  color: blc,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0,
                ),
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
          if (_errorPhoneNo != "")
                        Text(
                          "$_errorPhoneNo",
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.red),
                        ),
             
          sh(17),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: b * 520),
            child: MaterialButton(
              padding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: blc,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(h * 6),
              ),
              onPressed: () {
                if (phone.text.length != 10) {
                                setState(() {
                                  _errorPhoneNo =
                                      "Phone No should be of 10 digits";
                      });
                     } 
                    else {
                      LoginVM.instance.verifyPhone(context, _countryCode.text.trim() + phone.text.trim() );
                      Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 300),
                        type: PageTransitionType.rightToLeftWithFade,
                        childCurrent: LoginPage(),
                        child: OtpPage(countryCode: _countryCode.text.trim() ,phoneNo: phone.text.trim(),),
                      ),
                    );
                    }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: h * 13),
                alignment: Alignment.center,
                width: SizeConfig.screenWidth,
                child: Text(
                  'Proceed',
                  style: txtS(wc, 20, FontWeight.w400),
                ),
              ),
            ),
          ),
          Spacer(),
          _buildCard(
            height: h * 240,
            config: CustomConfig(
              colors: [
                Color(0xffccebff),
                blc,
              ],
              durations: [10000, 6000],
              heightPercentages: [0.4, 0.45],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    Config config,
    double height,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      child: WaveWidget(
        config: config,
        backgroundColor: Colors.transparent,
        size: Size(double.infinity, double.infinity),
        waveAmplitude: 50,
        waveFrequency: 2,
      ),
    );
  }
}
