import 'package:Decon/DeconManager/AddCity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CitiesList extends StatefulWidget {
  @override
  _CitiesListState createState() => _CitiesListState();
}

class _CitiesListState extends State<CitiesList> {
  final dbRef = FirebaseDatabase.instance;
  Map _citiesMap;
  @override
  void initState() {
    super.initState();
  }
 Future showCityDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return  AddCity(
                  cityLength: _citiesMap.length,
                );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add City"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xff0099FF),
        onPressed: () {
        showCityDialog(context);
      }),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<Event>(
                stream: FirebaseDatabase.instance.reference().child("citiesList").onValue,  
                builder:(context, snapshot){
                  if(snapshot.hasData){
                    
                  _citiesMap = snapshot.data.snapshot.value;
                  
                  print(_citiesMap);
                  return ListView.builder(
                itemCount: _citiesMap.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Text("$index"),
                      title: Text(_citiesMap["C$index"]),
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => DelegatePost(
                        //           cityCode: index,
                        //           cityName: _citiesMap["C$index"],
                        //         )));
                      },
                    ),
                  );
                });
                  }
                  else {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                }
                }
          )
          ),
    );
  }
}
