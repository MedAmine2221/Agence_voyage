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
  String cin = '';
  String nom = '';
  String prenom = '';
  int? age;
  String passe = "";
  String tel = "";
  String selectedGender = "Male"; // Ajoutez cette ligne
  List<String> genderOptions = ["Male", "Female"]; // Ajoutez cette ligne
  String SelectedImagePath = '';
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
              Text('Registration successful',style: TextStyle(fontWeight: FontWeight.bold),),
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
              Text('Registration failed',style: TextStyle(fontWeight: FontWeight.bold),),
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

/*  Future<void> registerUser() async {
    final url = 'http://192.168.1.13:7229/api/Utilisateurs/register';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Nom':nom,
        'Prenom':prenom,
        'Age':age,
        'Genre':selectedGender,
        'Image':SelectedImagePath,
        'Cin':cin,
        'Num_passeport':"passe",
        'Email': email,
        'Password': password,
        'Num_tel':tel,
      }),
    );
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    print('jsonResponse');
    print(passe);
    print(jsonResponse);

    if (jsonResponse.isNotEmpty) {
      // La réponse contient des données, affichez l'alerte
      _showAlert(context);
    }else{
      _showAlertFailed(context);
    }
  }*/

  Future<void> registerUser() async {
    final url = 'http://192.168.139.26:7229/api/Utilisateurs/register';
    final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Nom': nom,
          'Prenom': prenom,
          'Age': age,
          'Genre': selectedGender,
          'Image': SelectedImagePath,
          'Cin': cin,
          'Num_passeport': passe,
          'Email': email,
          'Password': password,
          'Num_tel': tel,
        }),
    );
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print('jsonResponse');
    print(passe);
    print(jsonResponse);

    if (jsonResponse.containsKey('errors')) {
      // La réponse contient des erreurs de validation, affichez _showAlertFailed
      _showAlertFailed(context);
    } else {
      // La réponse ne contient pas d'erreurs, affichez _showAlert
      _showAlert(context);
    }
  }
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null){
      return file.path;
    }else{
      return '';
    }
  }
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null){
      return file.path;
    }else{
      return '';
    }
  }

  Future selectImage(){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      'Select Image From !',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              SelectedImagePath = await selectImageFromGallery();
                              print('Image_path:-');
                              print(SelectedImagePath);
                              if (SelectedImagePath != ''){
                                Navigator.pop(context);
                                setState(() {

                                });
                              }else{
                                showSnackBar("No Image Selected !");
                              }
                            },
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/gallery.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text("Gallery"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              SelectedImagePath = await selectImageFromCamera();
                              print("Image_path:-");
                              print(SelectedImagePath);
                              if (SelectedImagePath != ''){
                                Navigator.pop(context);
                                setState(() {

                                });
                              }else{
                                showSnackBar("No Image Captured !");
                              }
                            },
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/camera.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text("camera"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
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

              ClipRRect(
                borderRadius: BorderRadius.circular(10), // Ajustez le rayon du coin arrondi selon vos préférences
                child: Image.asset(
                  "assets/images/logo.png",
                  height: size.height * 0.4,
                  fit: BoxFit.cover, // Assurez-vous que l'image s'adapte correctement au coin arrondi
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              SelectedImagePath == ''
                  ? Image.asset('assets/images/image_placeholder.png',height: 200,width: 200,fit: BoxFit.cover,)
                  :Image.file(File(SelectedImagePath), height:200, width:200,fit:BoxFit.fill,),
              SizedBox(height: 20.0,),
              RoundedButton(
                text: "Select Picture",
                  press: () async {
                    selectImage();
                    setState(() {

                    });
                  }
              ),
              RoundedField(
                hintText: "Your First Name",
                onChanged: (value) {
                  setState(() {
                    prenom = value;
                  });
                },
              ),
              RoundedField(
                hintText: "Your Last Name",
                onChanged: (value) {
                  setState(() {
                    nom = value;
                  });
                },
              ),
              RoundedAgeField(
                hintText: "Your age",
                onChanged: (value) {
                  int? parsedAge = int.tryParse(value);
                  setState(() {
                    age = parsedAge;
                  });
                },
              ),

              RoundedGenderField(
                hintText: "Your Gender",
                selectedGender: selectedGender,
                onChanged: (value) {
                  if (value != null && genderOptions.contains(value)) {
                    setState(() {
                      selectedGender = value;
                    });
                  }
                },
              ),
              RoundedCinField(
                hintText: "Your CIN",
                onChanged: (value) {
                  setState(() {
                    cin = value;
                  });
                },
              ),
              RoundedCinField(
                hintText: "Your passeport number",
                onChanged: (value) {
                  setState(() {
                    passe = value;
                  });
                },
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
              RoundeTelField(
                onChanged: (value) {
                  setState(() {
                    tel = value;
                  });
                },
                hintText: "Phone Number",
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () {
                  registerUser(); // Call the registration function
                },
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              AlreadyHaveAnAccount(
                login: false,
                press: () => Get.to(LoginScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
