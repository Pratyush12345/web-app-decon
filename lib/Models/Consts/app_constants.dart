import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class AppConstant {
   static Widget circulerProgressIndicator(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  static Widget noDataFound(){
    return Center(
      child: Text("No Data Found",
      ),
    );
  }
  static Widget whitenoDataFound(){
    return Center(
      child: Text("No Data Found",
      style: TextStyle(
        color: Colors.white
      ),
      ),
    );
  }
  static Widget noClientFound(){
    return Center(
      child: Text("No Client Found",
      ),
    );
  }
  static Widget addClient(){
    return Center(
      child: Text("Add Client",
      style: TextStyle(
        color: Colors.black
      ),
      ),
    );
  }
}



const Color tc = Color(0xff979797);
const Color dc = Color(0xff263238);
const Color blc = Color(0xff0099ff);

TextStyle txtS(Color col, double siz, FontWeight wg) {
  return TextStyle(
    color: col,
    fontWeight: wg,
    fontSize: SizeConfig.screenWidth / 375 * siz,
  );
}

SizedBox sh(double h) {
  return SizedBox(height: h * SizeConfig.screenHeight / 812);
}
