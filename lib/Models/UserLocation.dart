import 'dart:async';

import 'package:geolocator/geolocator.dart';

class UserLocation {
  Position currentLocation;
  double lat;
  double long;
  timeOutPrinter() {
    return {'Err_Flag': true, 'Err_Desc': 'Server Timeout!'};
  }

  Future<Position> locateUser() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .timeout(Duration(seconds: 10));
      return position;
    } on TimeoutException {
      print('thing time exception');
      return null;
    } catch (e) {
      print('thing $e');
      return null;
    }
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    print('thing $currentLocation');
    if (currentLocation == null) return null;
    lat = currentLocation.latitude;
    long = currentLocation.longitude;
    return true;
  }

  List<double> getLatLng() {
    return [lat, long];
  }

  Future<bool> isLocationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
}
