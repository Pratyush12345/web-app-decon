import 'package:Decon/DeconManager/AddCity.dart';
import 'package:Decon/DeconManager/DelegatePost.dart';
import 'package:Decon/Models/Models.dart';
import 'package:Decon/Services/Auth.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add City"),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Auth.instance.signOut();
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddCity(
                  cityLength: _citiesMap.length,
                )));
      }),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<Event>(
                stream: FirebaseDatabase.instance.reference().child("citiesList").onValue,  
                builder:(context, snapshot){
                  if(snapshot.hasData){
                    
                  _citiesMap = snapshot.data.snapshot.value;
                  return ListView.builder(
                itemCount: _citiesMap.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Text("${index + 1}"),
                      title: Text(_citiesMap["C${index + 1}"]),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DelegatePost(
                                  cityCode: index+1,
                                  cityName: _citiesMap["C${index + 1}"],
                                )));
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
