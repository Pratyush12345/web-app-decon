//import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:reverse_nominatim/nominatim_client.dart';
// import 'package:reverse_nominatim/model/revgeocode_request/revgeocode_request.dart';
class AddressCalculator{
  double latitude,longitude;
  AddressCalculator(this.latitude,this.longitude);
  Future<String> getLocation() async {
    
    // final client = NominatimClient();
    // final result = await client.makeRevgeocodeRequest(
    //   RevgeocodeRequest(
    //     lat: latitude,
    //     lon: longitude,
    //     zoom: 18,
    //     addressDetails: true,
    //     language: 'en',
    //   ),
    // );
    // print(result.toJson());
    // if(result.toJson()["features"] != null ){
    // var first = result.toJson()["features"][0]["properties"]["geocoding"];
    // String housno = first["housenumber"];
    // housno = housno == null ? "" : housno+",";
    // String street = first["street"];
    // street = street == null ? "" : street+",";
    // String locality = first["locality"];
    // locality = locality == null ? "" : locality+",";
    // String postCode = first["postcode"];
    // postCode = postCode == null ? "" : postCode+",";
    // String city= first["city"];
    // city = city ==  null ? "" : city+",";
    // String district = first["district"];
    // district = district == null ? "" : district+",";
    // String state = first["state"];
    // state = state == null ? "" : state+",";
    // String county = first["county"];
    // county = county == null ? "" : county+",";
    // String country = first["country"];

    // String address = "${housno} ${street} ${locality} ${postCode} ${city} ${district} ${county} ${state} ${country}";
    // //return first.addressLine.toString();
    // return address;
    // }
    return "Error in getting address";
    //print("${first.featureName} : ${first.addressLine} :${first.adminArea}");
  }
}