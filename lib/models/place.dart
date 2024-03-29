
import 'dart:io';
import 'package:flutter/foundation.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });

}
class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;
  final String description;
  final String price;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
    this.description,
    @required this.price,
  });
}