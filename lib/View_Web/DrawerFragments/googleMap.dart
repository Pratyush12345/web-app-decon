// import 'package:Decon/Controller/Providers/home_page_providers.dart';
// import 'package:Decon/Controller/Utils/sizeConfig.dart';
// import 'package:Decon/Models/Models.dart';
// import 'package:flutter/material.dart';
// import 'package:Decon/Controller/ViewModels/Services/Auth.dart';
// import 'package:provider/provider.dart';
// import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:Decon/Models/AddressCaluclator.dart';

// class GoogleMapLoad extends StatefulWidget {
//   List<DeviceData> alldeviceList;
//   GoogleMapLoad({ Key key , alldeviceList}) : super(key: key);

//   @override
//   _GoogleMapLoadState createState() => _GoogleMapLoadState();
// }

// class _GoogleMapLoadState extends State<GoogleMapLoad> {
    
  
//   BuildContext changeContext;
//   BitmapDescriptor ground_icon;
//   BitmapDescriptor normal_icon;
//   BitmapDescriptor informative_icon;
//   BitmapDescriptor critical_icon;
//   Set<Marker> _setOfMarker = {};
//   String futureAddress = "";
//   LatLng _latLng;
//   double _value;
//   static ValueKey key = ValueKey('key_0');
  
//    _showBottomSheet(int level, double latitude, double longitude, String mappedAddress) {
//     Color _color;
//     if (level == 0)
//       _color = Colors.purple;
//     else if (level == 1)
//       _color = Colors.green;
//     else if (level == 2)
//       _color = Colors.yellow;
//     else if(level == 3)
//       _color = Colors.red;
//     else
//       _color = Colors.purpleAccent;  

//     Future<String> address =
//         AddressCalculator(latitude, longitude).getLocation();

//     address.then(
//       (value) {
//         setState(() {
//           futureAddress = value;
//           print(futureAddress);
//         });

//         showModalBottomSheet(
//           context: context,
//           builder: (context) => Container(
//             height: MediaQuery.of(context).size.height * (0.3),
//             child: Column(
//               children: <Widget>[
//                 ListTile(
//                   leading: Icon(
//                     Icons.location_on,
//                     color: _color,
//                   ),
//                   title: Text(
//                     "Address",
//                     style: TextStyle(fontSize: 20.0, color: _color),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text(
//                     mappedAddress??"",
//                     style: TextStyle(fontSize: 20.0),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }


//    loadMarker() async {
//    ground_icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/purple-dot.png');
//    normal_icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/green-dot.png');
//    informative_icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/yellow-dot.png');
//    critical_icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/red-dot.png');    
//    Provider.of<ChangeGoogleMap>(context, listen: false).changeGoogleMap(true);
//    await Future.delayed(Duration(milliseconds: 2000));
//    Provider.of<ChangeGoogleMap>(context, listen: false).changeGoogleMap(false);
//   }
//   @override
//   void initState() {
//     _latLng = new LatLng(26.123456, 72.234567);
//     _value = 8.0;
//     super.initState();
//     loadMarker();
//   }

  
//     Widget googlemap(BuildContext context, List<DeviceData> allDeviceData) {
    
//     return 
//        Container(
//         //height: MediaQuery.of(context).size.height,
//         child: Consumer<ChangeGoogleMap>(
//           builder: (context, model,child){

//             if(model.isInitialized){
//                _setOfMarker = {};
//              }
//              else{
//                if(GlobalVar.isDeviceChanged){
//                _setOfMarker = {};
//                GlobalVar.isDeviceChanged = false;
//                }
//                else
//                _setOfMarker = addMarker(allDeviceData);
//              }
            
//            return  GoogleMap( 
//           key: key,   
//           mapType: MapType.normal,
//           initialCameraPosition: CameraPosition(target: _latLng, zoom: _value),
//           zoomGesturesEnabled: true,
//           onMapCreated: (GoogleMapController googleMapControler) {
//             GlobalVar.gcontroller.complete(googleMapControler);
//             print("controller loaded");
//             print(Auth.instance.ground_icon);
//             print(Auth.instance.normal_icon);
//             print(Auth.instance.informative_icon);
//             print(Auth.instance.critical_icon);
//           },
//           markers: _setOfMarker,
//         );
//           },
//       ),
//     );
//   }

//   Set<Marker> addMarker(List<DeviceData> _allDeviceData) {
//     print("Length is ######: ${_allDeviceData?.length}");
//     if (_allDeviceData!=null  && _allDeviceData.length != 0) {
//       for (var i = 0; i < _allDeviceData.length; i++) {
//         _setOfMarker.add(addIndividualMarker(_allDeviceData[i]));
//       }
//       return _setOfMarker;
//     }
//     return null;
//   }

//   Marker addIndividualMarker(DeviceData _allDeviceData) {
//     int level = _allDeviceData.wlevel;

//     if (level == 0) {
//       return Marker(
//         markerId: MarkerId(_allDeviceData.id.split("_")[2]),
//         onTap: () {
//           _showBottomSheet(
//               level, _allDeviceData.latitude, _allDeviceData.longitude, _allDeviceData.address);
//         },
//         position: LatLng(_allDeviceData.latitude, _allDeviceData.longitude),
//         infoWindow: InfoWindow(
//             title: "${_allDeviceData.id.split("_")[2]}",
//             snippet: "Ground Level"),
//         icon: ground_icon,
//       );
//     } else if (level == 1) {
//       return Marker(
//         markerId: MarkerId(_allDeviceData.id.split("_")[2]),
//         onTap: () {
//           _showBottomSheet(
//               level, _allDeviceData.latitude, _allDeviceData.longitude, _allDeviceData.address);
//         },
//         position: LatLng(_allDeviceData.latitude, _allDeviceData.longitude),
//         infoWindow: InfoWindow(
//             title: "${_allDeviceData.id.split("_")[2]}",
//             snippet: "Normal Level"),
//         icon: normal_icon,
//       );
//     } else if (level == 2) {
//       return Marker(
//         markerId: MarkerId(_allDeviceData.id.split("_")[2]),
//         onTap: () {
//           _showBottomSheet(
//               level, _allDeviceData.latitude, _allDeviceData.longitude, _allDeviceData.address);
//         },
//         position: LatLng(_allDeviceData.latitude, _allDeviceData.longitude),
//         infoWindow: InfoWindow(
//             title: "${_allDeviceData.id.split("_")[2]}",
//             snippet: "Informative Level"),
//         icon: informative_icon,
//       );
//     } else if(level == 3) {
//       return Marker(
//         markerId: MarkerId(_allDeviceData.id.split("_")[2]),
//         onTap: () {
//           _showBottomSheet(
//               level, _allDeviceData.latitude, _allDeviceData.longitude, _allDeviceData.address);
//         },
//         position: LatLng(_allDeviceData.latitude, _allDeviceData.longitude),
//         infoWindow: InfoWindow(
//             title: "${_allDeviceData.id.split("_")[2]}",
//             snippet: "Critical Level"),
//         icon: critical_icon,
//       );
//     }
//     else  {
//       return Marker(
//         markerId: MarkerId(_allDeviceData.id.split("_")[2]),
//         onTap: () {
//           _showBottomSheet(
//               level, _allDeviceData.latitude, _allDeviceData.longitude, _allDeviceData.address);
//         },
//         position: LatLng(_allDeviceData.latitude, _allDeviceData.longitude),
//         infoWindow: InfoWindow(
//             title: "${_allDeviceData.id.split("_")[2]}",
//             snippet: "Error in Device"),
//         icon: critical_icon,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//    SizeConfig().init(context);
    
//     return Stack(
//       children: [
//         googlemap(context, widget.alldeviceList)
//       ],
//     );
//   }
// }