import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/View_Web/Authentication/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class OtpPage extends StatefulWidget {
  final String phoneNo;
  final String countryCode;
  OtpPage({@required this.phoneNo,@required this.countryCode});
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;
    BoxDecoration pinPutDecoration = BoxDecoration(
      border: Border.all(
        color: Color(0xFFA9E0FF),
        width: 1,
      ),
      color: Colors.white,
      borderRadius: BorderRadius.circular(h * 5),
    );

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
          Text(
            'Please type the verification code sent to your entered mobile number',
            style: TextStyle(
              color: blc.withOpacity(0.75),
              fontSize: h * 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          sh(25),
          Container(
            padding: EdgeInsets.symmetric(horizontal: b * 520),
            width: SizeConfig.screenWidth,
            child: PinPut(
              withCursor: true,
              fieldsCount: 6,
              textStyle: TextStyle(fontSize: h * 20, color: dc),
              eachFieldWidth: b * 50,
              eachFieldHeight: h * 50,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
            ),
          ),
          sh(24),
          Padding(
            padding: EdgeInsets.only(right: b * 520),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'No Otp ',
                  style: TextStyle(
                    color: dc,
                    fontSize: h * 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Resend it!',
                    style: TextStyle(
                      color: blc,
                      fontSize: h * 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
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
              onPressed: () async {
                 print(_pinPutController.text);
                await LoginVM.instance.manualLogin(_pinPutController.text);
                    
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: h * 13),
                alignment: Alignment.center,
                width: SizeConfig.screenWidth,
                child: Text(
                  'Verify',
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

