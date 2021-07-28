import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gaste_menos_app/services/services.dart';
import 'package:provider/provider.dart';

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
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Gaste Menos',
        theme: gasteMenosTheme(),
        // home: HomeScreen(),
        home: LandingScreen(),
      ),
    );
  }
}
