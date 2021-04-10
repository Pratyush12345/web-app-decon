import 'package:Decon/Controller/Services/Auth.dart';
import 'package:Decon/Controller/Services/test.dart';
import 'package:Decon/View_Android/Authentication/Wait.dart';
import 'package:Decon/View_Android/MainPage/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Wrapper3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _returnfuture() async{
      await Future.delayed(Duration(seconds: 4));
      return "done";
    }
    _returnFuture() async{
      return Auth.instance.pref.getBool("isSignedIn")??false ? Auth.instance.updateClaims(FirebaseAuth.instance.currentUser)  : Auth.instance.delayedLogin(FirebaseAuth.instance.currentUser);
    }
    return FutureBuilder(
      //future: _returnfuture(),
      future: _returnFuture(), 
        
      builder:(context, snapshot){
        if(snapshot.connectionState==ConnectionState.done){
          if(snapshot.hasData){
            return TestPage();
          }
          return Wait();
        }
        else{
          return Wait();
        }
      } );
  }
}