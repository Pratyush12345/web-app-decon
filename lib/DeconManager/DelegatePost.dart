import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DelegatePost extends StatefulWidget {
  final int cityCode;
  final String cityName;
  DelegatePost({@required this.cityCode, @required this.cityName});
  @override
  _DelegatePostState createState() => _DelegatePostState();
}

class _DelegatePostState extends State<DelegatePost> {
  
  final _postNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  Map<String, dynamic> rangeOfDevicesEx = {
  "S1" : "None",
  "S2" : "D1+D2"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Delegate Post"),),
    body: Container(
       padding: EdgeInsets.all(16.0),
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height,
       child: Column(
         children: [
           TextField(
                controller: _postNameController,
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
                    hintText: "Enter Post Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              SizedBox(height: 20.0),

           TextField(
                controller: _mobileNumberController,
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
                    hintText: "Enter Mobile Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              SizedBox(height: 20.0),
              
           RaisedButton(
            onPressed: ()async {
               FirebaseFirestore.instance
                        .collection('CurrentLogins')
                        .doc(_mobileNumberController.text)
                        .set({
                      "value":
                          "${_postNameController.text}_${widget.cityName}_C${widget.cityCode}_$rangeOfDevicesEx"
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

