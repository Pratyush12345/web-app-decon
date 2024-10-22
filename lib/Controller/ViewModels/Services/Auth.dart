import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Models/Consts/database_calls.dart';
import 'package:firebase/firebase.dart' as fDatabase;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/locale.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';



class Auth  {
  static Auth instance = Auth._();
  Auth._() {
    _sharedprefinit();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DatabaseCallServices _databaseCallServices = DatabaseCallServices();
  User currentuser;
  SharedPreferences pref;
  BuildContext changeContext;
  BitmapDescriptor ground_icon;
  BitmapDescriptor normal_icon;
  BitmapDescriptor informative_icon;
  BitmapDescriptor critical_icon;
  

  _sharedprefinit() async {
    pref = await SharedPreferences.getInstance();
  }

  Stream<User> get appuser {
    return _firebaseAuth.authStateChanges().map((user) => user);
  }

  loadMarker() async {
    print("loading markerrrrrrrrrrrrrr");
   ground_icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48),), 'assets/purple-dot.png');
   normal_icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)), 'assets/green-dot.png');
   informative_icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)), 'assets/yellow-dot.png');
   critical_icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)), 'assets/red-dot.png');    
   
  }

  _updateToken() async{
      String token = await  FirebaseMessaging.instance.getToken();
      print("token id");
      print(token);
      try{
           if (GlobalVar.strAccessLevel == "1") {
        fDatabase.database().ref("/superAdmins/${FirebaseAuth.instance.currentUser.uid}")
            .update({"webtokenid": token});
      }
      else if (GlobalVar.strAccessLevel == "2") {
        fDatabase.database().ref("/managers/${FirebaseAuth.instance.currentUser.uid}")
            .update({"webtokenid": token});
      }  
      else if (GlobalVar.strAccessLevel == "3") {
        fDatabase.database().ref("/admins/${FirebaseAuth.instance.currentUser.uid}")
            .update({"webtokenid": token});
      }
      else if (GlobalVar.strAccessLevel == "4") {
        fDatabase.database().ref("/managerTeam/${FirebaseAuth.instance.currentUser.uid}")
            .update({"webtokenid": token});
      }
      else if (GlobalVar.strAccessLevel == "5") {
        fDatabase.database().ref("/adminTeam/${FirebaseAuth.instance.currentUser.uid}")
            .update({"webtokenid": token});
      }
      else {
        fDatabase.database().ref("/randomUser/${FirebaseAuth.instance.currentUser.uid}")
            .update({"webtokenid": token});
      }
      }catch(e){
        print(e);
        print("erorr");
      }
 }
   _getUserCredentails() async{
    if(GlobalVar.strAccessLevel == "1"){
       GlobalVar.userDetail =  await _databaseCallServices.getSuperAdminCredentails(FirebaseAuth.instance.currentUser.uid);
    }
    else if(GlobalVar.strAccessLevel == "2"){
      GlobalVar.userDetail =  await _databaseCallServices.getManagerCredentails(FirebaseAuth.instance.currentUser.uid);
    }
    else if(GlobalVar.strAccessLevel == "3"){
      GlobalVar.userDetail =  await _databaseCallServices.getAdminCredentails(FirebaseAuth.instance.currentUser.uid);
    }
    else if(GlobalVar.strAccessLevel == "4"){
      GlobalVar.userDetail =  await _databaseCallServices.getManagerTeamCredentails(FirebaseAuth.instance.currentUser.uid);
      GlobalVar.userDetail.clientsVisible = await _databaseCallServices.getManagerClientsVisible(GlobalVar.userDetail.headUid);
    }
    else if(GlobalVar.strAccessLevel == "5"){
      GlobalVar.userDetail =  await _databaseCallServices.getAdminTeamCredentails(FirebaseAuth.instance.currentUser.uid);
      GlobalVar.userDetail.clientsVisible = await _databaseCallServices.getAdminClientsVisible(GlobalVar.userDetail.headUid);
    }
    else{
      GlobalVar.userDetail =  await _databaseCallServices.getRandomUserCredentails(FirebaseAuth.instance.currentUser.uid);
      GlobalVar.userDetail.clientsVisible = "C0";
    }
  }

  Future<String> _getClaims(currentuser) async {
    try{
    IdTokenResult idTokenResult = await currentuser.getIdTokenResult(true);
    print("accessLevel==============="+idTokenResult.claims['accessLevel']);
    GlobalVar.strAccessLevel = idTokenResult.claims['accessLevel'];    
    return "done";
    }catch(e){
      print(e);
     GlobalVar.strAccessLevel = null;
     return "done"; 
    }
  }

  Future<String> firstTimeLogin(User currentUser) async {
    Auth.instance.pref.setBool("isSignedIn", true);
    await Future.delayed(Duration(seconds: 10));
    String value = await _getClaims(currentuser);
    await _getUserCredentails();
    _updateToken();
    return value;
  }

  Future<String> alreadyLogin(currentuser) async{
    String value = await _getClaims(currentuser);
    await _getUserCredentails();
    _updateToken();
    
    return value; 
  }

  signInWithCred(cred) async { 
    currentuser = (await _firebaseAuth.signInWithCredential(cred)).user;
    return "done";
  }

  signInWithOTP(String verid, String smscode) async {
    AuthCredential authCredential =
        PhoneAuthProvider.credential(verificationId: verid, smsCode: smscode);
    signInWithCred(authCredential);
  }

  Future<void> signOut() async {
    try {
      await Auth.instance.pref.clear();
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }  
}
