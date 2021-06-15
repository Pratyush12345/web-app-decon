import 'package:Decon/Models/Consts/client_not_found.dart';
import 'package:Decon/Models/Consts/database_calls.dart';
import 'package:Decon/Models/Models.dart';

class AllPeopleVM{
  static AllPeopleVM instance = AllPeopleVM._();
  AllPeopleVM._();
  DatabaseCallServices _databaseCallServices = DatabaseCallServices();
  UserDetailModel managerDetailModel, adminDetailModel;
  List<UserDetailModel> listOfMangerTeam;
  List<UserDetailModel> listOfAdminTeam;
  
  init(){
    managerDetailModel = null;
    adminDetailModel = null;
    listOfAdminTeam = null;
    listOfMangerTeam = null;
  }
  

  Future<dynamic> getManagerDetail(String manageruid) async{
   try{
    managerDetailModel =  await _databaseCallServices.getManagerCredentails(manageruid);
    return managerDetailModel ?? UserDetailModel();
   }
   catch(e){
     print(e);
   }
  }

  Future<dynamic> getAdminDetail(String adminuid) async{
   try{
    adminDetailModel =  await _databaseCallServices.getAdminCredentails(adminuid);
    return adminDetailModel?? UserDetailModel();
   }
   catch(e){
     print(e);
   }
  }

  Future<dynamic> getManagerTeamDetailList(String manageruid) async{
   try{
    listOfMangerTeam =  await _databaseCallServices.getManagerTeamCredentailsList(manageruid);
    return listOfMangerTeam;
   }
   catch(e){
     print(e);
   }
  }

  Future<dynamic> getAdminTeamDetailList(String adminuid) async{
   try{
    listOfAdminTeam =  await _databaseCallServices.getAdminTeamCredentailsList(adminuid);
    return listOfAdminTeam;
   }
   catch(e){
     print(e);
   }
  }



}