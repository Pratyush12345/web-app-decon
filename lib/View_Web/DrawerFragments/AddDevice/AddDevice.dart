import 'package:Decon/Controller/Providers/home_page_providers.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Controller/ViewModels/home_page_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/View_Web/Dialogs/alert_message_dialog.dart';
import 'package:Decon/View_Web/DrawerFragments/AddDevice/ClickOnAddDevice.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Models.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';

class AddDevice extends StatefulWidget {
  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  
  List<DeviceData> _listOfDevices = [];
  
  Future showAddDeviceDialog(
      {BuildContext context, bool isUpdating, deviceId}) {
    return showAnimatedDialog(
        barrierDismissible: true,
        animationType: DialogTransitionType.scaleRotate,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),
        
        context: context,
        builder: (context) {
          return ClickOnAddDevice(
            list: _listOfDevices,
            isUpdating: isUpdating,
            deviceid: deviceId,
          );
        });
  }
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 1440;
    var h = SizeConfig.screenHeight / 900;
    
    return Scaffold(
      backgroundColor: wc,
      floatingActionButton: Container(
        height: h*100,
        width: h*100,
        child: FittedBox(
          child: FloatingActionButton(
    
            backgroundColor: Color(0xff0099FF),
            onPressed: () {
              if(GlobalVar.strAccessLevel != null)
              showAddDeviceDialog(context: context, isUpdating: false);
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
      body: Consumer<ChangeDeviceData>(
        builder: (context, _model, child) => SingleChildScrollView(
           padding: EdgeInsets.symmetric(horizontal: b * 42, vertical: h*22),
       
          child: StreamBuilder<QueryEvent>(
            stream: database().ref("clients/${HomePageVM.instance.getClientCode}/series/${HomePageVM.instance.getSeriesCode}/devices")
                .onValue,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                Map datamap = snapshot.data.snapshot.val();
                   _listOfDevices = [];
                   datamap?.forEach((key, value) {
                      DeviceData deviceData = DeviceData.fromJson(value, HomePageVM.instance.getSeriesCode ); 
                     _listOfDevices.add(deviceData);                              
                });
                _listOfDevices?.sort((a, b) =>
                    int.parse(a.id.split("_")[2].substring(1, a.id.split("_")[2].length)).compareTo(
                        int.parse(b.id.split("_")[2].substring(1, b.id.split("_")[2].length))));
                if (snapshot.data.snapshot.val()!= null)
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: _listOfDevices.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                if (_listOfDevices[index].address == "Empty")
                                  showAddDeviceDialog(
                                      context: context,
                                      isUpdating: true,
                                      deviceId: _listOfDevices[index].id);
                              },
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.screenHeight * 5 / 900,
                                  horizontal: SizeConfig.screenWidth * 10 / 1440),
                              title: Text(
                                "${_listOfDevices[index].id.split("_")[2].replaceAll("D", "Device ")}",
                                style: TextStyle(
                                    fontSize: SizeConfig.b * 2.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: _listOfDevices[index].address != "Empty"
                                  ? Text(_listOfDevices[index].address,
                                      style: TextStyle(
                                          fontSize: SizeConfig.b * 1.0,
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
                                                fontSize: SizeConfig.b * 1.0,
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
                                  _listOfDevices[index].id,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: SizeConfig.b * 1.0),
                                ),
                              ),
                            ),
                            Divider(color: Color(0xffCACACA), thickness: 1),
                          ],
                        );
                      });
                else
                  return AppConstant.noDataFound();
              } else {
                if (snapshot.hasError)
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                else
                  return AppConstant.progressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
