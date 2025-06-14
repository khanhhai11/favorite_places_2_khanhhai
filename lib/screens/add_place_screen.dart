import 'package:dotted_border/dotted_border.dart';
import 'package:favorite_places_2/models/place_location.dart';
import 'package:favorite_places_2/screens/map_screen.dart';
import 'package:favorite_places_2/widgets/OSMap.dart';
import 'package:favorite_places_2/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../providers/user_places.dart';
import '../widgets/image_input.dart';
class AddPlaceScreen extends StatefulWidget {
  AddPlaceScreen({super.key});
  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}
class _AddPlaceScreenState extends State<AddPlaceScreen> {
  String title = '';
  late LatLng userLatLng;
  bool _isLocationPicked = false;
  Widget mapContent = Text('No location chosen');
  LocationInput locationInput = LocationInput();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Place',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Color(0xFFDED9E1)),
              ),
              onChanged: (value) => title = value,
            ),
            SizedBox(height: 8),
            ImageInput(),
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: DottedBorder(
                color: Color(0xFFDED9E1),
                strokeWidth: 2,
                borderType: BorderType.RRect,
                radius: Radius.circular(8),
                child: Container(
                  child: mapContent,
                  height: 100,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    await _getCurrentLocation();
                    setState(() {
                      mapContent = OSMap(
                        initialLocation: PlaceLocation(
                            latitude: userLatLng.latitude,
                            longitude: userLatLng.longitude
                        ),
                        getUserSelectedLocation: (LatLng){},
                        isControllable: false,
                      );
                      Future.delayed(Duration(seconds: 1));
                    });
                  },
                  icon: Icon(Icons.location_on),
                  label: Text('Get Current Location', style: TextStyle(color: Color(0xFFB7A7E7))),
                ),
                TextButton.icon(
                  onPressed: () async {
                    if (_isLocationPicked == false) {
                      await _getCurrentLocation();
                    }
                    LatLng? tempLatLng = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapScreen(
                              placeLocation: PlaceLocation(
                                latitude: userLatLng.latitude,
                                longitude: userLatLng.longitude,
                              ),
                            )
                        )
                    );
                    if (tempLatLng != null){
                      setState(() {
                        userLatLng = tempLatLng;
                        mapContent = OSMap(
                          initialLocation: PlaceLocation(
                              latitude: userLatLng.latitude,
                              longitude: userLatLng.longitude
                          ),
                          getUserSelectedLocation: (LatLng){},
                          isControllable: false,
                        );
                      });
                    }
                  },
                  icon: Icon(Icons.map),
                  label: Text('Select on Map', style: TextStyle(color: Color(0xFFB7A7E7))),
                ),
              ],
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: (){
                if (title.isEmpty){
                  // TODO: Check if any in4 is missing -> show snackbar
                } else {
                  // Provider.of<UserPlacesProvider>(context, listen: false).insertPlace(
                  //   // TODO: Database
                  // );
                  Navigator.pop(context);
                }
              },
              icon: Icon(Icons.add, color: Color(0xFFB7A7E7)),
              label: Text('Add Place', style: TextStyle(color: Color(0xFFB7A7E7))),
            ),
          ],
        ),
      ),
    );
  }
  void _showSnackBar(String e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
  }
  void _showSnackBarWithAction(String e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
        action: SnackBarAction(
            label: 'Open Settings',
            onPressed: () => Geolocator.openLocationSettings()),
        actionOverflowThreshold: 0.5,
      ),
    );
  }
  Future<void> _getCurrentLocation () async {
    try {
      Position position = await locationInput.determinePosition();
      userLatLng = LatLng(position.latitude, position.longitude);
      _isLocationPicked = true;
    } catch (e) {
      if (e.toString().contains('-1')) {
        _showSnackBar(e.toString().substring(9));
      }
      if (e.toString().contains('-2')) {
        _showSnackBarWithAction(e.toString().substring(9));
      }
    }
  }
}