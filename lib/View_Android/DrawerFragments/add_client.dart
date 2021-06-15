import 'package:Decon/Controller/ViewModels/add_client_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Android/DrawerFragments/managers_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddClient extends StatefulWidget {
  final String clientCode;
  final bool isedit;
  AddClient({@required this.clientCode, @required this.isedit});
  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _sheetController = TextEditingController();
 
  UserDetailModel _userDetailModel;
  UserDetailModel _previousUserDetailModel;

   _initializeData() async{
    AddClientVM.instance.init(); 
    if(widget.isedit){
    await AddClientVM.instance.getClientDetail(widget.clientCode);
    _userDetailModel = await AddClientVM.instance.getManagerDetail();
    _previousUserDetailModel = _userDetailModel;
    }
    await AddClientVM.instance.getSeriesList();
    setState(() {});
   }
   _getSeriesWidget(){
     return Column(
       children: AddClientVM.instance.seriesList.map((e) => 
       Row(children: [
         Text(e),
         Spacer(),
         Checkbox(
           value: AddClientVM.instance.selectedSeries.contains(e), 
           onChanged: (val){
             if(val){
             AddClientVM.instance.selectedSeries = AddClientVM.instance.selectedSeries + "," + e.trim(); 
             }
             else{
             AddClientVM.instance.selectedSeries = AddClientVM.instance.selectedSeries.replaceAll(","+e.trim(), "");
             }
             
             setState(() {});
         })
       ],)
       ).toList()
     );
   }
  @override
    void initState() {
      _userDetailModel = UserDetailModel();
      _initializeData();  
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Client"),
      actions: [
        if(widget.isedit)
        MaterialButton(
          onPressed: (){
            AddClientVM.instance.onDeactivatePressed(widget.clientCode);
          },
          child: Text( "Deactivate",
          style: TextStyle(
            color: Colors.white
          ),),
        )
      ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: AddClientVM.instance.seriesList == null? AppConstant.circulerProgressIndicator():
          AddClientVM.instance.seriesList.isEmpty ? AppConstant.noDataFound():
           Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController..text = AddClientVM.instance.clientDetailModel?.clientName,
              decoration: InputDecoration(
                hintText: "Enter Name"
              ),
              style: TextStyle(
                fontSize: 12.0
              ),
            ),
            SizedBox(height: 15.0,),
            TextField(
              controller: _departmentNameController..text = AddClientVM.instance.clientDetailModel?.departmentName,
              decoration: InputDecoration(
                hintText: "Enter Department Name"
              ),
              style: TextStyle(
                fontSize: 12.0
              ),
            ),
            SizedBox(height: 15.0,),
            TextField(
              controller: _cityController..text = AddClientVM.instance.clientDetailModel?.cityName,
              decoration: InputDecoration(
                hintText: "Enter City"
              ),
              style: TextStyle(
                fontSize: 12.0
              ),
            ),
            SizedBox(height: 15.0,),
            TextField(
              controller: _districtController..text = AddClientVM.instance.clientDetailModel?.districtName,
              decoration: InputDecoration(
                hintText: "Enter District"
              ),
              style: TextStyle(
                fontSize: 12.0
              ),
            ),
            SizedBox(height: 15.0,),
            TextField(
              controller: _stateController..text = AddClientVM.instance.clientDetailModel?.stateName,
              decoration: InputDecoration(
                hintText: "Enter State"
              ),
              style: TextStyle(
                fontSize: 12.0
              ),
            ),
            TextField(
              controller: _sheetController..text = AddClientVM.instance.clientDetailModel?.sheetURL,
              decoration: InputDecoration(
                hintText: "Enter Sheet URL"
              ),
              style: TextStyle(
                fontSize: 12.0
              ),
            ),
            
            SizedBox(height: 15.0,),
            _getSeriesWidget(),
            SizedBox(height: 15.0,),
            if(_userDetailModel.key !=null)
            Card(
              child: ListTile(
                leading: Text("${_userDetailModel.clientsVisible??""}"),
                title: Text("${_userDetailModel.name}"),
                subtitle: Text("${_userDetailModel.phoneNo}")
            )
            ),
            MaterialButton(
              color: Colors.blue,
              child: Text(_userDetailModel.key ==null? "Select Manager for Client" : "Update Manager for Client" ),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ManagersList(managerUid: _userDetailModel.key,))).
                then((value){ 
                  if(value!=null)
                  _userDetailModel = value;
                  setState(() {});
                  } );   
            }),
            SizedBox(height: 40.0,),  
            MaterialButton(
              color: Colors.blue,
              child: Text(widget.isedit?"Update": "Done"),
              onPressed: (){
                ClientListModel clientListModel = ClientListModel(
                  clientCode: widget.clientCode,
                  clientName: _nameController.text.trim()
                );
                ClientDetailModel model = ClientDetailModel(
                  cityName: _cityController.text.trim(),
                  clientName: _nameController.text.trim(),
                  departmentName: _departmentNameController.text.trim(),
                  districtName: _districtController.text.trim(),
                  selectedSeries: AddClientVM.instance.selectedSeries,
                  stateName: _stateController.text.trim(),
                  selectedManager: _userDetailModel.key,
                  selectedAdmin: "",
                  sheetURL: _sheetController.text.trim()
                );
                AddClientVM.instance.onPressedDone(context, _previousUserDetailModel,_userDetailModel.clientsVisible, widget.isedit, model, clientListModel);       
            }),      
          ],
        ),
      ),
    );
  }
}