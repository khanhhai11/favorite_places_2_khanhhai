import 'package:favorite_places_2/data/places_data.dart';
import 'package:favorite_places_2/providers/user_places.dart';
import 'package:favorite_places_2/widgets/place_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_place_screen.dart';
class PlacesScreen extends StatefulWidget {
  const PlacesScreen ({super.key});
  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}
class _PlacesScreenState extends State<PlacesScreen> {
  @override
  void initState(){
    super.initState();
    _loadPlaces();
  }
  void _loadPlaces() async {
    await Provider.of<UserPlacesProvider>(context, listen: false).getAllPlaces();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E2A35),
      appBar: AppBar(
        title: Text(
          'Your Places',
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => AddPlaceScreen()
              ));
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: PlaceList(places: Provider.of<UserPlacesProvider>(context, listen: false).userPlaces),
    );
  }
}
