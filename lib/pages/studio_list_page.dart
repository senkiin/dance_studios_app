import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/studio_model.dart';
import 'studio_info_page.dart';
import 'studio_map_page.dart';

class StudioListPage extends StatefulWidget {
  @override
  _StudioListPageState createState() => _StudioListPageState();
}

class _StudioListPageState extends State<StudioListPage> {
  List<Studio> studios = [];
  List<Studio> filteredStudios = [];
  String searchQuery = '';
  String selectedStyle = 'All';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudios();
  }

  Future<void> fetchStudios() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('studios').get();

      final List<Studio> loadedStudios = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Studio.fromFirestore(data);
      }).toList();

      setState(() {
        studios = loadedStudios;
        filteredStudios = studios;
        isLoading = false;
      });
    } catch (e) {
      print("❌ Error al cargar estudios: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterStudios() {
    setState(() {
      filteredStudios = studios.where((studio) {
        final matchesSearch =
            studio.name.toLowerCase().contains(searchQuery.toLowerCase());
        final matchesStyle =
            selectedStyle == 'All' || studio.styles.contains(selectedStyle);
        return matchesSearch && matchesStyle;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dance Studios'),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudioMapPage(studios: filteredStudios),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Buscar por nombre',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      filterStudios();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedStyle,
                    items: ['All', 'Ballet', 'Hip-Hop', 'Salsa', 'Contemporary']
                        .map((style) => DropdownMenuItem(
                              value: style,
                              child: Text(style),
                            ))
                        .toList(),
                    onChanged: (value) {
                      selectedStyle = value!;
                      filterStudios();
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredStudios.length,
                    itemBuilder: (context, index) {
                      final studio = filteredStudios[index];
                      return ListTile(
                        title: Text(studio.name),
                        subtitle: Text(studio.address),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StudioInfoPage(studio: studio),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
