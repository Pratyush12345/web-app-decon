import 'package:Decon/MainPage/HomePage.dart';
import 'package:Decon/Authentication/Phoneverif.dart';
import 'package:Decon/Authentication/Wait.dart';
import 'package:Decon/Models/Models.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

String name;
String email;
String imageUrl;
BuildContext context;

abstract class BaseAuth {
  Future<void> signInWithOTP(String smscode, String verificationID, String name, BuildContext context);
  signOut();
}

class Auth implements BaseAuth {
  static Auth instance = Auth._();
  Auth._(){
    _sharedprefinit();
    
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User currentuser;
  SharedPreferences pref; 
  String post;
  String cityName;
  String cityCode, rangeOfDevicesEx;
  double manholedepth, criticalLevelAbove, informativelevelabove, normalLevelabove, groundlevelabove,
   batteryThresholdvalue;
  double tempThresholdValue;
  
  ProgressDialog progressDialog;

  _sharedprefinit() async{
    pref = await  SharedPreferences.getInstance(); 
    
  }

  handleAfterSignIn(){
    return FutureBuilder(
      future: Auth.instance.updateClaims(FirebaseAuth.instance.currentUser),
      builder:(context, snapshot){
        if(snapshot.connectionState==ConnectionState.done){
          if(snapshot.hasData){
          
          return HomePage();
          }
          return Wait();
        }
        else{
          return Wait();
        }
      } 
    
    );
  } 
  handleAuth(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          
          // bool isSignedIn = (Auth.instance.pref.getBool("isSignedIn")??false);
          // if(!isSignedIn){
          // Auth.instance.pref.setBool("isSignedIn", true);
          // Navigator.of(context).pop();
          //}
           return HomePage();
        }
        else{
          return PhoneVerif();
        }
      }
      );
  }
  
  Future<String> updateClaims(currentuser) async {
    IdTokenResult idTokenResult = await currentuser.getIdTokenResult(true);
    print("------------");
    print(idTokenResult.claims['post']);
    
    print(idTokenResult.claims['cityCode']);
    
    print(idTokenResult.claims['cityName']);
    print(idTokenResult.claims['rangeOfDeviceEx']);
    post = idTokenResult.claims['post'];
    cityCode = idTokenResult.claims['cityCode'];
    cityName = idTokenResult.claims['cityName'];
    rangeOfDevicesEx = idTokenResult.claims['rangeOfDeviceEx'];

    print("------------");
     if(Auth.instance.post!="Manager")
    _loadDeviceSettings();
    return "done";
  }
  
  signInWithCred(cred, name, BuildContext context)async{
   currentuser= (await _firebaseAuth.signInWithCredential(cred)).user;
   currentuser.updateProfile(displayName: name);
   currentuser.reload();
   //await Future.delayed(Duration(seconds: 10));
   print("++++++");
   print("Hellow World");
   print("++++++");
   await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FlareLoading(
                name: 'assets/gurucool.flr',
                onSuccess: (_) {
                  Navigator.pop(context);
                },
                onError: (_, __) {},
                startAnimation: 'animation',
                until: () => Future.delayed(Duration(seconds: 10)),
              ),
            ),
          );
   Auth.instance.pref.setBool("isSignedIn", true);       
   await updateClaims(currentuser);
   _updateNameInDatabase(name);
   return "done";
  }
  
  @override
  signInWithOTP(String verid, String smscode, String name, BuildContext context) async {
   AuthCredential authCredential = PhoneAuthProvider.credential(verificationId: verid, smsCode: smscode);
   signInWithCred(authCredential, name, context);
  }
  
  
  @override
  Future<void> signOut() async {
    try {
      await Auth.instance.pref.clear();
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  _updateNameInDatabase(String name)async{

   if(post=="Manager"){ 
   await FirebaseDatabase.instance.reference().child("/managerList/${currentuser.uid}").update(
     {
       "name" : name
     });
   }
   else if(post =="Admin"){
     await FirebaseDatabase.instance.reference().child("/adminsList/${currentuser.uid}").update(
     {
       "name" : name
     });
   }
   else{
     await FirebaseDatabase.instance.reference().child("/cities/$cityCode/posts/${currentuser.uid}").update(
     {
       "name" : name
     });
   }
  }
  _loadDeviceSettings() async{
    DataSnapshot snapshot = await FirebaseDatabase.instance
        .reference()
        .child("cities/${Auth.instance.cityCode}/DeviceSettings")
        .once(); 
    DeviceSettingModel deviceSettingModel =
        DeviceSettingModel.fromSnapshot(snapshot);
    manholedepth = double.parse( deviceSettingModel.manholedepth);
    criticalLevelAbove = double.parse(deviceSettingModel.criticallevelabove);
    informativelevelabove = double.parse(deviceSettingModel.informativelevelabove);
    normalLevelabove = double.parse(deviceSettingModel.nomrallevelabove);
    groundlevelabove = double.parse(deviceSettingModel.groundlevelbelow);
    tempThresholdValue = double.parse(deviceSettingModel.tempthresholdvalue);
    batteryThresholdvalue = double.parse(deviceSettingModel.batterythresholdvalue);

  }  
}
