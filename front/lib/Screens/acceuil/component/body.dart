import 'dart:io';

import 'package:agence_voyage_app/Screens/Login/login_screen.dart';
import 'package:agence_voyage_app/Screens/Profil/profil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:agence_voyage_app/Screens/acceuil/component/background.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class Body extends StatefulWidget{
  String email;
  String  nom;
  String  prenom;
  String  cin;
  String  image;
  String  genre;
  String  tel;
  String  passeport;
  String  password;
  int  age;
  int  id;
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
  _BodyState createState()=>_BodyState();
}
class _BodyState extends State<Body>{
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context){
    Size size =MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Align(
              child: Container(
                width: double.infinity,
                height: size.height,

                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[

                      Container(
                        width: MediaQuery.of(context).size.width, // Utilisation de la largeur de l'écran
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
                                  Get.to(() => ProfileScreen(),arguments: {
                                    'age': widget.age,
                                    'nom': widget.nom,
                                    'prenom': widget.prenom,
                                    'id':widget.id,
                                    'genre': widget.genre,
                                    'email': widget.email,
                                    'cin': widget.cin,
                                    'passeport':widget.passeport,
                                    'image': widget.image,
                                    'tel': widget.tel,
                                    'password': widget.password,
                                    // Ajoutez d'autres variables ici si nécessaire
                                  });
                                } else if (index == 3) {
                                  Get.to(LoginScreen());
                                }
                              },
                            ),

                      ),
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
