import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/View_Android/DrawerFragments/AddDevice/ClickOnAddDevice.dart';

import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Models.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddDevice extends StatefulWidget {
  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  Future showAddDeviceDialog(
      {BuildContext context, bool isUpdating, deviceId}) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return ClickOnAddDevice(
            isUpdating: isUpdating,
            deviceid: deviceId,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff0099FF),
        onPressed: () {
          showAddDeviceDialog(context: context, isUpdating: false);
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<ChangeCity>(
          
          builder: (context, _model, child )=>
          StreamBuilder<Event>(
          stream: FirebaseDatabase.instance
              .reference()
              .child(
                  "cities/${HomePageVM.instance.getCityCode == "Vysion" ? "C0" : HomePageVM.instance.getCityCode ?? "C0"}/Series/S1/Devices")
              .onValue,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              List<DeviceData> _listofDevices = List();
              int _wlevel;
              double _distance;
              snapshot.data.snapshot?.value?.forEach((key, value) {
                _listofDevices.add(DeviceData(
                    id: value["id"],
                    battery: value["battery"],
                    latitude: value["latitude"] ?? 0.0,
                    longitude: value["longitude"] ?? 0.0,
                    status: value["simStatus"] ?? 1,
                    distance: value["distance"],
                    wlevel: 0,
                    openManhole: value["openManhole"],
                    address: value["address"] ?? "Empty",
                    temperature: value["temperature"]));
              });
              _listofDevices.sort((a, b) =>
                  int.parse(a.id.split("_")[2].substring(1, 2))
                      .compareTo(int.parse(b.id.split("_")[2].substring(1, 2))));

              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _listofDevices.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            if (_listofDevices[index].address == "Empty")
                              showAddDeviceDialog(
                                  context: context,
                                  isUpdating: true,
                                  deviceId: _listofDevices[index].id);
                          },
                          contentPadding: EdgeInsets.symmetric(
                              vertical: SizeConfig.screenHeight * 5 / 640,
                              horizontal: SizeConfig.screenWidth * 10 / 360),
                          title: Text(
                            "${_listofDevices[index].id.split("_")[2].replaceAll("D", "Device ")}",
                            style: TextStyle(
                                fontSize: SizeConfig.b * 5.09,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: _listofDevices[index].address != "Empty"
                              ? Text(_listofDevices[index].address,
                                  style: TextStyle(
                                      fontSize: SizeConfig.b * 3.054,
                                      color: Color(0xff0099FF)))
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.location_off_rounded,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text("Add Location of this device",
                                        style: TextStyle(
                                            fontSize: SizeConfig.b * 3.054,
                                            color: Colors.red))
                                  ],
                                ),
                          trailing: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.b * 1,
                                vertical: SizeConfig.v * 0.6),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(SizeConfig.b * 2),
                                color: Color(0xff0099FF)),
                            child: Text(
                              _listofDevices[index].id,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.b * 3.57),
                            ),
                          ),
                        ),
                        Divider(color: Color(0xffCACACA), thickness: 1),
                      ],
                    );
                  });
            } else {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          },
        ),
      ),
    );
  }
}
