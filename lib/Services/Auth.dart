import 'package:Decon/Models/Models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

String name;
String email;
String imageUrl;
BuildContext context;

abstract class BaseAuth {
  Future<void> signInWithOTP(String smscode, String verificationID, String name);
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
  String post, globalname;
  String cityName;
  String cityCode, rangeOfDevicesEx;
  double manholedepth, criticalLevelAbove, informativelevelabove, normalLevelabove, groundlevelbelow,
  batteryThresholdvalue;
  double tempThresholdValue;
  BuildContext changeContext;

  _sharedprefinit() async{
    pref = await  SharedPreferences.getInstance(); 
  }

  Stream<User> get appuser{
    return _firebaseAuth.authStateChanges().map((user) => user);
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
  Future<String> delayedLogin(User currentUser) async{
   Auth.instance.pref.setBool("isSignedIn", true);  
   await Future.delayed(Duration(seconds: 10));     
   String value= await updateClaims(currentuser);
    _updateNameInDatabase(globalname);
   return value;
  }
  signInWithCred(cred, name)async{
   globalname = name; 
   currentuser= (await _firebaseAuth.signInWithCredential(cred)).user;
   currentuser.updateProfile(displayName: name);
   currentuser.reload();
   return "done";
  }
  
  @override
  signInWithOTP(String verid, String smscode, String name ) async {
   AuthCredential authCredential = PhoneAuthProvider.credential(verificationId: verid, smsCode: smscode);
   signInWithCred(authCredential, name);
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
   await FirebaseDatabase.instance.reference().child("/managerList/${FirebaseAuth.instance.currentUser.uid}").update(
     {
       "name" : name
     });
   }
   else if(post =="Admin"){
     await FirebaseDatabase.instance.reference().child("/adminsList/${FirebaseAuth.instance.currentUser.uid}").update(
     {
       "name" : name
     });
   }
   else{
     await FirebaseDatabase.instance.reference().child("/cities/$cityCode/posts/${FirebaseAuth.instance.currentUser.uid}").update(
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
    groundlevelbelow = double.parse(deviceSettingModel.groundlevelbelow);
    tempThresholdValue = double.parse(deviceSettingModel.tempthresholdvalue);
    batteryThresholdvalue = double.parse(deviceSettingModel.batterythresholdvalue);

  }  
}
