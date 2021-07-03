
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}
const gc= Colors.black;

const tc = Color(0xff263238);
class _TestPageState extends State<TestPage> {

   



  @override
    void initState() {
      print("cccccccccccccccccccccccc");
    print(context);
    print("cccccccccccccccccccccccc");
    // HomePageVM.instance.initialize(context);
   
      super.initState();
    }
  

  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("test"),),
      body: Center(
        child: Text("test"),
      ),
    );
  }
}