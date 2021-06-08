import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

abstract class BaseCall{
  DatabaseReference _dbRef = FirebaseDatabase.instance.reference();
  
  @protected
  Future<dynamic> databaseOnceCall(String databaseUrl) async{
   try{
   DataSnapshot snapshot = await _dbRef.child(databaseUrl).once();
   return snapshot;
   }
   catch(e){
     return e;
   }
  }

  @protected
  Future<dynamic> databaseUpdateCall(String databaseUrl, Map<String, dynamic> value) async{
   try{
   await _dbRef.child(databaseUrl).update(value);
   return "Successfully Created";
   }
   catch(e){
     print(e.toString());
     return e.toString();
   }
  }
}