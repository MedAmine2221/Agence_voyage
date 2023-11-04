import 'dart:convert';
import 'dart:io';
import 'package:agence_voyage_app/Screens/Profil/components/background2.dart';
import 'package:agence_voyage_app/Screens/ResetPassword/resetpass.dart';
import 'package:agence_voyage_app/components/menu_dropdown.dart';
import 'package:agence_voyage_app/components/rounded_button.dart';
import 'package:agence_voyage_app/components/user_screen.dart';
import 'package:http/http.dart' as http;
import 'package:agence_voyage_app/Screens/Login/login_screen.dart';
import 'package:agence_voyage_app/Screens/Profil/profil.dart';
import 'package:agence_voyage_app/Screens/acceuil/acceuil.dart';
import 'package:agence_voyage_app/components/menu_profil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:agence_voyage_app/Screens/Profil/components/background.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'dart:async';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  String email;
  String nom;
  String prenom;
  String cin;
  String image;
  String genre;
  String tel;
  String passeport;
  String password;
  int age;
  int id;

  Body({
    required this.email,
    required this.nom,
    required this.prenom,
    required this.cin,
    required this.image,
    required this.id,
    required this.genre,
    required this.tel,
    required this.passeport,
    required this.password,
    required this.age,
  });
  @override
  _BodyState createState() => _BodyState();
}
class _BodyState extends State<Body> {
  /*String email = '';
  String password = '';
  String passeport = '';*/
  String SelectedImagePath = '';

  TextEditingController textEditingController = TextEditingController();
  TextEditingController textFNController = TextEditingController();
  TextEditingController textAgeController = TextEditingController();
  TextEditingController textPasseportController = TextEditingController();
  TextEditingController textCinController = TextEditingController();
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textTelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int _selectedIndex = 1; // Initially, the "Home" tab is selected
    Future<void> updateUserPassport(String newPassportNumber) async {
      final apiUrl = 'http://192.168.1.13:7229/api/Utilisateurs/${widget.id}';

      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'Id': widget.id,
          "Nom": widget.nom,
          "Prenom": widget.prenom,
          "Age": widget.age, // Remplacez par la nouvelle valeur
          "Genre": widget.genre,
          "Image": widget.image,
          "Cin": widget.cin,
          'Num_passeport': newPassportNumber, // Update passport number
          "Email": widget.email,
          "Password": widget.password, // Si le mot de passe change
          "Num_tel": widget.tel
          // Include other fields here as needed
        }),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {

        // Update was successful
        // You may want to display a success message
      } else {
        // Handle the case where the update failed
        // You may want to display an error message
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
    bool endIcon = true ;
    String? selectedValue = widget.genre;
    void _showAlert(BuildContext context, String precGender) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('validate the modification',style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            actions: [
              RoundedButton(
                text:'Validate',
                press: () {
                  Navigator.of(context).pop(); // Ferme l'alerte
                },
              ),
              RoundedButton(
                text:'Cancel',
                press: () async {

                  final apiUrl = 'http://192.168.43.204:7229/api/Utilisateurs/${widget.id}';
                  final response = await http.put(
                    Uri.parse(apiUrl),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode({
                      'Id': widget.id,
                      "Nom": widget.nom,
                      "Prenom": widget.prenom,
                      "Age": widget.age, // Remplacez par la nouvelle valeur
                      "Genre": precGender,
                      "Image": widget.image,
                      "Cin": widget.cin,
                      'Num_passeport': widget.passeport, // Update passport number
                      "Email": widget.email,
                      "Password": widget.password, // Si le mot de passe change
                      "Num_tel": widget.tel
                    }),

                  );
                  Navigator.of(context).pop();
                },

              ),
            ],
          );
        },
      );
    }
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Edit profil',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40.0),
            ),
            SizedBox(height: 20.0,),
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SelectedImagePath == ''
                        ? Image.file(File(widget.image))
                        :Image.file(File(SelectedImagePath)),
                  ),
                ),
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SelectedImagePath != ''
                        ? TextButton(
                          onPressed: () async {
                            final apiUrl = 'http://192.168.1.13:7229/api/Utilisateurs/${widget.id}';

                            final response = await http.put(
                              Uri.parse(apiUrl),
                              headers: {
                                'Content-Type': 'application/json',
                              },
                              body: jsonEncode({
                                'Id': widget.id,
                                "Nom": widget.nom,
                                "Prenom": widget.prenom,
                                "Age": widget.age, // Remplacez par la nouvelle valeur
                                "Genre": widget.genre,
                                "Image": SelectedImagePath,
                                "Cin": widget.cin,
                                'Num_passeport': widget.passeport, // Update passport number
                                "Email": widget.email,
                                "Password": widget.password, // Si le mot de passe change
                                "Num_tel": widget.tel
                                // Include other fields here as needed
                              }),
                            );
                            print(response.statusCode);
                          },
                          child: Text('Update Photo'),
                          )
                        :Text(''),
                  ),
                ),

                Positioned(
                  bottom: 5,  // Ajustez la position verticale de l'icône
                  right: 5,   // Ajustez la position horizontale de l'icône
                  child: GestureDetector(
                    onTap: () {
                      selectImage();
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.indigo,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            Text("${widget.nom} ${widget.prenom}",
                style: Theme.of(context).textTheme.headlineSmall),
            Text("${widget.email}",
                style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 20),

            SizedBox(height: 10),
            UserScreenMenu(
              title: widget.nom,
              icon: LineAwesomeIcons.user,
              onPress: () async {
                String newLN = textEditingController.text;

                final apiUrl = 'http://192.168.43.204:7229/api/Utilisateurs/${widget.id}';
                final response = await http.put(
                  Uri.parse(apiUrl),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'Id': widget.id,
                    "Nom": newLN,
                    "Prenom": widget.prenom,
                    "Age": widget.age, // Remplacez par la nouvelle valeur
                    "Genre": widget.genre,
                    "Image": widget.image,
                    "Cin": widget.cin,
                    'Num_passeport': widget.passeport, // Update passport number
                    "Email": widget.email,
                    "Password": widget.password, // Si le mot de passe change
                    "Num_tel": widget.tel
                  }),
                );
                print(newLN);
                if (response.statusCode == 200) {
                  final jsonResponse = json.decode(response.body);
                  print(jsonResponse);
                } else {
                  print('Échec de la requête : ${response.reasonPhrase}');
                }
              },
              controller: textEditingController,
            ),
            UserScreenMenu(
              title: widget.prenom,
              icon: LineAwesomeIcons.user,
              onPress: () async {
                String newFN = textFNController.text;

                final apiUrl = 'http://192.168.43.204:7229/api/Utilisateurs/${widget.id}';
                final response = await http.put(
                  Uri.parse(apiUrl),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'Id': widget.id,
                    "Nom": widget.nom,
                    "Prenom": newFN,
                    "Age": widget.age, // Remplacez par la nouvelle valeur
                    "Genre": widget.genre,
                    "Image": widget.image,
                    "Cin": widget.cin,
                    'Num_passeport': widget.passeport, // Update passport number
                    "Email": widget.email,
                    "Password": widget.password, // Si le mot de passe change
                    "Num_tel": widget.tel
                  }),
                );
                print(newFN);
                if (response.statusCode == 200) {
                  final jsonResponse = json.decode(response.body);
                  print(jsonResponse);
                } else {
                  print('Échec de la requête : ${response.reasonPhrase}');
                }
              },
              controller: textFNController,
            ),
            UserScreenMenu(
              title: widget.email,
              icon: LineAwesomeIcons.mail_bulk,
              onPress: () async {
                String newEmail = textEmailController.text;

                final apiUrl = 'http://192.168.43.204:7229/api/Utilisateurs/${widget.id}';
                final response = await http.put(
                  Uri.parse(apiUrl),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'Id': widget.id,
                    "Nom": widget.nom,
                    "Prenom": widget.prenom,
                    "Age": widget.age, // Remplacez par la nouvelle valeur
                    "Genre": widget.genre,
                    "Image": widget.image,
                    "Cin": widget.cin,
                    'Num_passeport': widget.passeport, // Update passport number
                    "Email": newEmail,
                    "Password": widget.password, // Si le mot de passe change
                    "Num_tel": widget.tel
                  }),
                );
                if (response.statusCode == 200) {
                  final jsonResponse = json.decode(response.body);
                  print(jsonResponse);
                } else {
                  print('Échec de la requête : ${response.reasonPhrase}');
                }
              },
              controller: textEmailController,
            ),
            UserScreenMenu(
              title: widget.passeport,
              icon: LineAwesomeIcons.passport,
              onPress: () async {
                String newPass = textPasseportController.text;

                final apiUrl = 'http://192.168.43.204:7229/api/Utilisateurs/${widget.id}';
                final response = await http.put(
                  Uri.parse(apiUrl),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'Id': widget.id,
                    "Nom": widget.nom,
                    "Prenom": widget.prenom,
                    "Age": widget.age, // Remplacez par la nouvelle valeur
                    "Genre": widget.genre,
                    "Image": widget.image,
                    "Cin": widget.cin,
                    'Num_passeport': newPass, // Update passport number
                    "Email": widget.email,
                    "Password": widget.password, // Si le mot de passe change
                    "Num_tel": widget.tel
                  }),
                );
                if (response.statusCode == 200) {
                  final jsonResponse = json.decode(response.body);
                  print(jsonResponse);
                } else {
                  print('Échec de la requête : ${response.reasonPhrase}');
                }
              },
              controller: textPasseportController,
            ),
            UserScreenMenu(
              title: widget.cin,
              icon: LineAwesomeIcons.user,
              onPress: () async {
                String newCin = textCinController.text;

                final apiUrl = 'http://192.168.43.204:7229/api/Utilisateurs/${widget.id}';
                final response = await http.put(
                  Uri.parse(apiUrl),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'Id': widget.id,
                    "Nom": widget.nom,
                    "Prenom": widget.prenom,
                    "Age": widget.age, // Remplacez par la nouvelle valeur
                    "Genre": widget.genre,
                    "Image": widget.image,
                    "Cin": newCin,
                    'Num_passeport': widget.passeport, // Update passport number
                    "Email": widget.email,
                    "Password": widget.password, // Si le mot de passe change
                    "Num_tel": widget.tel
                  }),
                );
                if (response.statusCode == 200) {
                  final jsonResponse = json.decode(response.body);
                  print(jsonResponse);
                } else {
                  print('Échec de la requête : ${response.reasonPhrase}');
                }
              },
              controller: textCinController,
            ),
            UserScreenMenu(
              title: widget.tel,
              icon: LineAwesomeIcons.phone,
              onPress: () async {
                String newTel = textTelController.text;

                final apiUrl = 'http://192.168.43.204:7229/api/Utilisateurs/${widget.id}';
                final response = await http.put(
                  Uri.parse(apiUrl),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'Id': widget.id,
                    "Nom": widget.nom,
                    "Prenom": widget.prenom,
                    "Age": widget.age, // Remplacez par la nouvelle valeur
                    "Genre": widget.genre,
                    "Image": widget.image,
                    "Cin": widget.cin,
                    'Num_passeport': widget.passeport, // Update passport number
                    "Email": widget.email,
                    "Password": widget.password, // Si le mot de passe change
                    "Num_tel": newTel
                  }),
                );
                if (response.statusCode == 200) {
                  final jsonResponse = json.decode(response.body);
                  print(jsonResponse);
                } else {
                  print('Échec de la requête : ${response.reasonPhrase}');
                }
              },
              controller: textTelController,
            ),
        ListTile(
          onTap: () async {
            final apiUrl = 'http://192.168.43.204:7229/api/Utilisateurs/${widget.id}';
            print(selectedValue);
            final response = await http.put(
              Uri.parse(apiUrl),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'Id': widget.id,
                "Nom": widget.nom,
                "Prenom": widget.prenom,
                "Age": widget.age, // Remplacez par la nouvelle valeur
                "Genre": selectedValue,
                "Image": widget.image,
                "Cin": widget.cin,
                'Num_passeport': widget.passeport, // Update passport number
                "Email": widget.email,
                "Password": widget.password, // Si le mot de passe change
                "Num_tel": widget.tel
              }),
            );
            if (response.statusCode == 200) {
              final jsonResponse = json.decode(response.body);
              print(jsonResponse);
            } else {
              print('Échec de la requête : ${response.reasonPhrase}');
            }
          },
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.tealAccent.withOpacity(0.1),
            ),
            child: Icon(LineAwesomeIcons.transgender, color: Colors.indigo),
          ),
          title: InkWell(
            onTap: (){},
            child: DropdownButton<String>(
              value: selectedValue,
              onChanged: (value) async {
                final apiUrl = 'http://192.168.43.204:7229/api/Utilisateurs/${widget.id}';
                print(selectedValue);
                final response = await http.put(
                  Uri.parse(apiUrl),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'Id': widget.id,
                    "Nom": widget.nom,
                    "Prenom": widget.prenom,
                    "Age": widget.age, // Remplacez par la nouvelle valeur
                    "Genre": value,
                    "Image": widget.image,
                    "Cin": widget.cin,
                    'Num_passeport': widget.passeport, // Update passport number
                    "Email": widget.email,
                    "Password": widget.password, // Si le mot de passe change
                    "Num_tel": widget.tel
                  }),
                );
                _showAlert(context,selectedValue);
              },
              items: ['Male','Female'].map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
            ),
          ),
          trailing: endIcon
              ? Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.withOpacity(0.1),
            ),
            child: Icon(LineAwesomeIcons.check, size: 18.0, color: Colors.indigo),
          )
              : null,
        ),
            UserMenu(
              title: widget.age.toString(),
              icon: LineAwesomeIcons.birthday_cake,
              onPress: () async {
                String newAge = textAgeController.text;

                final apiUrl = 'http://192.168.43.204:7229/api/Utilisateurs/${widget.id}';
                final response = await http.put(
                  Uri.parse(apiUrl),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'Id': widget.id,
                    "Nom": widget.nom,
                    "Prenom": widget.prenom,
                    "Age": newAge, // Remplacez par la nouvelle valeur
                    "Genre": widget.genre,
                    "Image": widget.image,
                    "Cin": widget.cin,
                    'Num_passeport': widget.passeport, // Update passport number
                    "Email": widget.email,
                    "Password": widget.password, // Si le mot de passe change
                    "Num_tel": widget.tel
                  }),
                );
                if (response.statusCode == 200) {
                  final jsonResponse = json.decode(response.body);
                  print(jsonResponse);
                } else {
                  print('Échec de la requête : ${response.reasonPhrase}');
                }
              },
              controller: textAgeController,
            ),
            Container(
              height: size.height*0.12,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      width: size.width, // Set the width of the Container to the screen's width
                      height: 56.0,


                         child : GNav(
                            backgroundColor: Colors.black,
                            gap: 8,
                            tabBackgroundColor: Colors.grey.shade800,
                            color: Colors.white,
                            activeColor: Colors.white,
                            padding: EdgeInsets.all(16),
                            tabs: const [
                              GButton(
                                icon: Icons.account_circle_rounded,
                              ),
                              GButton(
                                icon: Icons.settings,
                              ),
                              GButton(
                                icon: Icons.home,
                              ),
                              GButton(
                                icon: Icons.notifications,
                              ),
                              GButton(
                                icon: Icons.logout,
                              ),
                            ],
                            selectedIndex: _selectedIndex,
                            onTabChange: (index) {
                              _selectedIndex = index;
                              if (index == 0) {
                                Get.to(ProfileScreen());
                              } else if (index == 2) {
                                Get.to(() => Acceuil(), arguments: {
                                  'age': widget.age,
                                  'nom': widget.nom,
                                  'prenom': widget.prenom,
                                  'id': widget.id,
                                  'genre': widget.genre,
                                  'email': widget.email,
                                  'cin': widget.cin,
                                  'passeport': widget.passeport,
                                  'password': widget.password,
                                  'image': widget.image,
                                  'tel': widget.tel,
                                  // Ajoutez d'autres variables ici si nécessaire
                                });
                              } else if (index == 4) {
                                Get.to(LoginScreen());
                              }else if (index == 1) { // C'est le bouton "Settings"
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Background2(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'Settings',
                                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40.0),
                                              ),
                                              UserScreen(
                                                title: "Edit Password ",
                                                icon: LineAwesomeIcons.key,
                                                onPress: () => Get.to(ResetPassword()),
                                              ),
                                              UserScreen(
                                                title: "contact agency",
                                                icon: LineAwesomeIcons.mail_bulk,
                                                onPress: () {
                                                },
                                              ),
                                              UserScreen(
                                                title: "my bill",
                                                icon: LineAwesomeIcons.file_invoice,
                                                onPress: () {
                                                },
                                              ),
                                              UserScreen(
                                                title: "travel validation",
                                                icon: LineAwesomeIcons.plane,
                                                onPress: () {
                                                },
                                              ),
                                              UserScreen(
                                                title: "hotel validation",
                                                icon: LineAwesomeIcons.hotel,
                                                onPress: () {
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                    ),
                  ],
                ),
              ),
            // ),
          ],
        ),
      ),
    );
  }
}
