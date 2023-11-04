
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importez le package Get
import 'package:agence_voyage_app/Screens/Profil/components/body.dart';

class ProfileScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      int age = arguments?['age'] ?? 0;
      String nom = arguments?['nom'] ?? '';
      String prenom = arguments?['prenom'] ?? '';
      String genre = arguments?['genre'] ?? '';
      String email = arguments?['email'] ?? '';
      String cin = arguments?['cin'] ?? "";
      String passeport = arguments?['passeport'] ?? '';
      String image = arguments?['image'] ?? '';
      String tel = arguments?['tel'] ?? '';
      String password = arguments?['password'] ?? '';
      int id = arguments?['id'] ?? '';

      Size size = MediaQuery.of(context).size;

      return Scaffold(
        body: Body(
          email: email,
          nom: nom,
          prenom: prenom,
          cin: cin,
          image: image,
          id: id,
          genre: genre,
          passeport: passeport,
          age: age,
          tel: tel,
          password: password,
        ),
      );
    } else {
      // Handle the case where Get.arguments is null
      // You can display an error message or navigate to a different page.
      return Container();
    }
  }
}
