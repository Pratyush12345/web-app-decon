import 'package:Decon/Controller/Providers/devie_setting_provider.dart';
import 'package:Decon/Controller/ViewModels/Services/GlobalVariable.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/View_Web/series_S0/device_setting_viewmodel_S0.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/View_Web/DrawerFragments/Updatelocation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class DeviceSettingsS0Web extends StatefulWidget {

  @override
  _DeviceSettings createState() => _DeviceSettings();
}

class _DeviceSettings extends State<DeviceSettingsS0Web> {
  
  @override
  void initState() {
    DeviceSettingS0VM.instance.init(context);
    super.initState();
  }
   Text textRepeat() {
    return Text(
      "Meters",
      style: txtS(Color(0xff9ba1a3), 14, FontWeight.w500),
    );
  }

  Container containerText(TextEditingController controller) {
    var h = SizeConfig.screenHeight / 900;
    
    return Container(
      alignment: Alignment.center,
      width: SizeConfig.screenWidth * 36 / 1440,
      height: SizeConfig.screenHeight * 44 / 900,
      decoration: BoxDecoration(
        color: Color(0xFFe7e7e7),
        borderRadius: BorderRadius.circular(h * 4),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: h * 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintText: '0',
          hintStyle: TextStyle(fontSize: h * 18),
          border: InputBorder.none,
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;


    return Row(
        children: [
          Expanded(
            child: Column(
              children: [
                sh(80),
                Expanded(
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding:
                            EdgeInsets.fromLTRB(b * 40, h * 40, b * 40, h * 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(h * 10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.10),
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(
                            left: b * 32, right: b * 17, bottom: h * 55),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Update device parameters",
                              style: txtS(blc, 16, FontWeight.w400),
                            ),
                            sh(37),
                            Row(children: [
                              Text(
                                "Manhole's Depth",
                                style: txtS(dc, 16, FontWeight.w500),
                              ),
                              Spacer(),
                              Row(children: [
                                containerText(DeviceSettingS0VM.instance.maholesdepth),
                                SizedBox(width: b * 12),
                                textRepeat(),
                              ]),
                            ]),
                            
                            sh(13),
                            Row(children: [
                              Text(
                                "Battery Threshold Value",
                                style: txtS(dc, 16, FontWeight.w500),
                              ),
                              Spacer(),
                              Row(children: [
                                containerText(DeviceSettingS0VM.instance.batterythresholdvalue),
                                SizedBox(width: b * 12),
                                Text(
                                  "%          ",
                                  style: txtS(
                                      Color(0xff9ba1a3), 14, FontWeight.w500),
                                )
                              ]),
                            ]),
                            Spacer(),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: b * 140),
                              child: MaterialButton(
                                color: blc,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(h * 6),
                                ),
                                onPressed: () {
                                if(GlobalVar.strAccessLevel != null)
          
                                DeviceSettingS0VM.instance.onAddPressed(context);
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(vertical: h * 11),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Add Parameters',
                                    style: txtS(wc, 18, FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Updatelocation(),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
    ); 
   
  }
}
