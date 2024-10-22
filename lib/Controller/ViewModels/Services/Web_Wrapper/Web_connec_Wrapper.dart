import 'package:Decon/Controller/ViewModels/Services/Web_Wrapper/WebNointernetScreen.dart';
import 'package:Decon/Controller/ViewModels/Services/Web_Wrapper/web_user_Wrapper.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:html' as html;


class WebConnectivityWrapper extends StatelessWidget{
   
  @override
  Widget build(BuildContext context) {
 
        return StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context,snapshot){
            if(snapshot.hasData){
 
            double downlink = 0;
            int rtt = 1;
            bool isonline = true;

            if(html.window.navigator.connection!=null){  
              downlink = html.window.navigator.connection?.downlink;
              rtt = html.window.navigator.connection?.rtt;
              isonline = html.window.navigator?.onLine; 
              }

            print("downlink------------$downlink");
            print("rtt------------$rtt");
            print("isonline------------$isonline");
            
             
                if(downlink<5||rtt>10||isonline){
                  return WebUserWrapper();
                }else{
                  if(Navigator.canPop(context)){
                    Navigator.of(context).pop();
                   }
                  return WebNoInternetScreen();
                }
            }
            else{
            double downlink = 0;
            int rtt = 1;
            bool isonline = true;

            if(html.window.navigator.connection!=null){  
              downlink = html.window.navigator.connection?.downlink;
              rtt = html.window.navigator.connection?.rtt;
              isonline = html.window.navigator?.onLine; 
              }

                print("downlink------------$downlink");
                print("downlink------------$downlink");
                print("rtt------------$rtt");
                print("isonline------------$isonline");
            
                if(downlink<5||rtt>10||isonline){
                  return WebUserWrapper();
                }else{
                  if(Navigator.canPop(context)){
                    Navigator.of(context).pop();
                   }
                  return WebNoInternetScreen();
                }
              }  
            
        });
  }
}

