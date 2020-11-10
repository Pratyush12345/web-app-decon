import 'package:Decon/MainPage/HomePage.dart';
import 'package:Decon/Services/Auth.dart';
import 'package:Decon/Services/Wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences pref;
void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  pref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  SharedPreferences prefs;
  
  @override
  Widget build(BuildContext context) {
        return StreamProvider<User>.value(
          value: Auth.instance.appuser,
          child: MaterialApp(
        routes: {
          '/Home': (context)=> HomePage()
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: MaterialColor(
                0xff263238,
                <int, Color>{
                  50: Color(0xff263238),
                  100: Color(0xff263238),
                  200: Color(0xff263238),
                  300: Color(0xff263238),
                  400: Color(0xff263238),
                  500: Color(0xff263238),
                  600: Color(0xff263238),
                  700: Color(0xff263238),
                  800: Color(0xff263238),
                  900: Color(0xff263238),
                },
              ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}

