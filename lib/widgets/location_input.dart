import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class LocationInput {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('code -1, Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('code -1, Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'code -2, Location permissions are permanently denied.'
      );
    }
    return await Geolocator.getCurrentPosition();
  }
}