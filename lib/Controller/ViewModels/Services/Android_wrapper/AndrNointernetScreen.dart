
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:flutter/material.dart';

class AndrNoInternetScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
     var h = SizeConfig.screenHeight / 812;
     var b = SizeConfig.screenWidth / 375;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Decon"),),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: b * 26),
          child: Center(
            child: Column(
              children: [
                sh(80),
                Image.asset(
                   'images/noConnect.png',
                    height: h * 230),
                sh(75),
                Text( 'No Internet Connection!',
                      
                  style: txtS(blc, b * 20, FontWeight.w700),
                ),
                sh(40),
                Text(
                  'Something went wrong.\nPlease try again',
                  textAlign: TextAlign.center,
                  style: txtS(Color(0xff908e9c), b * 16, FontWeight.w500),
                ),
                sh(100),
                
              ],
            ),
          ),
        ),
      ),
    );

 
  }

}