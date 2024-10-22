import 'dart:async';
import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as webgm;

class GoogleMapRender extends StatefulWidget {

  Completer<GoogleMapController> controller;
  LatLng latLng;
  Set<Marker> setOfMarker = {};
  double value;
  GoogleMapRender({Key key, this.controller, this.latLng, this.value, this.setOfMarker}) : super(key: key);

  @override
  State<GoogleMapRender> createState() => _GoogleMapRenderState();
}

class _GoogleMapRenderState extends State<GoogleMapRender> {
  

  @override
  void initState() {
    
    super.initState();
  }
  
  disposeGoogleMapController() async{
  GoogleMapController googleMapController = await widget.controller.future;
  googleMapController.dispose();
  print("-------------------Google Map Controller is disposed");
  }

  @override
  void dispose() {
    disposeGoogleMapController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap( 
         mapType: MapType.normal,
         key: Key("google map key"),
         initialCameraPosition: CameraPosition(target: widget.latLng, zoom: widget.value),
         zoomGesturesEnabled: true,
         onMapCreated: (GoogleMapController googleMapControler) {
           widget.controller.complete(googleMapControler);
        
           //_animateMap(allDeviceData[0].latitude, allDeviceData[0].longitude);
           print("controller loaded");
           print(Auth.instance.ground_icon);
           print(Auth.instance.normal_icon);
           print(Auth.instance.informative_icon);
           print(Auth.instance.critical_icon);
         },
         markers: widget.setOfMarker,

        );;
  }
}