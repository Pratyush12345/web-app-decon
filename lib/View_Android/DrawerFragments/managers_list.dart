import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Android/Dialogs/Add_Manager.dart';
import 'package:Decon/View_Android/DrawerFragments/add_client.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ManagersList extends StatefulWidget {
  String managerUid;
  ManagersList({@required this.managerUid});
  @override
  _ManagersListState createState() => _ManagersListState();
}

class _ManagersListState extends State<ManagersList> {
  List<UserDetailModel> _listUserDetailModel;
  int _selectedIndex = -1;
  Future showManagerDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Add_man();
        });
  }

  @override
    void initState() {
      _listUserDetailModel = [];
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text("Manager List"),
     actions: [
       MaterialButton(
         child: Text("Save",
         style: TextStyle(
           color: Colors.white
         ),
         ),
         onPressed: (){
          Navigator.of(context).pop(_listUserDetailModel[_selectedIndex]);
       })
     ],
     ),
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
              Map datamap = snapshot.data.snapshot.value;
              _listUserDetailModel = [];
              datamap.forEach((key, value) {
                _listUserDetailModel.add(UserDetailModel.fromJson(key.toString(), value));
              });
              if(widget.managerUid!=null){
                _selectedIndex = _listUserDetailModel.indexWhere((element) => element.key == widget.managerUid);
                widget.managerUid = null;
              }
            if(snapshot.data.snapshot.value!=null)
              return ListView.builder(
            itemCount: _listUserDetailModel.length,
            itemBuilder: (context, index){
            return Card(
              child: ListTile(
                leading: Text("${_listUserDetailModel[index].clientsVisible??""}"),
                title: Text("${_listUserDetailModel[index].name}"),
                subtitle: Text("${_listUserDetailModel[index].phoneNo}"),
                trailing: Checkbox(
                  value: index == _selectedIndex, 
                  onChanged: (val){
                    _selectedIndex = index;
                    print("_selected index========$_selectedIndex");
                    setState(() {});
                  }),
            )
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