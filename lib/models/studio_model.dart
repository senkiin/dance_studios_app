import 'package:google_maps_flutter/google_maps_flutter.dart';

class Studio {
  final String name;
  final String address;
  final String description;
  final List<String> styles;
  final LatLng location;

  Studio({
    required this.name,
    required this.address,
    required this.description,
    required this.styles,
    required this.location,
  });

  // Factory constructor to create a Studio from Firestore data
  factory Studio.fromFirestore(Map<String, dynamic> data) {
    return Studio(
      name: data['name'],
      address: data['address'],
      description: data['description'],
      styles: List<String>.from(data['styles']),
      location: LatLng(data['latitude'], data['longitude']),
    );
  }
}
