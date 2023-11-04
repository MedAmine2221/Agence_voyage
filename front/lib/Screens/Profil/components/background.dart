/*import 'package:agence_voyage_app/Screens/Login/login_screen.dart';
import 'package:agence_voyage_app/Screens/Profil/profil.dart';
import 'package:agence_voyage_app/Screens/acceuil/acceuil.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:get/get.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int _selectedIndex = 1; // Initially, the "Home" tab is selected

    return Stack(
      fit: StackFit.expand, // L'image s'étend sur toute la page
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(0), // Ajustez le rayon du coin arrondi selon vos préférences
          child: Image.asset(
            "assets/images/bck.png",
            height: size.height * 0.4,
            fit: BoxFit.cover, // Assurez-vous que l'image s'adapte correctement au coin arrondi
          ),
        ),
        child,
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width, // Set the width of the Container to the screen's width
            child: GNav(
              backgroundColor: Colors.black,
              gap: 8,
              tabBackgroundColor: Colors.grey.shade800,
              color: Colors.white,
              activeColor: Colors.white,
              padding: EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.account_circle_rounded,
                  text: 'Profil',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.notifications,
                  text: 'Notification',
                ),
                GButton(
                  icon: Icons.logout,
                  text: 'logout',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                _selectedIndex = index;
                if (index == 0) {
                  Get.to(ProfileScreen());
                }
                else if (index == 2) {
                  Get.to(Acceuil());
                }
                else if (index == 4) {
                  Get.to(LoginScreen());
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}*/
import 'package:agence_voyage_app/Screens/Login/login_screen.dart';
import 'package:agence_voyage_app/Screens/Profil/profil.dart';
import 'package:agence_voyage_app/Screens/acceuil/acceuil.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:get/get.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int _selectedIndex = 1; // Initially, the "Home" tab is selected

    return Stack(
      fit: StackFit.expand, // L'image s'étend sur toute la page

      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(0), // Ajustez le rayon du coin arrondi selon vos préférences
          child: Image.asset(
            "assets/images/bck.png",
            height: size.height * 0.4,
            fit: BoxFit.cover, // Assurez-vous que l'image s'adapte correctement au coin arrondi
          ),
        ),
        child,

      ],
    );
  }
}
