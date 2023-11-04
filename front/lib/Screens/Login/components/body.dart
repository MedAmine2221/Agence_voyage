import 'dart:math';
import 'package:agence_voyage_app/Screens/Profil/components/background2.dart';
import 'package:agence_voyage_app/Screens/Register/register.dart';
import 'package:agence_voyage_app/Screens/acceuil/acceuil.dart';
import 'package:agence_voyage_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http; // Import the HTTP package
import 'dart:convert'; // Import the convert package
import 'package:agence_voyage_app/Screens/Login/components/background.dart';
import 'package:agence_voyage_app/components/Or_divider.dart';
import 'package:agence_voyage_app/components/already_have_an_account.dart';
import 'package:agence_voyage_app/components/rounded_button.dart';
import 'package:agence_voyage_app/components/rounded_cin_field.dart';
import 'package:agence_voyage_app/components/rounded_input_field.dart';
import 'package:agence_voyage_app/components/rounded_password_field.dart';
import 'package:get/get.dart';
import '../../../api/google_signIn_api.dart';
import 'package:agence_voyage_app/components/menu_profil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String password = "";
  String email = "";
  String emailval = "";
  String nom = "";
  String prenom = "";
  int age = 0;
  String genre = "";
  String cin = "";
  String cinval = "";
  String passeport = "";
  String passeportval = "";
  String image = "";
  String tel = "";
  int id = 0;

  // Store the entered password
  void _showAlertFailed(BuildContext context) {
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
              Text('Password reset successful',style: TextStyle(fontWeight: FontWeight.bold),),
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
  void _showAlertFailedAcess(BuildContext context) {
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
              Text('Connection Failed',style: TextStyle(fontWeight: FontWeight.bold),),
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
  void login() async {
    final String apiUrl = 'http://192.168.43.204:7229/api/Utilisateurs/login'; // Remplacez par l'URL de votre API

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'Email': email, // Utilisez la valeur de l'email que l'utilisateur a saisi
        'Password': password, // Utilisez la valeur du mot de passe que l'utilisateur a saisi
      }),
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      // Authentification réussie
      final userResponse = json.decode(response.body);
      int age = userResponse['age'];
      int id = userResponse['id'] ;
      String nom = userResponse['nom'];
      String prenom = userResponse['prenom'] ;
      String genre = userResponse['genre'] ;
      String email = userResponse['email'] ;
      String cin = userResponse['cin'] ;
      String passeport = userResponse['num_passeport'] ;
      String image = userResponse['image'] ;
      String tel = userResponse['num_tel'];
      Get.to(() => Acceuil(),arguments: {
        'age': age,
        'nom': nom,
        'prenom': prenom,
        'id':id,
        'genre': genre,
        'email': email,
        'cin': cin,
        'passeport':passeport,
        'image': image,
        'tel': tel,
        'password': password,
        // Ajoutez d'autres variables ici si nécessaire
      });

    } else {
      // Affichez un message d'erreur en cas d'échec de l'authentification
      _showAlertFailedAcess(context);
    }
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
              ClipRRect(
                borderRadius: BorderRadius.circular(50), // Ajustez le rayon du coin arrondi selon vos préférences
                child: Image.asset(
                  "assets/images/logo.png",
                  height: size.height * 0.4,
                  fit: BoxFit.cover, // Assurez-vous que l'image s'adapte correctement au coin arrondi
                ),
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
              GestureDetector(
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Background2(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Reset Password',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40.0),
                              ),
                              Image.asset(
                                'assets/images/reset.png', // Remplacez par le chemin de votre image
                                width: 50, // Ajustez la largeur de l'image selon vos besoins
                                height: 50 // Ajustez la hauteur de l'image selon vos besoins
                              ),
                              RoundedInputField(
                                hintText: "Your Email",
                                onChanged: (value) {
                                  setState(() {
                                    emailval = value;
                                  });
                                },
                              ),
                              RoundedCinField(
                                hintText: "Your CIN Number",
                                onChanged: (value) {
                                  setState(() {
                                    cinval = value;
                                  });
                                },
                              ),
                              RoundedCinField(
                                hintText: "Your Passeport Number",
                                onChanged: (value) {
                                  setState(() {
                                    passeportval = value;
                                  });
                                },
                              ),
                              RoundedButton(
                                text: "Reset Password",
                                press: () async {
                                  final String apiUrl =
                                      'http://192.168.139.26:7229/api/Utilisateurs/forgot_password/${emailval}/${passeportval}/${cinval}';

                                  var response = await http.get(Uri.parse(apiUrl));
                                  if (response.statusCode == 200) {
                                    // Réinitialisation de mot de passe réussie
                                    _showAlertFailed(context);
                                  }
                                  },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    color: kPrimaryLightBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              RoundedButton(
                text: "SIGNIN",
                press: () {
                  login();
                },
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              AlreadyHaveAnAccount(
                login: true,
                press: () => Get.to(RegisterScreen()),
              ),
              OrDivider(),
              Image.asset(
                'assets/images/google.png',
                width: 60, // Ajustez la largeur selon vos besoins
                height: 60, // Ajustez la hauteur selon vos besoins
              ),
            ],
          ),
        ),
      ),
    );
  }
}

