import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
import 'package:Decon/View_Web/Authentication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginVM {
  static LoginVM instance = LoginVM._();
  LoginVM._();
  String verificationID;
  bool codeSent = false;
 
  verifyPhone(context, String phoneNoWithCountryCode) async {
    
    print("verify phone number");
    ConfirmationResult confirmationResult = await FirebaseAuth.instance.signInWithPhoneNumber(
        phoneNoWithCountryCode.trim());
    verificationID = confirmationResult.verificationId;
    
  }
  
  manualLogin(String smsCode) async{
    print("ver id=================");
    print(verificationID);
    print("ver id=================");
    await Auth.instance.signInWithOTP(
                                verificationID,
                                smsCode,
                              );
  }
}