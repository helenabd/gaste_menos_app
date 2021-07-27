import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gaste_menos_app/ui/screens/home/home_screen.dart';

import 'ui/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gaste Menos',
      theme: gasteMenosTheme(),
      // home: HomeScreen(),
      home: HomeScreen(),
    );
  }
}
