import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/View_Android/DrawerFragments/add_client.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AllClients extends StatefulWidget {
  @override
  _AllClientsState createState() => _AllClientsState();
}

class _AllClientsState extends State<AllClients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text("All Clients"),),
     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.add),
       onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddClient()));
       },
     ),
     body: StreamBuilder<Event>(
       stream: FirebaseDatabase.instance.reference().child("clientsList").onValue,
       builder: (context, snapshot){
         if(snapshot.hasData){
            Map _citiesMap = snapshot.data.snapshot.value;
            if(snapshot.data.snapshot.value!=null)
              return ListView.builder(
            itemCount: _citiesMap.length,
            itemBuilder: (context, index){
            return Card(
              child: ListTile(
                leading: Text("${_citiesMap.keys.toList()[index]}"),
                title: Text("${_citiesMap.values.toList()[index]}"),
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
       
     )
    );
  }
}