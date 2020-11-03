import 'package:Decon/Models/Models.dart';
import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  final  DeviceData deviceData;
  Graph({@required this.deviceData});
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Graphs"),
      ),
    );
  }
}