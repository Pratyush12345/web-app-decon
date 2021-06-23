import 'package:Decon/Controller/ViewModels/Services/Wrapper.dart';
import 'package:Decon/Models/Consts/NointernetScreen.dart';
import 'package:Decon/View_Android/Authentication/Wait.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class Wrapper4 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

      return StreamBuilder(
        stream: InternetConnectionChecker().onStatusChange ,
        builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.active){
               print("ccccccccccccccccccc");
               print(snapshot.data.toString());
               print("ccccccccccccccccccc");
              if(snapshot.data.toString()  != InternetConnectionStatus.disconnected.toString())
              {
                return Wrapper();
              }
              
              else{
              if(Navigator.canPop(context)){
          
                Navigator.of(context).pop();
              }  
              return  NoInternetScreen();       
              }
              }
        
        return Wait();
     
        }, 
      ); 
}
}