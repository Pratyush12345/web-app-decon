import 'package:Decon/View_Android/Authentication/Phoneverif.dart';
import 'package:Decon/Controller/ViewModels/Services/Wrapper2.dart';
import 'package:Decon/View_Android/Authentication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
  final user= Provider.of<User>(context);
  if(user==null){

   return Login();
  } 
  else{
  if(Navigator.of(context).canPop()){
    Navigator.of(context).pop();
  }
  return Wrapper2();

  }

  }
}