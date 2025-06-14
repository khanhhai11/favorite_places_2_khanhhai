import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_place.dart';
class PlaceList extends StatelessWidget {
  const PlaceList({super.key, required this.places});
  final List<UserPlace> places;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(places[index].fileImage),
            ),
            title: Text(
              places[index].placeName,
              style: GoogleFonts.ubuntuCondensed(
                fontSize: 16,
                color: const Color(0xFFDED9E1),
              ),
            ),
            subtitle: Text(
              places[index].placeLocation.address,
              style: TextStyle(
                color: const Color(0xFFDED9E1),
              ),
            ),
          ),
        );
      },
    );
  }
}
