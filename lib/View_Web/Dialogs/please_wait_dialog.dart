import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PleaseWait extends StatelessWidget {
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
    
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          padding: EdgeInsets.fromLTRB(b * 21, h * 15, b * 21, h * 21),
            child: Column(children: [
             Container(
               height: h *100,
               width: b * 100,
               child: Center( 
                  child: RiveAnimation.asset('images/loading7.riv',
                  animations: ["loading"],
                  ),
                ),
             ),
            Text(
              "Please Wait...",
              textAlign: TextAlign.center,
              style: txtS(dc, b * 16, FontWeight.w400),
            ),
            sh(38),
            
          ]),
        ),
      ]),
    );
  }
}


