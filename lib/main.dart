import 'package:favorite_places_2/providers/user_places.dart';
import 'package:favorite_places_2/screens/places_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
void main () {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserPlacesProvider(),
      child: FavouritePlaces(),
    )
  );
}
class FavouritePlaces extends StatelessWidget {
  const FavouritePlaces({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlacesScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E2A35)),
        scaffoldBackgroundColor: const Color(0xFF2E2A35),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF141218),
          iconTheme: IconThemeData(color: const Color(0xFFDED9E1)),
          titleTextStyle: GoogleFonts.ubuntuCondensed(
            color: const Color(0xFFDED9E1),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        textTheme: GoogleFonts.ubuntuCondensedTextTheme().apply(
          bodyColor: const Color(0xFFDED9E1),
          displayColor: const Color(0xFFDED9E1),
        ),
      ),
    );
  }
}
