import 'package:agence_voyage_app/Screens/acceuil/acceuil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importez le package Get
import 'package:agence_voyage_app/Screens/Login/login_screen.dart';
import 'package:agence_voyage_app/constants.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Utilisez GetMaterialApp au lieu de MaterialApp
      debugShowCheckedModeBanner: false,
      title: 'AGENCE DE VOYAGE',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home:  LoginScreen(),
    );
  }
}