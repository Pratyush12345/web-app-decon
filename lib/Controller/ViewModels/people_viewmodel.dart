import 'package:Decon/Models/Consts/database_calls.dart';
import 'package:Decon/Models/Models.dart';

class PeopleVM {
   static PeopleVM instance = PeopleVM._();
  PeopleVM._();
  DatabaseCallServices _databaseCallServices = DatabaseCallServices();
  
  Future<dynamic> getClientDetail(String clientCode) async{
   try{
    ClientDetailModel clientDetailModel =  await _databaseCallServices.getClientDetail(clientCode);
    return clientDetailModel;
   }
   catch(e){
     print(e);
   }
  }

  
}