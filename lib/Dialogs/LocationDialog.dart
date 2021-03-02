import 'package:Decon/Authentication/EnterOtp.dart';
import 'package:Decon/Models/AddressCaluclator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationDialog extends StatefulWidget {
  final String cityid;
  final String initalAddress;
  final double initialLatitude, initialLongitude;
  LocationDialog(
      {@required this.cityid,
      @required this.initalAddress,
      @required this.initialLatitude,
      @required this.initialLongitude});
  @override
  _LocationDialog createState() => _LocationDialog();
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double b;
  static double v;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    b = screenWidth / 100;
    v = screenHeight / 100;
  }
}

class _LocationDialog extends State<LocationDialog> {
  Position position;
  bool _isChanged = false;
  TextEditingController _addressController,
      _latitudeController,
      _longitudeController;
  getCurrentLocation(double latitude, double longitude) async {
    String address = await AddressCalculator(latitude, longitude).getLocation();
    setState(() {
      _longitudeController.text = longitude.toString();
      _latitudeController.text = latitude.toString();
      _addressController.text = address;
    });
  }

  @override
  void initState() {
    _addressController = TextEditingController(
      text: widget.initalAddress,
    );
    _latitudeController = TextEditingController(
      text: widget.initialLatitude.toString(),
    );
    _longitudeController = TextEditingController(
      text: widget.initialLongitude.toString(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Card(
        margin: EdgeInsets.fromLTRB(
            SizeConfig.screenWidth * 0.05,
            SizeConfig.screenHeight * 0.2,
            SizeConfig.screenWidth * 0.05,
            SizeConfig.screenHeight * 0.21),
        elevation: 5,
        color: Color(0xff263238),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.b * 2.25),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(SizeConfig.b * 2.5, SizeConfig.v * 3.0,
              SizeConfig.b * 2.5, SizeConfig.v * 3),
          child: Column(children: [
            SizedBox(height: SizeConfig.v * 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: SizeConfig.screenWidth * 60 / 360,
                  child: Text("Latitude",
                      style: TextStyle(
                          fontSize: SizeConfig.b * 3.56, color: Colors.white)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(SizeConfig.b * 1, 0, 0, 0),
                  width: SizeConfig.b * 25,
                  decoration: BoxDecoration(
                      color: Color(0xffDEE0E0),
                      borderRadius: BorderRadius.circular(SizeConfig.b * 1)),
                  child: TextField(
                    onChanged: (value) {
                      _isChanged = true;
                    },
                    controller: _latitudeController,
                    style: TextStyle(fontSize: SizeConfig.b * 3.2),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Enter Latitude',
                      hintStyle: TextStyle(fontSize: SizeConfig.b * 3.2),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.v * 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: SizeConfig.screenWidth * 60 / 360,
                  child: Text("Longitude",
                      style: TextStyle(
                          fontSize: SizeConfig.b * 3.56, color: Colors.white)),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(SizeConfig.b * 1, 0, 0, 0),
                  width: SizeConfig.b * 25,
                  decoration: BoxDecoration(
                      color: Color(0xffDEE0E0),
                      borderRadius: BorderRadius.circular(SizeConfig.b * 1)),
                  child: TextField(
                    onChanged: (value) {
                      _isChanged = true;
                    },
                    controller: _longitudeController,
                    style: TextStyle(fontSize: SizeConfig.b * 3.2),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Enter Longitude',
                      hintStyle: TextStyle(fontSize: SizeConfig.b * 3.2),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.v * 2.5),
            Container(
                width: 200,
                child: Text(
                    "Are You sure?\nLocation of ${widget.cityid.split("_")[2].replaceAll("D", "Device ")} is :",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontSize: SizeConfig.b * 4.09))),
            SizedBox(height: SizeConfig.v * 2.5),
            Container(
              width: 340,
              child: TextField(
                controller: _addressController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  fillColor: Color(0xffDEE0E0),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffDEE0E0),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffDEE0E0),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: SizeConfig.b * 4.09),
              ),
            ),
            SizedBox(height: SizeConfig.v * 4),
            SizedBox(
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  if (!_isChanged) {
                    position = await Geolocator.getCurrentPosition();
                    await getCurrentLocation(
                        position.latitude, position.longitude);
                  } else {
                    await getCurrentLocation(
                        double.parse(_latitudeController.text.toString()),
                        double.parse(_longitudeController.text.toString()));
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.b * 11,
                      vertical: SizeConfig.v * 1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConfig.b * 6.7),
                    color: Color(0xff00A3FF),
                  ),
                  child: Text(
                    !_isChanged ? 'Get Current Location' : 'Fetch Location',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.b * 3.56,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.v * 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    child: MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          double _lat =
                              double.parse((_latitudeController.text));
                          double _lon = double.parse(_longitudeController.text);
                          print("${_addressController.text}");
                          await FirebaseDatabase.instance
                              .reference()
                              .child(
                                  "cities/${widget.cityid.split("_")[0]}/Series/${widget.cityid.split("_")[1]}/Devices/${widget.cityid.split("_")[2]}")
                              .update({
                            "latitude": _lat,
                            "longitude": _lon,
                            "address": _addressController.text
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.b * 6.5,
                                vertical: SizeConfig.v * 1.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(SizeConfig.b * 6.7),
                              color: Color(0xff00A3FF),
                            ),
                            child: Text('Yes, Update',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.b * 3.56,
                                    fontWeight: FontWeight.w400))))),
                SizedBox(width: SizeConfig.v * 1.2),
                SizedBox(
                    child: MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.b * 7,
                                vertical: SizeConfig.v * 1.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(SizeConfig.b * 6.7),
                              color: Color(0xff00A3FF),
                            ),
                            child: Text('NO',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.b * 3.56,
                                    fontWeight: FontWeight.w400))))),
              ],
            ),
          ]),
        ));
  }
}
