import 'package:Decon/Controller/ViewModels/Services/Android_wrapper/andr_user_Wrapper.dart';
import 'package:Decon/Controller/ViewModels/Services/Web_Wrapper/web_user_Wrapper.dart';
import 'package:Decon/Controller/ViewModels/Services/Android_wrapper/AndrNointernetScreen.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:html' as html;


class AndrConnectivityWrapper extends StatelessWidget{
   
  @override
  Widget build(BuildContext context) {
 
        return StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context,snapshot){
            if(snapshot.hasData){
              
            double downlink = html.window.navigator.connection.downlink;
            int rtt = html.window.navigator.connection.rtt;
            bool isonline = html.window.navigator.onLine; 
            
            print("downlink------------$downlink");
            print("rtt------------$rtt");
            print("isonline------------$isonline");
            
             
                if(downlink<5||rtt>10||isonline){
                  return AndrUserWrapper();
                }else{
                  if(Navigator.canPop(context)){
                    Navigator.of(context).pop();
                   }
                  return AndrNoInternetScreen();
                }
            }
            else{
            double downlink = html.window.navigator.connection.downlink;
            int rtt = html.window.navigator.connection.rtt;
            bool isonline = html.window.navigator.onLine; 
            
                print("downlink------------$downlink");
                print("downlink------------$downlink");
                print("rtt------------$rtt");
                print("isonline------------$isonline");
            
                if(downlink<5||rtt>10||isonline){
                  return AndrUserWrapper();
                }else{
                  if(Navigator.canPop(context)){
                    Navigator.of(context).pop();
                   }
                  return AndrNoInternetScreen();
                }
              }  
            
        });
  }
}

