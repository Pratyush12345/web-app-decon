import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/View_Android/Dialogs/Add_Manager.dart';
import 'package:Decon/View_Android/DrawerFragments/add_client.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ManagersList extends StatefulWidget {
  @override
  _ManagersListState createState() => _ManagersListState();
}

class _ManagersListState extends State<ManagersList> {
  Future showManagerDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Add_man();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text("Manager List"),),
     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.add),
       onPressed: (){
           showManagerDialog(context);
       },
     ),
     body: StreamBuilder<Event>(
       stream: FirebaseDatabase.instance.reference().child("managers").onValue,
       builder: (context, snapshot){
         if(snapshot.hasData){
            
            if(snapshot.data.snapshot.value!=null)
              return ListView.builder(
            itemCount: 0,
            itemBuilder: (context, index){
            return Card(
              child: ListTile(
                leading: Text(""),
                title: Text(""),
              ),
            );
            });
            else
            return AppConstant.noDataFound();
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