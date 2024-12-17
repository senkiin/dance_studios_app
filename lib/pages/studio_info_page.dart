import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/studio_model.dart';

class StudioInfoPage extends StatelessWidget {
  final Studio studio;

  StudioInfoPage({required this.studio});

  void _showBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Confirmar Reserva"),
        content: Text("¿Quieres reservar ahora en '${studio.name}'?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Reserva confirmada en '${studio.name}'")),
              );
            },
            child: Text("Reservar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(studio.name),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  studio.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  studio.address,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 16),
                Text(
                  studio.description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _showBookingDialog(context),
                    child: Text("Reservar Ahora"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: studio.location,
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: MarkerId(studio.name),
                  position: studio.location,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
