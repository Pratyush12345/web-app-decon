import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:flutter/material.dart';

class AlertMessageDialog extends StatelessWidget {
  final String deviceId;
  final String message;
  AlertMessageDialog({@required this.deviceId, @required this.message});
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
    
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
        Container(
          padding: EdgeInsets.fromLTRB(b * 21, h * 15, b * 21, h * 21),
          child: Column(children: [
            sh(10),
                Image.asset(
                      'images/shout.png',
                    height: 80.0),
            sh(10),
            Text(
              "$deviceId",
              textAlign: TextAlign.center,
              style: txtS(dc, b * 16, FontWeight.w400),
            ),
            sh(10),
            Text(
              "$message",
              textAlign: TextAlign.center,
              style: txtS(dc, b * 16, FontWeight.w400),
            ),
            sh(38),
            InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                  padding:
                  EdgeInsets.symmetric(vertical: h * 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                     borderRadius:
                     BorderRadius.circular(h * 5),
                     color: Color(0xfff1f1f1),
                     border: Border.all(color: blc, width: 0.5),
                  ),
                  child: Text(
                     "Close",
                      style: txtS(dc, 14, FontWeight.w400),
                    ),
               ),
            ),
          ]),
        ),
      ]),
    );
  }
}


