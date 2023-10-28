import 'package:flutter/material.dart';
import 'screens/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"Medical Remainder App",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}