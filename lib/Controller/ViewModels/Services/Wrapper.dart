import 'package:Decon/View_Android/Authentication/Phoneverif.dart';
import 'package:Decon/Controller/ViewModels/Services/Wrapper2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
  final user= Provider.of<User>(context);
  if(user==null){

   return PhoneVerif();
  } 
  else{
  
  return Wrapper2();

  }

  }
}