
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:flutter/material.dart';

class WebNoInternetScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
     var h = SizeConfig.screenHeight / 900;
     var b = SizeConfig.screenWidth / 1440;


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Decon"),),
        body: Center(
          child: Container(
            margin: EdgeInsets.only(bottom: h * 67),
            child: Column(
              children: [
                sh(170),
                Image.asset(
                     'images/noConnect.png',
                    
                    height: h * 340),
                Spacer(),
                Text(
                  'No Internet Connection!',
                  
                  style: txtS(blc, 28, FontWeight.w700),
                ),
                sh(47),
                Text(
                  'Something went wrong.\nPlease try again',
                  textAlign: TextAlign.center,
                  style: txtS(Color(0xff908e9c), 18, FontWeight.w500),
                ),
                Spacer(),
               
              ],
            ),
          ),
        ),
      ),
    );

 
  }

}