

import 'package:Decon/Controller/Providers/Client_provider.dart';
import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Controller/ViewModels/add_client_viewmodel.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/View_Web/DrawerFragments/Updatelocation.dart';
import 'package:Decon/View_Web/DrawerFragments/managers_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddClient extends StatefulWidget {
  final String clientCode;
  final bool isedit;
  final UserDetailModel userDetailModel;
  AddClient({this.userDetailModel, @required this.clientCode, this.isedit });
  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  TextEditingController _nameController;
  TextEditingController _departmentNameController ;
  TextEditingController _cityController ;
  TextEditingController _districtController ;
  TextEditingController _stateController ;
  TextEditingController _sheetController ;
  TextEditingController _maintainenceSheetController ;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  UserDetailModel _userDetailModel;
  UserDetailModel _previousUserDetailModel;
   void validate() async{
    if(_formKey.currentState.validate()){
                  if(AddClientVM.instance.selectedSeries == null || AddClientVM.instance.selectedSeries == ""){
                    AppConstant.showFailToast(context, "Please Select Series");
                  }
                  else if(_userDetailModel?.key == null || _userDetailModel.key == "" ){
                    AppConstant.showFailToast(context, "Please Select Manager");
                  }
                  else{
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
                    selectedAdmin: AddClientVM.instance.clientDetailModel?.selectedAdmin??"",
                    sheetURL: _sheetController.text.trim(),
                    maintainenceSheetURL: _maintainenceSheetController.text.trim()
                  );
                  AddClientVM.instance.onPressedDone(context, _previousUserDetailModel,_userDetailModel.clientsVisible, widget.isedit, model, clientListModel);       
                  }
           }
    else{
      print("Not Validated");
    }
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
   _initializeDate() async{
     if(!widget.isedit){
       AddClientVM.instance.init();
     }
     _userDetailModel = widget.userDetailModel;
     
    _previousUserDetailModel = _userDetailModel;
    
    _nameController = TextEditingController();
    _departmentNameController = TextEditingController();
    _cityController = TextEditingController();
    _districtController = TextEditingController();
    _stateController = TextEditingController();
    _sheetController = TextEditingController();
    _maintainenceSheetController = TextEditingController();

    _nameController.text = AddClientVM.instance.clientDetailModel?.clientName;
    _departmentNameController.text = AddClientVM.instance.clientDetailModel?.departmentName;
    _cityController.text = AddClientVM.instance.clientDetailModel?.cityName;
    _districtController.text = AddClientVM.instance.clientDetailModel?.districtName;
    _stateController.text = AddClientVM.instance.clientDetailModel?.stateName;
    _sheetController.text = AddClientVM.instance.clientDetailModel?.sheetURL;
    _maintainenceSheetController.text = AddClientVM.instance.clientDetailModel?.maintainenceSheetURL;
    await AddClientVM.instance.getSeriesList();
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_){
     if(widget.isedit){
       
     Provider.of<ChangeManager>(context, listen: false).changeManager(widget.userDetailModel);
     }
     else{
     Provider.of<ChangeManager>(context, listen: false).changeManager(null);
     }
    });
    }


  @override
    void initState() {
      _initializeDate();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
   var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 1440;


    return Scaffold(
      backgroundColor: wc,
      body: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  sh(50),
                  Padding(
                    padding: EdgeInsets.only(right: b * 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          color: blc,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(h * 6),
                          ),
                          onPressed: () {
                            validate();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: h * 11, horizontal: b * 60),
                            alignment: Alignment.center,
                            child: Text(
                              widget.isedit?"Update": "Done" ,
                  
                              style: txtS(wc, 18, FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  sh(30),
                  Expanded(
                    child: Row(children: [
                      AddClientVM.instance.seriesList == null? AppConstant.circulerProgressIndicator():
                      AddClientVM.instance.seriesList.isEmpty ? AppConstant.noDataFound():
          
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding:
                              EdgeInsets.fromLTRB(b * 40, h * 40, b * 40, h * 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(h * 10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.10),
                                blurRadius: 20,
                                spreadRadius: 0,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(
                              left: b * 62, right: b * 72, bottom: h * 55),
                          child: Form(
                            key: _formKey,
                            child: ListView(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Fill Details",
                                  style:
                                      txtS(Color(0xff858585), 16, FontWeight.w500),
                                ),
                                sh(16),
                                TextFormField(
                                   validator: (val){
                                      if(val.isEmpty)
                                      return "Name Cannot be empty";
                                      else
                                      return null;
                                    },
                
                                  controller: _nameController,
                                  style: txtS(dc, 16, FontWeight.w500),
                                  decoration: InputDecoration(
                                    fillColor: Color(0xfff6f6f6),
                                    filled: true,
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: h * 14, horizontal: b * 14),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Enter name",
                                    hintStyle: txtS(Color(0xff858585), 16, FontWeight.w400),
                                    enabledBorder: InputBorder.none,
                                  ),
                                  maxLines: 1,
                                ),
                                // sh(16),
                                // TextFormField(
                                //    validator: (val){
                                //     if(val.isEmpty)
                                //     return "Department name cannot be empty";
                                //     else
                                //     return null;
                                //   },
                
                                //   controller: _departmentNameController,
                                //   style: txtS(dc, 16, FontWeight.w500),
                                //   decoration: InputDecoration(
                                //     fillColor: Color(0xfff6f6f6),
                                //     filled: true,
                                    
                                //     isDense: true,
                                //     contentPadding:
                                //         EdgeInsets.symmetric(vertical: h * 14, horizontal: b * 14),
                                //     border: InputBorder.none,
                                //     focusedBorder: InputBorder.none,
                                //     hintText: "Enter department name",
                                //     hintStyle: txtS(Color(0xff858585), 16, FontWeight.w400),
                                //     enabledBorder: InputBorder.none,
                                //   ),
                                //   maxLines: 1,
                                // ),
                                sh(16),
                                TextFormField(
                                   validator: (val){
                                      if(val.isEmpty)
                                      return "City Name cannot be empty";
                                      else
                                      return null;
                                    },
                
                                  controller: _cityController,
                                  style: txtS(dc, 16, FontWeight.w500),
                                  decoration: InputDecoration(
                                    fillColor: Color(0xfff6f6f6),
                                    filled: true,
                                    
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: h * 14, horizontal: b * 14),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Enter city name",
                                    hintStyle: txtS(Color(0xff858585), 16, FontWeight.w400),
                                    enabledBorder: InputBorder.none,
                                  ),
                                  maxLines: 1,
                                ),
                                sh(16),
                                TextFormField(
                                   validator: (val){
                                      if(val.isEmpty)
                                      return "District name cannot be empty";
                                      else
                                      return null;
                                    },
                
                                  controller: _districtController,
                                  style: txtS(dc, 16, FontWeight.w500),
                                  decoration: InputDecoration(
                                    fillColor: Color(0xfff6f6f6),
                                    filled: true,
                                    
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: h * 14, horizontal: b * 14),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Enter district name",
                                    hintStyle: txtS(Color(0xff858585), 16, FontWeight.w400),
                                    enabledBorder: InputBorder.none,
                                  ),
                                  maxLines: 1,
                                ),
                                sh(16),
                                TextFormField(
                                   validator: (val){
                                      if(val.isEmpty)
                                      return "State name cannot be empty";
                                      else
                                      return null;
                                    },
                
                                  controller: _stateController,
                                  style: txtS(dc, 16, FontWeight.w500),
                                  decoration: InputDecoration(
                                    fillColor: Color(0xfff6f6f6),
                                    filled: true,
                                    
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: h * 14, horizontal: b * 14),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Enter State name",
                                    hintStyle: txtS(Color(0xff858585), 16, FontWeight.w400),
                                    enabledBorder: InputBorder.none,
                                  ),
                                  maxLines: 1,
                                ),
                                sh(16),
                                TextFormField(
                                   validator: (val){
                                      if(val.isEmpty)
                                      return "Sheet URL cannot be empty";
                                      else
                                      return null;
                                    },
                
                                  controller: _sheetController,
                                  style: txtS(dc, 16, FontWeight.w500),
                                  decoration: InputDecoration(
                                    fillColor: Color(0xfff6f6f6),
                                    filled: true,
                                    
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: h * 14, horizontal: b * 14),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Enter Sheet URL",
                                    hintStyle: txtS(Color(0xff858585), 16, FontWeight.w400),
                                    enabledBorder: InputBorder.none,
                                  ),
                                  maxLines: 1,
                                ),
                                sh(16),
                                TextFormField(
                                   validator: (val){
                                      if(val.isEmpty)
                                      return "Maintainence Sheet URL cannot be empty";
                                      else
                                      return null;
                                    },
                
                                  controller: _maintainenceSheetController,
                                  style: txtS(dc, 16, FontWeight.w500),
                                  decoration: InputDecoration(
                                    fillColor: Color(0xfff6f6f6),
                                    filled: true,
                                    
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: h * 14, horizontal: b * 14),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Enter Maintainence Sheet URL",
                                    hintStyle: txtS(Color(0xff858585), 16, FontWeight.w400),
                                    enabledBorder: InputBorder.none,
                                  ),
                                  maxLines: 1,
                                ),
                                sh(16),
                            Text(
                                "Select Series",
                                style: TextStyle(
                                  fontSize: b * 14,
                                  color: dc,
                                  fontWeight: FontWeight.w500,
                                ),
                                ),
                            sh(6),
                            
                            _getSeriesWidget(),
                            SizedBox(height: 15.0,),
                            Consumer<ChangeManager>(
                              builder: (context, model, child){
                              _userDetailModel = model.userDetailModel;
                              if(_userDetailModel?.key !=null)
                            
                              return Card(
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
                                    );
                                else
                                return SizedBox();    
                              }
                            ),

            //                     sh(h*20),
            //                   Expanded(
            //   flex: 1,
            //   child: InkWell(
            //     onTap: () {
            //      },
            //     child: Container(
            //       margin: EdgeInsets.only(
            //           bottom: h * 40, left: b * 170, right: b * 170, top: h * 32),
            //       decoration: BoxDecoration(
            //         color: blc,
            //         border: Border.all(color: blc, width: 0.5),
            //         borderRadius: BorderRadius.circular(h * 6),
            //       ),
            //       alignment: Alignment.center,
            //       child: Text(
            //         "Create Client",
            //         style: txtS(wc , 18, FontWeight.w500),
            //       ),
            //     ),
            //   ),
            // ),  
                                
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ManagersList(managerUid: widget.userDetailModel?.key, clientName: _nameController.text.trim() ,),
                      ),
                    ]),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
    ); 
    
  }
}