import 'package:Decon/Models/Consts/database_calls.dart';
import 'package:Decon/Models/Models.dart';

class DialogVM{
  static DialogVM instance = DialogVM._();
  DialogVM._();
  DatabaseCallServices _databaseCallServices = DatabaseCallServices();
  
}