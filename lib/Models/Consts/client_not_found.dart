import 'package:Decon/View_Android/Authentication/EnterOtp.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/View_Android/DrawerFragments/all_clients.dart';
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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("No Client Found"),
          SizedBox(height: 20.0,),
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllClients()));
            },
            child: Text("Add Client"),
          ),
        ],
      )
    );
  }
}
