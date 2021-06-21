import 'package:Decon/Controller/Utils/sizeConfig.dart';
import 'package:Decon/Models/Consts/app_constants.dart';
import 'package:flutter/material.dart';
class LoadSVG extends StatefulWidget {
  const LoadSVG({ Key key }) : super(key: key);

  @override
  _LoadSVGState createState() => _LoadSVGState();
}

class _LoadSVGState extends State<LoadSVG> {
  List<String> list;
  List<String> dupList;
  final search = TextEditingController();
  
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
       print(list);
       print(_searchedList);
       print(dupList);
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              sh(27),
              Container(
                alignment: Alignment.center,
                width: b * 340,
                decoration: BoxDecoration(
                  border: Border.all(color: dc, width: 0.5),
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(b * 60),
                ),
                child: TextField(
                  onChanged: (val){
                    onSearch(val);
                  },
                  controller: search,
                  style: TextStyle(fontSize: b * 14, color: dc),
                  decoration: InputDecoration(
                    prefixIcon: InkWell(
                      child: Icon(Icons.search, color: Colors.black),
                      onTap: null,
                    ),
                    isDense: true,
                    isCollapsed: true,
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 40, maxHeight: 24),
                    hintText: 'Search by Name',
                    hintStyle: TextStyle(
                      fontSize: b * 14,
                      color: Color(0xff858585),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: h * 12, horizontal: b * 13),
                    border: InputBorder.none,
                  ),
                ),
              ),
             
              Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: ListTile(
                        title: Text("${list[index]}"),
                      ),
                    );
                  }),
              ),
            ],
          ),
        ) ,
      )
      );
     }
}