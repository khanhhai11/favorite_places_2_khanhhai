import 'package:favorite_places_2/widgets/OSMap.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../models/place_location.dart';
class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.placeLocation});
  final PlaceLocation placeLocation;
  @override
  State<MapScreen> createState() => _MapScreenState();
}
class _MapScreenState extends State<MapScreen> {
  LatLng? userSelectedLocation;
  void _updateSelectedLocation(LatLng location){
    setState(() {
      userSelectedLocation = location;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick your location'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pop(context, userSelectedLocation);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: OSMap(initialLocation: widget.placeLocation, getUserSelectedLocation: _updateSelectedLocation, isControllable: true),
    );
  }
}
