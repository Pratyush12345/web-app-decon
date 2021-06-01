import 'package:Decon/Controller/ViewModels/add_client_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/View_Android/DrawerFragments/managers_list.dart';
import 'package:flutter/material.dart';

class AddClient extends StatefulWidget {
  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  
   _initializeData() async{
    await AddClientVM.instance.getSeriesList();
    setState(() {});
   }

  @override
    void initState() {
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
            Padding(
                  padding: EdgeInsets.all(12.0),
                  child: DropdownButtonFormField<String>(
                    onChanged: (value) async {
                       AddClientVM.instance.seriesValue = value;
                       setState(() {
                         
                       });
                     },

                    decoration: InputDecoration(
                      hintText: 'Select',
                      labelText: 'Select Series',
                    ),
                    value: AddClientVM.instance.seriesValue ,
                    items:    
                          AddClientVM.instance.seriesList.map((e) => 
                          DropdownMenuItem<String>(
                                  child: Text(e),
                                  value: e.toString(),
                                )
                          ).toList(),
                    onSaved: (val) {
                     // widget.saveOrderLine.intContractId = int.parse(val);
                    },
                    validator: (val) {
                      print('value is $val');
                      if (val == null) return 'Please choose an option.';
                      return null;
                    },
                  )),
            SizedBox(height: 15.0,),
            MaterialButton(
              color: Colors.blue,
              child: Text("Select Manager of Client"),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ManagersList()));   
            }),
            SizedBox(height: 40.0,),  
            MaterialButton(
              color: Colors.blue,
              child: Text("Done"),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ManagersList()));   
            }),      
          ],
        ),
      ),
    );
  }
}