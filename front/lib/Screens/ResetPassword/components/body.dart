import 'package:agence_voyage_app/components/rounded_age_field.dart';
import 'package:agence_voyage_app/components/rounded_gender_field.dart';
import 'package:agence_voyage_app/components/rounded_tel_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:agence_voyage_app/Screens/Login/login_screen.dart';
import 'dart:convert';
import 'dart:io';
import 'package:agence_voyage_app/Screens/Register/components/background.dart';
import 'package:agence_voyage_app/components/already_have_an_account.dart';
import 'package:agence_voyage_app/components/rounded_button.dart';
import 'package:agence_voyage_app/components/rounded_cin_field.dart';
import 'package:agence_voyage_app/components/rounded_field.dart';
import 'package:agence_voyage_app/components/rounded_input_field.dart';
import 'package:agence_voyage_app/components/rounded_password_field.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email = ''; // Store the entered email
  String password = '';
  String newpasseword = "";
  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/verif.png', // Remplacez par le chemin de votre image
                width: 100, // Ajustez la largeur de l'image selon vos besoins
                height: 100, // Ajustez la hauteur de l'image selon vos besoins
              ),
              SizedBox(height: 10),
              Text('Password Reset successful',style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
          actions: [
            RoundedButton(
              text:'Close',
              press: () {
                Navigator.of(context).pop(); // Ferme l'alerte
              },
            ),
          ],
        );
      },
    );
  }

  void _showAlertFailed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/wrong.png', // Remplacez par le chemin de votre image
                width: 100, // Ajustez la largeur de l'image selon vos besoins
                height: 100, // Ajustez la hauteur de l'image selon vos besoins
              ),
              SizedBox(height: 10),
              Text('Password or email invalid',style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
          actions: [
            RoundedButton(
              text:'Close',
              press: () {
                Navigator.of(context).pop(); // Ferme l'alerte
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Change Password',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40.0),
              ),
              Image.asset(
                  'assets/images/reset.png', // Remplacez par le chemin de votre image
                  width: 80, // Ajustez la largeur de l'image selon vos besoins
                  height: 80 // Ajustez la hauteur de l'image selon vos besoins
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                hintText: "Password",
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  setState(() {
                    newpasseword = value;
                  });
                },
                hintText: "New Password",
              ),
              RoundedButton(
                text: "Valide",
                press: () async {
                  final String apiUrl =
                      'http://192.168.43.204:7229/api/Utilisateurs/modify_password/${email}/${password}/${newpasseword}';
                  var response = await http.get(Uri.parse(apiUrl));
                  if (response.body == 'Mot de passe modifié avec succès') {
                    // Réinitialisation de mot de passe réussie
                    _showAlert(context);
                  }else{
                    _showAlertFailed(context);
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
