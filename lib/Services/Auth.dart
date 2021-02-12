import 'package:Decon/MessagingService/FirebaseMessaging.dart';
import 'package:Decon/Models/Models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

String name;
String email;
String imageUrl;
BuildContext context;

abstract class BaseAuth {
  Future<void> signInWithOTP(String smscode, String verificationID);
  signOut();
}

class Auth implements BaseAuth {
  static Auth instance = Auth._();
  Auth._() {
    _sharedprefinit();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User currentuser;
  SharedPreferences pref;
  String post, displayName;
  String cityName;
  String cityCode, rangeOfDevicesEx, delegate;
  double manholedepth,
      criticalLevelAbove,
      informativelevelabove,
      normalLevelabove,
      groundlevelbelow,
      batteryThresholdvalue;
  double tempThresholdValue;
  BuildContext changeContext;

  _sharedprefinit() async {
    pref = await SharedPreferences.getInstance();
  }

  Stream<User> get appuser {
    return _firebaseAuth.authStateChanges().map((user) => user);
  }

  Future<String> updateClaims(currentuser) async {
    IdTokenResult idTokenResult = await currentuser.getIdTokenResult(true);
    print("------------");
    print(idTokenResult.claims['post']);
    print(idTokenResult.claims['cityCode']);
    print(idTokenResult.claims['cityName']);
    print(idTokenResult.claims['rangeOfDeviceEx']);
    String postdelegate = idTokenResult.claims['post'];
    if(postdelegate!=null){
       post = postdelegate?.split("@")[0];
       delegate = postdelegate?.split("@")[1];
    }
    cityCode = idTokenResult.claims['cityCode'];
    cityName = idTokenResult.claims['cityName'];
    rangeOfDevicesEx = idTokenResult.claims['rangeOfDeviceEx'];
    print("------------");
    _fetchName();
    _updateToken();
    if (Auth.instance.post != "Manager") await _loadDeviceSettings();
    return "done";
  }

  Future<String> delayedLogin(User currentUser) async {
    Auth.instance.pref.setBool("isSignedIn", true);
    await Future.delayed(Duration(seconds: 10));
    String value = await updateClaims(currentuser);
    // _updateNameInDatabase(globalname);
    return value;
  }

  signInWithCred(cred) async {
    currentuser = (await _firebaseAuth.signInWithCredential(cred)).user;
    return "done";
  }

  @override
  signInWithOTP(String verid, String smscode) async {
    AuthCredential authCredential =
        PhoneAuthProvider.credential(verificationId: verid, smsCode: smscode);
    signInWithCred(authCredential);
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

  _fetchName() async {
    if (post == "Manager") {
      displayName = (await FirebaseDatabase.instance
              .reference()
              .child(
                  "/managerList/${FirebaseAuth.instance.currentUser.uid}/name")
              .once())
          .value;
    } else if (post == "Admin") {
      displayName = (await FirebaseDatabase.instance
              .reference()
              .child(
                  "/adminsList/${FirebaseAuth.instance.currentUser.uid}/name")
              .once())
          .value;
    } else if(post!=null) {
      displayName = (await FirebaseDatabase.instance
              .reference()
              .child(
                  "/cities/$cityCode/posts/${FirebaseAuth.instance.currentUser.uid}/name")
              .once())
          .value;
    }
    else{
      displayName = (await FirebaseDatabase.instance
              .reference()
              .child(
                  "/randomUser/${FirebaseAuth.instance.currentUser.uid}/name")
              .once())
          .value;
    }
  }

  _loadDeviceSettings() async {
    String cityCode = Auth.instance.cityCode ?? "C0";
    print(cityCode);
    DataSnapshot snapshot = await FirebaseDatabase.instance
        .reference()
        .child("cities/$cityCode/DeviceSettings")
        .once();
    print(snapshot.value);    
       
    DeviceSettingModel deviceSettingModel =
        DeviceSettingModel.fromSnapshot(snapshot);
    manholedepth = double.parse(deviceSettingModel.manholedepth);
    criticalLevelAbove = double.parse(deviceSettingModel.criticallevelabove);
    informativelevelabove =
        double.parse(deviceSettingModel.informativelevelabove);
    normalLevelabove = double.parse(deviceSettingModel.nomrallevelabove);
    groundlevelbelow = double.parse(deviceSettingModel.groundlevelbelow);
    tempThresholdValue = double.parse(deviceSettingModel.tempthresholdvalue);
    batteryThresholdvalue =
        double.parse(deviceSettingModel.batterythresholdvalue);
  }

  _updateToken() {
    FirebaseMessagingService()
        .sendNotification(); // initializing messaging handlers
    FirebaseMessagingService().flutterlocalnotificationplugin.cancelAll();

    FirebaseMessaging().getToken().then((token) {
      if (post == "Manager") {
        FirebaseDatabase.instance
            .reference()
            .child("/managerList/${FirebaseAuth.instance.currentUser.uid}")
            .update({"tokenid": token});
      } else if (post == "Admin") {
        FirebaseDatabase.instance
            .reference()
            .child("/adminsList/${FirebaseAuth.instance.currentUser.uid}")
            .update({"tokenid": token});
      } else if(post!=null) {
        FirebaseDatabase.instance
            .reference()
            .child(
                "/cities/$cityCode/posts/${FirebaseAuth.instance.currentUser.uid}")
            .update({"tokenid": token});
      }
      else{
        FirebaseDatabase.instance
            .reference()
            .child(
                "/randomUser/${FirebaseAuth.instance.currentUser.uid}")
            .update({"tokenid": token});
      }
    });
  }
}
