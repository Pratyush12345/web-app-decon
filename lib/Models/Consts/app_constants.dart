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