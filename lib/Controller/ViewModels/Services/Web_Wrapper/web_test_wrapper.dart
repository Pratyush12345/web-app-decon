import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
import 'package:Decon/Controller/ViewModels/Services/test.dart';
import 'package:Decon/View_Web/Authentication/Wait.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WebTestWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _returnfuture() async{
      await Future.delayed(Duration(seconds: 4));
      return "done";
    }
    _returnFuture() async{
      return Auth.instance.pref.getBool("isSignedIn")??false ? Auth.instance.alreadyLogin(FirebaseAuth.instance.currentUser)  : Auth.instance.firstTimeLogin(FirebaseAuth.instance.currentUser);
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