import 'package:Decon/View_Web/Dialogs/alert_message_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class FirebaseMessagingServeiceWeb {
  static FirebaseMessagingServeiceWeb instance = FirebaseMessagingServeiceWeb._();
  FirebaseMessagingServeiceWeb._();
  
  initializeWebService(BuildContext context){
      firebaseOnMessage(context);
      onFirebaseOpenApp();
      //onTokenRefresh();
         
  } 
 
  Future showAlertMessageDialog(BuildContext context, String title, String body) {
    return showAnimatedDialog(
        barrierDismissible: true,
        context: context,  
        animationType: DialogTransitionType.scaleRotate,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),
        builder: (context) {
          return AlertMessageDialog(deviceId: title, message: body);
        });
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
      showAlertMessageDialog(context, title, body);
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