import 'dart:async';

import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as webgm;
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Models.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}
const gc= Colors.black;

const tc = Color(0xff263238);
class _TestPageState extends State<TestPage> {
   Completer< GoogleMapController> _controller = Completer();
   List<DeviceData> allDeviceData = [];
  LatLng _latLng;
  double _value;
  BitmapDescriptor ground_icon;
  BitmapDescriptor normal_icon;
  BitmapDescriptor informative_icon;
  BitmapDescriptor critical_icon;
  BitmapDescriptor myIcon;
  Set<Marker> _setOfMarker = {};
    

  loadMarker() async {
   print("loading markerrrrrrrrrrrrrr");
   ground_icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/purple-dot.png');
   normal_icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/green-dot.png');
   informative_icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/yellow-dot.png');
   critical_icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/red-dot.png');    
   print("ground iconnnnnnnnn");
   print(ground_icon);
   print(normal_icon);
   print(informative_icon);
   print(critical_icon);
   Provider.of<ChangeGoogleMap>(context, listen: false).changeGoogleMap(true);
   await Future.delayed(Duration(milliseconds: 250));
   Provider.of<ChangeGoogleMap>(context, listen: false).changeGoogleMap(false);
  }


  @override
  void initState() {
    _latLng = new LatLng(26.123456, 72.234567);
    _value = 8.0;
    allDeviceData = [
      DeviceData(
        latitude: 25.234567,
        longitude: 80.3456789,
        wlevel: 0,
        id: "D1"
      ),
      DeviceData(
        latitude: 25.234567,
        longitude: 79.3456789,
        wlevel: 1,
        id: "D2"

      ),
      DeviceData(
        latitude: 22.234567,
        longitude: 80.3456789,
        wlevel: 2,
        id: "D3"

      ),
      DeviceData(
        latitude: 23.234567,
        longitude: 80.3456789,
        wlevel: 3,
        id: "D4"

      ),
      DeviceData(
        latitude: 26.234567,
        longitude: 80.3456789,
        wlevel: 3,
        id: "D5"

      ),
    ];
    super.initState();
    
     loadMarker();
  }
  Set<Marker> addMarker(List<DeviceData> _allDeviceData) {
    print("Length is ######: ${_allDeviceData?.length}");
    if (_allDeviceData!=null  && _allDeviceData.length != 0) {
      for (var i = 0; i < _allDeviceData.length; i++) {
        _setOfMarker.add(addIndividualMarker(_allDeviceData[i]));
      }
      return _setOfMarker;
    }
    return null;
  }
Marker addIndividualMarker(DeviceData _allDeviceData) {
    int level = _allDeviceData.wlevel;

    if (level == 0) {
      print("Level ${level}");
      return Marker(
        markerId: MarkerId(_allDeviceData.id),
        onTap: () {
          
        },
        position: LatLng(_allDeviceData.latitude, _allDeviceData.longitude),
        infoWindow: InfoWindow(
            title: "${_allDeviceData.id}",
            snippet: "Ground Level"),
        icon: ground_icon,
      );
    } else if (level == 1) {
      print("Level ${level}");
      
      return Marker(
        markerId: MarkerId(_allDeviceData.id),
        onTap: () {
                },
        position: LatLng(_allDeviceData.latitude, _allDeviceData.longitude),
        infoWindow: InfoWindow(
            title: "${_allDeviceData.id}",
            snippet: "Normal Level"),
        icon: normal_icon,
      );
    } else if (level == 2) {
      print("Level ${level}");
      
      return Marker(
        markerId: MarkerId(_allDeviceData.id),
        onTap: () {
          },
        position: LatLng(_allDeviceData.latitude, _allDeviceData.longitude),
        infoWindow: InfoWindow(
            title: "${_allDeviceData.id}",
            snippet: "Informative Level"),
        icon: informative_icon,
      );
    } else {
      print("Level ${level}");
      
      return Marker(
        markerId: MarkerId(_allDeviceData.id),
        onTap: () {
          },
        position: LatLng(_allDeviceData.latitude, _allDeviceData.longitude),
        infoWindow: InfoWindow(
            title: "${_allDeviceData.id}",
            snippet: "Critical Level"),
        icon: critical_icon,
      );
    }
  }

  

   @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;

    return Scaffold(
      appBar: AppBar(title: Text("Google map",
      ),
      actions: [
        InkWell(
            onTap: () {},
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Container(
              child : Image.asset('assets/yellow-dot.png'),
              margin: EdgeInsets.only(right: b * 20),
              height: h * 32,
              width: b * 32,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
      ),
      body: Container(
         child: Consumer<ChangeGoogleMap>(
           builder: (context, model , child){
             if(model.isInitialized){
               _setOfMarker = {};
             }
             else{
             _setOfMarker = addMarker(allDeviceData);
             }
            
           return  GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: _latLng, zoom: _value),
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController googleMapControler) {
            _controller.complete(googleMapControler);
            print("map Completed");
            print("iconssss");
            print(Auth.instance.ground_icon);
            print(Auth.instance.normal_icon);
            print(Auth.instance.informative_icon);
            
                      
            
            
        },
        markers: _setOfMarker

      );
           }
         ),
    
      )  
      
      
       );


  }
}