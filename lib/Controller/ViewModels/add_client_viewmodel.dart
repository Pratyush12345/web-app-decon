import 'package:Decon/Models/Consts/database_calls.dart';

class AddClientVM {
  static AddClientVM instance = AddClientVM._();
  AddClientVM._();
  DatabaseCallServices _databaseCallServices = DatabaseCallServices();
  String seriesValue;
  List<String> seriesList;

  getSeriesList() async{
     try{
      String series =  await _databaseCallServices.getSeriesList();
      if(series != null)
      seriesList = series?.split(",");
      else
      seriesList = [];
     }
     catch(e){
       print(e);
     }
  }
}