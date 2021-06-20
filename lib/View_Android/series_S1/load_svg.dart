import 'package:flutter/material.dart';
class LoadSVG extends StatelessWidget {
  const LoadSVG({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Load SVG"),
      ),
      body: Center(
        child: Container(
          height: 200.0,
          width: 200.0,
                    child: Image.asset("assets/Infinity.svg",
                    
                  ),
          
        ),
      ),
    );  }
}