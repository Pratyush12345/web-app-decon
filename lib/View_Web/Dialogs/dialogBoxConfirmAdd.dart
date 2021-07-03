import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class DialogBoxConfirmAdd extends StatelessWidget {
  final String managerName;
  final String clientName;
  DialogBoxConfirmAdd({@required this.clientName, @required this.managerName});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 1440;
    var h = SizeConfig.screenHeight / 900;
    return Dialog(
     backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: b * 476.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(h * 10),
      ),
    
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          padding: EdgeInsets.fromLTRB(b * 21, h * 15, b * 21, h * 21),
          child: Column(children: [
            Text(
              "Are you sure you want to add “$managerName” to “$clientName” as manager?",
              textAlign: TextAlign.center,
              style: txtS(dc, b * 16, FontWeight.w400),
            ),
            sh(38),
            Row(children: [
              Expanded(
                flex: 2,
                child: MaterialButton(
                  color: Color(0xff00A3FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(b * 6),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.of(context).pop("YES");
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: b * 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    
                    Navigator.of(context).pop("NO");
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'No',
                      style: TextStyle(
                        color: blc,
                        fontSize: b * 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ]),
    );
  }
}


