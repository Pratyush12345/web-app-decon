import 'package:Decon/Controller/Utils/sizeConfig.dart';
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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  UserDetailModel _userDetailModel;
  UserDetailModel _previousUserDetailModel;
   void validate() async{
    if(_formKey.currentState.validate()){
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
              
           }
    else{
      print("Not Validated");
    }
  }

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
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Scaffold(
      appBar: AppBar(leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: blc, size: b * 16),
        ),
        elevation: 10,
        titleSpacing: -3,
        iconTheme: IconThemeData(color: blc),
        title: Text(
          "Add Client",
          style: txtS(Colors.black, 16, FontWeight.w500),
        ),
        actions: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: b * 20),
              height: h * 32,
              width: b * 32,
              decoration: BoxDecoration(
                color: blc,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: b * 16, vertical: b * 14),
        child: AddClientVM.instance.seriesList == null? AppConstant.circulerProgressIndicator():
          AddClientVM.instance.seriesList.isEmpty ? AppConstant.noDataFound():
          Form(
            key: _formKey,
             child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             TextFormField(
               validator: (val){
                            if(val.isEmpty)
                            return "Name Cannot be empty";
                            else
                            return null;
                          },
                
               controller: _nameController..text = AddClientVM.instance.clientDetailModel?.clientName,
              style: TextStyle(fontSize: b * 16, color: dc),
               decoration: InputDecoration(
                 fillColor: Color(0xfff6f6f6),
                 filled: true,
                          
                 isDense: true,
                 contentPadding:
                     EdgeInsets.symmetric(vertical: h * 8, horizontal: b * 8),
                 border: InputBorder.none,
                 focusedBorder: InputBorder.none,
                 hintText: "Enter name",
                 hintStyle: TextStyle(
                   fontSize: b * 16,
                   color: Color(0xff858585),
                 ),
                 enabledBorder: InputBorder.none,
               ),
               maxLines: 1,
             ),
              SizedBox(height: 15.0,),
              TextFormField(
               validator: (val){
                            if(val.isEmpty)
                            return "Department Name Cannot be empty";
                            else
                            return null;
                          },
                
                
               controller: _departmentNameController..text = AddClientVM.instance.clientDetailModel?.departmentName,
              style: TextStyle(fontSize: b * 16, color: dc),
               decoration: InputDecoration(
                 fillColor: Color(0xfff6f6f6),
                 filled: true,
                          
                 isDense: true,
                 contentPadding:
                     EdgeInsets.symmetric(vertical: h * 8, horizontal: b * 8),
                 border: InputBorder.none,
                 focusedBorder: InputBorder.none,
                 hintText: "Enter Department Name",
                 hintStyle: TextStyle(
                   fontSize: b * 16,
                   color: Color(0xff858585),
                 ),
                 enabledBorder: InputBorder.none,
               ),
               maxLines: 1,
             ),
              SizedBox(height: 15.0,),
              TextFormField(
               validator: (val){
                            if(val.isEmpty)
                            return "City Name Cannot be empty";
                            else
                            return null;
                          },
                 
               controller: _cityController..text = AddClientVM.instance.clientDetailModel?.cityName,
              style: TextStyle(fontSize: b * 16, color: dc),
               decoration: InputDecoration(
                 fillColor: Color(0xfff6f6f6),
                 filled: true,
                          
                 isDense: true,
                 contentPadding:
                     EdgeInsets.symmetric(vertical: h * 8, horizontal: b * 8),
                 border: InputBorder.none,
                 focusedBorder: InputBorder.none,
                 hintText: "Enter City Name",
                 hintStyle: TextStyle(
                   fontSize: b * 16,
                   color: Color(0xff858585),
                 ),
                 enabledBorder: InputBorder.none,
               ),
               maxLines: 1,
             ),
              SizedBox(height: 15.0,),
              TextFormField(
                validator: (val){
                            if(val.isEmpty)
                            return "District name Cannot be empty";
                            else
                            return null;
                          },
                
                controller: _districtController..text = AddClientVM.instance.clientDetailModel?.districtName,
                decoration: InputDecoration(
                  fillColor: Color(0xfff6f6f6),
                  filled: true,
                  contentPadding:
                     EdgeInsets.symmetric(vertical: h * 8, horizontal: b * 8),
                 border: InputBorder.none,
                 focusedBorder: InputBorder.none,
                 enabledBorder: InputBorder.none,
                  hintText: "Enter District",
                  hintStyle: TextStyle(
                   fontSize: b * 16,
                   color: Color(0xff858585),
                 ),
                ),
                
               maxLines: 1,
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                validator: (val){
                            if(val.isEmpty)
                            return "State Name Cannot be empty";
                            else
                            return null;
                          },
                controller: _stateController..text = AddClientVM.instance.clientDetailModel?.stateName,
                decoration: InputDecoration(
                  fillColor: Color(0xfff6f6f6),
                 filled: true,
                 contentPadding:
                     EdgeInsets.symmetric(vertical: h * 8, horizontal: b * 8),
                 border: InputBorder.none,
                 focusedBorder: InputBorder.none,
                 enabledBorder: InputBorder.none,
                  
                 
                  hintText: "Enter State",
                  hintStyle: TextStyle(
                   fontSize: b * 16,
                   color: Color(0xff858585),
                 ),
                ),
                
               maxLines: 1,
              ),
              SizedBox(height: 15.0,),
              
              TextFormField(
                validator: (val){
                            if(val.isEmpty)
                            return "Sheet URL Cannot be empty";
                            else
                            return null;
                          },
                controller: _sheetController..text = AddClientVM.instance.clientDetailModel?.sheetURL,
                decoration: InputDecoration(
                  fillColor: Color(0xfff6f6f6),
                 filled: true,
                 contentPadding:
                     EdgeInsets.symmetric(vertical: h * 8, horizontal: b * 8),
                 border: InputBorder.none,
                 focusedBorder: InputBorder.none,
                 enabledBorder: InputBorder.none,
                  
                 
                  hintText: "Enter Sheet URL",
                  hintStyle: TextStyle(
                   fontSize: b * 16,
                   color: Color(0xff858585),
                 ),
                ),
                
               maxLines: 1,
              ),
              
              SizedBox(height: 15.0,),
              _getSeriesWidget(),
              SizedBox(height: 15.0,),
              if(_userDetailModel?.key !=null)
              Card(
                      child: ListTile(
                        leading: Container(
                                      height: h * 25,
                                      width: b * 25,
                                      decoration: BoxDecoration(
                                        color: Color(0xff6d6d6d),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                        title: Text("${_userDetailModel?.name}",
                        style: txtS(blc, 16, FontWeight.w400)),
                        subtitle: Text("${_userDetailModel?.phoneNo}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: txtS(dc, 14, FontWeight.w400)),
                        trailing: Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("${_userDetailModel?.clientsVisible?.replaceFirst(",", "")??""}"),
                              
                            ],
                          ),
                        ),
                    )
                    ),
              SizedBox(height: 10.0,),
              MaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: blc,
              padding: EdgeInsets.symmetric(vertical: h * 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(b * 6),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ManagersList(managerUid: _userDetailModel?.key,))).
                  then((value){ 
                    if(value!=null)
                    _userDetailModel = value;
                    setState(() {});
                    } );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: h * 10),
                alignment: Alignment.center,
                child: Text(
                  _userDetailModel?.key ==null? "Select Manager for Client" : "Update Manager for Client" ,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: b * 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            
              SizedBox(height: 40.0,), 
              MaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: blc,
              padding: EdgeInsets.symmetric(vertical: h * 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(b * 6),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ManagersList(managerUid: _userDetailModel?.key,))).
                  then((value){ 
                    if(value!=null)
                    _userDetailModel = value;
                    setState(() {});
                    } );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: h * 10),
                alignment: Alignment.center,
                child: Text(
                  widget.isedit?"Update": "Done" ,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: b * 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
             
                    
          ],
        ),
           ),
      ),
    );
  }
}