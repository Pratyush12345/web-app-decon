import 'package:geocoder/geocoder.dart';

class AddressCalculator{
  double latitude,longitude;
  AddressCalculator(this.latitude,this.longitude);
  Future<String> getLocation() async {
    final coordinates = new Coordinates(latitude, longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return first.addressLine.toString();
    //print("${first.featureName} : ${first.addressLine} :${first.adminArea}");
  }
}