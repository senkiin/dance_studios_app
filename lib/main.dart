import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/studio_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB44eRFZUmdmKi95xzoXqgGKgE7cAAL1yg",
      authDomain: "dancestudiosapp.firebaseapp.com",
      projectId: "dancestudiosapp",
      storageBucket: "dancestudiosapp.appspot.com",
      messagingSenderId: "720581941877",
      appId: "1:720581941877:web:d68078b33871e75305b63c",
      measurementId: "G-9XNHLJX0P8",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dance Studios',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StudioListPage(),
    );
  }
}
