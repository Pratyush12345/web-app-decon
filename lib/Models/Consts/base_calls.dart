import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';

abstract class BaseCall{
  Database _dbRef = database();
  CollectionReference _fsRef =  FirebaseFirestore.instance.collection('CurrentLogins');

  @protected
  Future<dynamic> databaseOnceCall(String databaseUrl) async{
   try{
   DataSnapshot snapshot = (await _dbRef.ref(databaseUrl).once('value')).snapshot;
   return snapshot;
   }
   catch(e){
     return e;
   }
  }

  @protected
  Future<dynamic> databaseOrderByChildCall(String databaseUrl, String orderBy, String equalTo) async{
   try{
   DataSnapshot snapshot = (await _dbRef.ref(databaseUrl).orderByChild(orderBy).equalTo(equalTo).once('value')).snapshot;
   return snapshot;
   }
   catch(e){
     return e;
   }
  }

  @protected
  Future<dynamic> databaseUpdateCall(String databaseUrl, Map<String, dynamic> value) async{
   try{
   await _dbRef.ref(databaseUrl).update(value);
   return "Done Successfully";
   }
   catch(e){
     print(e.toString());
     return e.toString();
   }
  }

  @protected
  Future<dynamic> databasePushUpdateCall(DatabaseReference ref , Map<String, dynamic> value) async{
   try{
   await ref.update(value);
   return "Done Successfully";
   }
   catch(e){
     print(e.toString());
     return e.toString();
   }
  }

  @protected
  Future<dynamic> databaseRemoveCall(String databaseUrl) async{
   try{
   await _dbRef.ref(databaseUrl).remove();
   return "Successfully Created";
   }
   catch(e){
     print(e.toString());
     return e.toString();
   }
  }

  @protected
  Future<dynamic> firestoreSetCall(String firestoreUrl, Map<String, dynamic> value ) async{
   try{
   await _fsRef.doc(firestoreUrl).set(value);
   return "Successfully Created";
   }
   catch(e){
     print(e.toString());
     return e.toString();
   }
  }
}