import 'dart:io';
import 'package:favorite_places_2/models/place_location.dart';
import 'package:favorite_places_2/models/user_place.dart';
import 'package:flutter/cupertino.dart';
final List<UserPlace> PlacesData = [
  UserPlace(
    placeName: 'Googleplex',
    placeLocation: PlaceLocation(
      latitude: 37.4220,
      longitude: -122.0841,
      address: '1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA',
    ),
    fileImage: File('assets/images/googleplex_image.jpg'),
  ),
  UserPlace(
    placeName: 'Eiffel Tower',
    placeLocation: PlaceLocation(
      latitude: 48.8584,
      longitude: 2.2945,
      address: 'Champ de Mars, 5 Av. Anatole France, 75007 Paris, France',
    ),
    fileImage: File('assets/images/eiffel_tower_image.jpg'),
  ),
  UserPlace(
    placeName: 'Sydney Opera House',
    placeLocation: PlaceLocation(
      latitude: -33.8568,
      longitude: 151.2153,
      address: 'Bennelong Point, Sydney NSW 2000, Australia',
    ),
    fileImage: File('assets/images/opera_sydney_house_image.jpg'),
  ),
  UserPlace(
    placeName: 'Grand Canyon National Park',
    placeLocation: PlaceLocation(
      latitude: 36.1069,
      longitude: -112.1129,
      address:  'Grand Canyon Village, AZ 86023, USA',
    ),
    fileImage: File('assets/images/grand_canyon_village_image.jpg'),
  ),
  UserPlace(
    placeName: 'Machu Picchu',
    placeLocation: PlaceLocation(
      latitude: -13.1631,
      longitude: -72.5450,
      address: 'Machu Picchu Archaeological Park, Aguas Calientes, Peru',
    ),
    fileImage: File('assets/images/machu_picchu_image.jpg'),
  ),
];