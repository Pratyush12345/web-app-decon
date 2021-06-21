import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/View_Android/clients/add_client.dart';
import 'package:Decon/View_Android/clients/edit_clients.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllClients extends StatefulWidget {
  @override
  _AllClientsState createState() => _AllClientsState();
}

class _AllClientsState extends State<AllClients> {
  Map _clientsMap = {};
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Scaffold(
     appBar: AppBar(title: Text("Client List"),
     backgroundColor: blc,),
     floatingActionButton: FloatingActionButton(
       backgroundColor: blc,
       child: Icon(Icons.add),
       onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddClient(clientCode: "C${_clientsMap?.length??0}",isedit: false,)));
       },
     ),
     body: Container(
       padding: EdgeInsets.symmetric(horizontal: b * 22),
        
       child: Column(
         children: [
           sh(27),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.center,
                      width: b * 340,
                      decoration: BoxDecoration(
                        border: Border.all(color: dc, width: 0.5),
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(b * 60),
                      ),
                      child: TextField(
                        controller: search,
                        style: TextStyle(fontSize: b * 14, color: dc),
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            child: Icon(Icons.search, color: Colors.black),
                            onTap: null,
                          ),
                          isDense: true,
                          isCollapsed: true,
                          prefixIconConstraints:
                              BoxConstraints(minWidth: 40, maxHeight: 24),
                          hintText: 'Search by Name',
                          hintStyle: TextStyle(
                            fontSize: b * 14,
                            color: Color(0xff858585),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: h * 12, horizontal: b * 13),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Container(
                        height: h * 45,
                        padding: EdgeInsets.symmetric(horizontal: b * 18),
                        width: b * 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: blc, width: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'images/filter.svg',
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              sh(30),
              
           Expanded(
             child: StreamBuilder<Event>(
               stream: FirebaseDatabase.instance.reference().child("clientsList").onValue,
               builder: (context, snapshot){
                 if(snapshot.hasData){
                    _clientsMap = snapshot.data.snapshot.value;
                    if(snapshot.data.snapshot.value!=null)
                      return ListView.builder(
                    
                    padding: EdgeInsets.only(top: h * 5),
                    itemCount: _clientsMap.length,
                    itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ClientDetails(clientCode: "${_clientsMap.keys.toList()[index]}",)));
                        
                      },
                      child: Container(
                          margin: EdgeInsets.only(bottom: h * 8),
                          padding: EdgeInsets.symmetric(
                              vertical: h * 12, horizontal: b * 0),
                          decoration: BoxDecoration(
                            color: Color(0xfff1f1f1),
                            borderRadius: BorderRadius.circular(b * 10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: h * 50,
                                  width: b * 50,
                                  decoration: BoxDecoration(
                                    color: Color(0xff6d6d6d),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${_clientsMap.values.toList()[index]}",
                                      style: txtS(blc, 16, FontWeight.w700),
                                    ),
                                    
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "${_clientsMap.keys.toList()[index]}",
                                  style: txtS(dc, 18, FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ); 
                    });
                    else
                    return AppConstant.noClientFound();
                 }
                 else{
                   if(snapshot.hasError)
                   return Center(
                        child: Text('${snapshot.error}'),
                      );
                   else
                   return AppConstant.circulerProgressIndicator();   
                 }
               }       
               
             ),
           ),
         ],
       ),
     )
    );
  }
}