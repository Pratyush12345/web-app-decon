import 'package:Decon/Controller/ViewModels/Services/Android_wrapper/andr_connec_Wrapper.dart';
import 'package:Decon/Controller/ViewModels/Services/Android_wrapper/andr_user_Wrapper.dart';
import 'package:Decon/Controller/ViewModels/Services/Web_Wrapper/Web_connec_Wrapper.dart';
import 'package:Decon/Controller/ViewModels/Services/Web_Wrapper/web_user_Wrapper.dart';
import 'package:flutter/material.dart';


class OrientationWrapper extends StatelessWidget {
  const OrientationWrapper({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation){
        if(orientation == Orientation.landscape){
          if(Navigator.of(context).canPop()){
            Navigator.of(context).pop();
          }
          
          return  WebConnectivityWrapper();
          
        }
        else{
          if(Navigator.of(context).canPop()){
            Navigator.of(context).pop();
          }
          
          return  AndrConnectivityWrapper();
        }
      });
     
}
}