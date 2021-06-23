import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:Decon/Models/Consts/client_not_found.dart';
import 'package:Decon/View_Android/Dialogs/please_wait_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:rive/rive.dart';
class LoadSVG extends StatefulWidget {
  const LoadSVG({ Key key }) : super(key: key);

  @override
  _LoadSVGState createState() => _LoadSVGState();
}

class _LoadSVGState extends State<LoadSVG> {
  List<String> list;
  List<String> dupList;
  final search = TextEditingController();
  Future showPleaseWaitDialog(BuildContext context) {
    return showAnimatedDialog(
        barrierDismissible: false,
        context: context,  
        animationType: DialogTransitionType.scaleRotate,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),
        builder: (context) {
          return PleaseWait();
        });
  }
  @override
    void initState() {
      list = ["car", "animal", "bike", "race", "not again", "apple"];
      dupList = List.from(list);
      super.initState();
    }
    onSearch(String val){
      if(val.isNotEmpty){
       List<String> _searchedList = [];
       _searchedList = dupList.where((element) => element.contains(val)).toList();
       list.clear();
       list.addAll(_searchedList);
       }
      else{
        list.clear();
        list  = List.from(dupList);
      }
      setState(() {
              
            });
    }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Scaffold(
      appBar: AppBar(title: Text("Load SVG"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        
        width: MediaQuery.of(context).size.width,
        child: ClientsNotFound()
        // child: Column(
        //   children: [
        //     sh(27),
        //     Container(
        //       alignment: Alignment.center,
        //       width: b * 340,
        //       decoration: BoxDecoration(
        //         border: Border.all(color: dc, width: 0.5),
        //         color: Color(0xffffffff),
        //         borderRadius: BorderRadius.circular(b * 60),
        //       ),
        //       child: TextField(
        //         onChanged: (val){
        //           onSearch(val);
        //         },
        //         controller: search,
        //         style: TextStyle(fontSize: b * 14, color: dc),
        //         decoration: InputDecoration(
        //           prefixIcon: InkWell(
        //             child: Icon(Icons.search, color: Colors.black),
        //             onTap: null,
        //           ),
        //           isDense: true,
        //           isCollapsed: true,
        //           prefixIconConstraints:
        //               BoxConstraints(minWidth: 40, maxHeight: 24),
        //           hintText: 'Search by Name',
        //           hintStyle: TextStyle(
        //             fontSize: b * 14,
        //             color: Color(0xff858585),
        //           ),
        //           contentPadding: EdgeInsets.symmetric(
        //               vertical: h * 12, horizontal: b * 13),
        //           border: InputBorder.none,
        //         ),
        //       ),
        //     ),
           
        //     Expanded(
        //       child: ListView.builder(
        //         itemCount: list.length,
        //         itemBuilder: (context, index){
        //           return Card(
        //             child: ListTile(
        //               title: Text("${list[index]}"),
        //             ),
        //           );
        //         }),
        //     ),
        //   ],
        // ),
      )
      );
     }
}