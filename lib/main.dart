import 'package:Decon/Controller/Providers/devie_setting_provider.dart';
import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/Services/Wrapper.dart';
import 'package:Decon/Controller/Services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(
      value: Auth.instance.appuser,
      
      child: MultiProvider(
        providers: [
           ChangeNotifierProvider(create: (context)=> ChangeWhenGetCity(),),
           ChangeNotifierProvider(create: (context)=> ChangeCity(),),
           ChangeNotifierProvider(create: (context)=> ChangeDeviceSeting(),),
          ],
        child: MaterialApp(
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
      ),
    );
  }
}
