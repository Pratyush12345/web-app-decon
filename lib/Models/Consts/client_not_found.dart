import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/View_Android/clients/all_clients.dart';
import 'package:flutter/material.dart';


class ClientsNotFound extends StatefulWidget {
  final BuildContext menuScreenContext;
  ClientsNotFound({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _ClientsNotFound createState() => _ClientsNotFound();
}


class _ClientsNotFound extends State<ClientsNotFound> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Container(
          padding: EdgeInsets.symmetric(horizontal: b * 26),
          child: Column(
            children: [
              sh(40),
              Image.asset(
                      'images/nodata1.png',
                  height: h * 230),
              sh(20),
              Text(
                    'No client found!',
                style: txtS(blc, b * 20, FontWeight.w700),
              ),
              sh(60),
              MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: blc,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(b * 6),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllClients()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: h * 10),
                  alignment: Alignment.center,
                  child: Text(
                    'Add Client',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: b * 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ); 
     }
}
