import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/ViewModels/Services/test.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Android/series_S0/BottomLayout_S0.dart';
import 'package:Decon/View_Android/series_S0/DeviceSetting_S0.dart';
import 'package:Decon/View_Android/series_S1/BottomLayout_S1.dart';
import 'package:Decon/View_Android/series_S1/DeviceSetting_S1.dart';
import 'package:Decon/View_Web/Authentication/Wait.dart';
import 'package:Decon/View_Web/MainPage/HomePage.dart';
import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
import 'package:Decon/View_Web/MainPage/HomePage2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class WebFutureWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _returnFuture() async{
      SharedPreferences pref = await SharedPreferences.getInstance();
      print("issigned in mmmmmmmmmmmmmmmmmmmm");
      print(pref.getBool("isSignedIn"));
      print("issigned in mmmmmmmmmmmmmmmmmmmm");
      return pref.getBool("isSignedIn")!=null ? Auth.instance.alreadyLogin(FirebaseAuth.instance.currentUser)  : Auth.instance.firstTimeLogin(FirebaseAuth.instance.currentUser);
    }
    return FutureBuilder(
        //future: Auth.instance.pref.getBool("isSignedIn")??false ? Auth.instance.updateClaims(FirebaseAuth.instance.currentUser)  : Auth.instance.delayedLogin(FirebaseAuth.instance.currentUser),
        future: _returnFuture(),
        builder: (context, snap) {
          if(snap.connectionState==ConnectionState.done){
        
          if (snap.hasData) {
            return HomePage2();
                  
          }
           return Wait();
          } else {
            return Wait();
          }
        },
      );
  }
}
