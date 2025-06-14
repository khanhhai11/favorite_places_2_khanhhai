import 'package:favorite_places_2/models/place_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
class OSMap extends StatefulWidget {
  const OSMap({super.key, required this.initialLocation, required this.getUserSelectedLocation, required this.isControllable});
  final PlaceLocation initialLocation;
  final void Function(LatLng) getUserSelectedLocation;
  final bool isControllable;
  @override
  State<OSMap> createState() => _OSMapState();
}
class _OSMapState extends State<OSMap> {
  static const String tileUrlTemplate = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String userAgent = 'com.example.native_feature';
  bool _isReady = false;
  late LatLng _currentLatLng;
  final MapController _mapController = MapController();
  Marker _buildMarker() {
    return Marker(
      point: _currentLatLng,
      child: Icon(
        Icons.location_pin,
        size: 40,
        color: Theme.of(context).primaryColor,
      ),
      alignment: Alignment.topCenter,
    );
  }
  @override
  void initState() {
    super.initState();
    _currentLatLng = LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude);
  }
  @override
  void didUpdateWidget(OSMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialLocation != oldWidget.initialLocation){
      setState(() {
        _currentLatLng = LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude);
      });
      if (_isReady){
        _mapController.move(_currentLatLng, 12);
        // TODO: Fix mapcontroller bug
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      children: [
        TileLayer(
          urlTemplate: tileUrlTemplate,
          userAgentPackageName: userAgent,
        ),
        MarkerLayer(markers: [_buildMarker()]),
      ],
      options: MapOptions(
        interactionOptions: InteractionOptions(
          flags: widget.isControllable? InteractiveFlag.all: InteractiveFlag.none,
        ),
        onMapReady: () {
          setState(() {
            _isReady = true;
          });
        },
        initialCenter: _currentLatLng,
        initialZoom: 11,
        onTap: (tapPosition, latLng) {
          setState(() {
            if (widget.isControllable == true){
              _currentLatLng = latLng;
              widget.getUserSelectedLocation(_currentLatLng);
            }
          });
        }
      ),
    );
  }
}
