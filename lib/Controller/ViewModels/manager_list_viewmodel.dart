import 'package:Decon/Models/Models.dart';

class ManagerListVM {
   static ManagerListVM instance = ManagerListVM._();
  ManagerListVM._();
  bool isManagerSearched = false;
  List<UserDetailModel> _dupListManager ;

  List<UserDetailModel> onSearchManager(String val ){
     List<UserDetailModel> list = [];
     if(val.isNotEmpty){
       List<UserDetailModel> _searchedList = [];
       _searchedList = _dupListManager.where((element) => element.name.contains(val) ||element.phoneNo.contains(val) ).toList();
       list.addAll(_searchedList);
       isManagerSearched = true;
       return list;
       }
      else{
        isManagerSearched = false;
        list  = List.from(_dupListManager);
        return list;
      }
  }
  
  set setManagerList(List<UserDetailModel> _list){
    _dupListManager = _list;
  }
 
}