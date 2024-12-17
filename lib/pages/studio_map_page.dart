import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/studio_model.dart';
import 'studio_info_page.dart';

class StudioMapPage extends StatelessWidget {
  final List<Studio> studios;

  StudioMapPage({required this.studios});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dance Studios Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194),
          zoom: 10,
        ),
        markers: studios
            .map(
              (studio) => Marker(
                markerId: MarkerId(studio.name),
                position: studio.location,
                infoWindow: InfoWindow(
                  title: studio.name,
                  snippet: studio.address,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudioInfoPage(studio: studio),
                    ),
                  );
                },
              ),
            )
            .toSet(),
      ),
    );
  }
}
