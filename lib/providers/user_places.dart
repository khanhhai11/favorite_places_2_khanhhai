import 'package:favorite_places_2/widgets/database_helper.dart';
import 'package:flutter/material.dart';
import '../models/user_place.dart';
class UserPlacesProvider extends ChangeNotifier {
  final DatabaseHelper db = DatabaseHelper.instance;
  List<UserPlace> userPlaces = [];
  insertPlace(UserPlace userPlace){
    db.insertPlace(userPlace);
    getAllPlaces();
    notifyListeners();
  }
  deletePlace(int id){
    db.deletePlace(id);
    getAllPlaces();
    notifyListeners();
  }
  getAllPlaces() async {
    userPlaces = await db.getAllPlaces();
    notifyListeners();
  }
}