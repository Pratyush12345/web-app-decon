import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class AddCity extends StatefulWidget {
  final cityLength;
  AddCity({@required this.cityLength});
  @override
  _AddCityState createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {

  final _cityNameController = TextEditingController();
  final dbRef = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text("Add City")),
     body: Container(
       padding: EdgeInsets.all(16.0),
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height,
       child: Column(
         children: [
           TextField(
                controller: _cityNameController,
                style: TextStyle(
                  fontSize: 14.0,
                   color: Color(0xFF868A8F)
                ),
                onChanged: null,
                decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    hintText: "Enter City Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              SizedBox(height: 20.0),
              
           RaisedButton(
            onPressed: (){
              dbRef.reference().child("citiesList").update({
               "C${widget.cityLength+1}" : _cityNameController.text
              });
              Navigator.of(context).pop();
            },
           )
         ],
       ),
     ),
    );
  }
}