import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingServeiceWeb {
  static FirebaseMessagingServeiceWeb instance = FirebaseMessagingServeiceWeb._();
  FirebaseMessagingServeiceWeb._();
  
  initializeWebService(BuildContext context){
      firebaseOnMessage(context);
      onFirebaseOpenApp();
      //onTokenRefresh();
         
  } 
  void firebaseOnMessage(BuildContext context){
    print("on Message");
    FirebaseMessaging.onMessage.listen((message) { 
      print("message 111111111111111111111");
      if(message!=null){
        print("mesaage received");
        print("message==========${message}");
      final title  = message.notification.title;
      final body = message.notification.body;
      showDialog(
        context: context,
        builder: (context){
            return SimpleDialog(
              contentPadding: EdgeInsets.all(8.0),
              children: [
                Text('Title $title'),
                Text('Body  $body'),
              ],
            );
        }
      );
      }
    });
  }  

  void onFirebaseOpenApp(){
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
       print("onmessage open");
       print(message.notification.title);
     });
  }

  // void onTokenRefresh(){
  //   FirebaseMessaging.instance.onTokenRefresh.listen((event) async { 
  //     String tokenid = await  FirebaseMessaging.instance.getToken();
  //     print("token id");
  //     print(tokenid);
  //     try{
  //      await _apiService.deviceTokenStoreUpdate(
  //       DeviceStoreTokenUpdateModel(
  //         deviceId: GlobalVariable.userDetails.deviceId,
  //         deviceToken: tokenid,
  //         userId: GlobalVariable.userDetails.id
  //       ));
  //     }catch(e){
  //       print(e);
  //       print("errorrr");
  //     }

  //   });
  // }


}