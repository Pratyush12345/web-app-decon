import 'package:Decon/Controller/ViewModels/add_client_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Android/DrawerFragments/managers_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddClient extends StatefulWidget {
  final String clientCode;
  AddClient({@required this.clientCode});
  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  UserDetailModel _userDetailModel;

   _initializeData() async{
    AddClientVM.instance.init(); 
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
             print(AddClientVM.instance.selectedSeries);
             
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
      appBar: AppBar(title: Text("Add Client"),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: AddClientVM.instance.seriesList == null? AppConstant.circulerProgressIndicator():
          AddClientVM.instance.seriesList.isEmpty ? AppConstant.noDataFound():
           Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Enter Name"
              ),
              style: TextStyle(
                fontSize: 12.0
              ),
            ),
            SizedBox(height: 15.0,),
            TextField(
              controller: _departmentNameController,
              decoration: InputDecoration(
                hintText: "Enter Department Name"
              ),
              style: TextStyle(
                fontSize: 12.0
              ),
            ),
            SizedBox(height: 15.0,),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: "Enter City"
              ),
              style: TextStyle(
                fontSize: 12.0
              ),
            ),
            SizedBox(height: 15.0,),
            TextField(
              controller: _districtController,
              decoration: InputDecoration(
                hintText: "Enter District"
              ),
              style: TextStyle(
                fontSize: 12.0
              ),
            ),
            SizedBox(height: 15.0,),
            TextField(
              controller: _stateController,
              decoration: InputDecoration(
                hintText: "Enter State"
              ),
              style: TextStyle(
                fontSize: 12.0
              ),
            ),
            SizedBox(height: 15.0,),
            _getSeriesWidget(),
            // Padding(
            //       padding: EdgeInsets.all(12.0),
            //       child: DropdownButtonFormField<String>(
            //         onChanged: (value) async {
            //            AddClientVM.instance.seriesValue = value;
            //            setState(() {
                         
            //            });
            //          },

            //         decoration: InputDecoration(
            //           hintText: 'Select',
            //           labelText: 'Select Series',
            //         ),
            //         value: AddClientVM.instance.seriesValue ,
            //         items:    
            //               AddClientVM.instance.seriesList.map((e) => 
            //               DropdownMenuItem<String>(
            //                       child: Text(e),
            //                       value: e.toString(),
            //                     )
            //               ).toList(),
            //         onSaved: (val) {
            //          // widget.saveOrderLine.intContractId = int.parse(val);
            //         },
            //         validator: (val) {
            //           print('value is $val');
            //           if (val == null) return 'Please choose an option.';
            //           return null;
            //         },
            //       )),
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ManagersList())).
                then((value){ 
                  if(value!=null)
                  _userDetailModel = value;
                  setState(() {});
                  } );   
            }),
            SizedBox(height: 40.0,),  
            MaterialButton(
              color: Colors.blue,
              child: Text("Done"),
              onPressed: (){
                ClientListModel clientListModel = ClientListModel(
                  clientCode: widget.clientCode,
                  clientName: _cityController.text.trim()
                );
                ClientDetailModel model = ClientDetailModel(
                  cityName: _cityController.text.trim(),
                  clientName: _nameController.text.trim(),
                  departmentName: _departmentNameController.text.trim(),
                  districtName: _districtController.text.trim(),
                  selectedSeries: AddClientVM.instance.selectedSeries,
                  stateName: _stateController.text.trim(),
                  selectedManager: _userDetailModel.key
                );
                AddClientVM.instance.onPressedDone(context, widget.clientCode, model, clientListModel);  
                
            }),      
          ],
        ),
      ),
    );
  }
}