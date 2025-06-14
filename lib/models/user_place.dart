import 'dart:io';
import '../models/place_location.dart';
class UserPlace {
  UserPlace ({
    this.id = -1,
    required this.placeName,
    required this.placeLocation,
    required this.fileImage,
  });
  int id;
  String placeName;
  PlaceLocation placeLocation;
  File fileImage;
  Map<String, dynamic> toMap() {
    return {
      'placeName': placeName,
      'longitude': placeLocation.longitude,
      'latitude': placeLocation.latitude,
      'address': placeLocation.address,
    };
  }
  factory UserPlace.fromMap(Map<String, dynamic> map){
    return UserPlace(
      id: map['id'],
      placeName: map['name'],
      placeLocation: PlaceLocation(
        longitude: map['longitude'],
        latitude: map['latitude'],
        address: map['address'],
      ),
      fileImage: File(map['imagePath']),
    );
  }
}