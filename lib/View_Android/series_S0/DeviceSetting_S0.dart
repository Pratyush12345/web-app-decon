import 'package:Decon/Controller/Providers/devie_setting_provider.dart';
import 'package:Decon/View_Android/series_S0/device_setting_viewmodel_S0.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/View_Android/DrawerFragments/Updatelocation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class DeviceSettingsS0 extends StatefulWidget {

  @override
  _DeviceSettings createState() => _DeviceSettings();
}

class _DeviceSettings extends State<DeviceSettingsS0> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child : Consumer<ChangeDeviceSeting>(
          builder: (context, _model, child){
          return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.b * 5.09, vertical: SizeConfig.v * 2.85),
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.b * 5.09, vertical: SizeConfig.v * 2.85),
              decoration: BoxDecoration(
                color: Color(0xff263238),
                borderRadius: BorderRadius.circular(SizeConfig.b * 2.6),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: SizeConfig.v * 3),
                    Row(children: [
                      Expanded(
                        flex: 3,
                        child: Text("Manhole's Depth",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.b * 4.1)),
                      ),
                      SizedBox(width: SizeConfig.b * 5),
                      Expanded(
                        flex: 2,
                        child: Row(children: [
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(SizeConfig.b * 1, 0, 0, 0),
                            width: SizeConfig.b * 10,
                            decoration: BoxDecoration(
                                color: Color(0xffDEE0E0),
                                borderRadius:
                                    BorderRadius.circular(SizeConfig.b * 1.1)),
                            child: TextField(
                              controller: DeviceSettingS0VM.instance.maholesdepth,
                              style: TextStyle(fontSize: SizeConfig.b * 3.2),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Enter Maholes depth',
                                hintStyle:
                                    TextStyle(fontSize: SizeConfig.b * 3.2),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(width: SizeConfig.b * 5),
                          Text("meters",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.b * 4.1)),
                        ]),
                      ),
                    ]),
                    SizedBox(height: SizeConfig.v * 3),
                    Divider(
                      color: Color(0xff9BA1A3),
                      thickness: 2,
                    ),
                    SizedBox(height: SizeConfig.v * 1.5),
                    Row(children: [
                      Expanded(
                        flex: 3,
                        child: Text("Battery Threshold Value",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.b * 4.1)),
                      ),
                      SizedBox(width: SizeConfig.b * 5),
                      Expanded(
                        flex: 2,
                        child: Row(children: [
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(SizeConfig.b * 1, 0, 0, 0),
                            width: SizeConfig.b * 10,
                            decoration: BoxDecoration(
                                color: Color(0xffDEE0E0),
                                borderRadius:
                                    BorderRadius.circular(SizeConfig.b * 1.1)),
                            child: TextField(
                              controller: DeviceSettingS0VM.instance.batterythresholdvalue,
                              style: TextStyle(fontSize: SizeConfig.b * 3.2),
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Enter Battery Threshold value',
                                hintStyle:
                                    TextStyle(fontSize: SizeConfig.b * 3.2),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(width: SizeConfig.b * 5),
                          Text(" %",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.b * 4.1)),
                        ]),
                      ),
                    ]),
                    SizedBox(height: SizeConfig.v * 3),
                    SizedBox(
                      width: SizeConfig.screenWidth * 100 / 360,
                      child: MaterialButton(
                        onPressed: () {
                          DeviceSettingS0VM.instance.onAddPressed();
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: Color(0xff00A3FF),
                        child: Text(
                          'Add',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.b * 3.56,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: SizeConfig.v * 2),
            SizedBox(
              width: SizeConfig.screenWidth * 180 / 360,
              height: SizeConfig.screenHeight * 35 / 640,
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Updatelocation(
                          )));
                },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: Color(0xff00A3FF),
                child: Text(
                  'Update Device Location',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.b * 3.56,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        );
          },
      ),
    );
  }
}
