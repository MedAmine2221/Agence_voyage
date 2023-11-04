/*import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'dart:io'; // Importez dart:io pour File
class UserScreenMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  UserScreenMenu({
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    var iconColor = Colors.indigo;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.tealAccent.withOpacity(0.1)
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: Theme.of(context).textTheme.headline6?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1)
        ),
        child: Icon(LineAwesomeIcons.angle_right, size: 18.0, color: iconColor),
      )
          : null,
    );
  }

}*//*
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UserScreenMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  final TextEditingController controller; // Ajout du contrôleur pour le champ de texte

  UserScreenMenu({
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
    required this.controller, // Ajout du contrôleur pour le champ de texte
  });

  @override
  Widget build(BuildContext context) {
    var iconColor = Colors.indigo;

    return ListTile(
      onTap: onPress,
      title: TextFormField(
        controller: controller, // Utilisation du contrôleur pour le champ de texte
        style: TextStyle(color: textColor), // Style du texte
        decoration: InputDecoration(
          labelText: title, // Texte du champ de texte
          prefixIcon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.tealAccent.withOpacity(0.1),
            ),
            child: Icon(icon, color: iconColor),
          ),
          suffixIcon: endIcon
              ? Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.withOpacity(0.1),
            ),
            child: Icon(LineAwesomeIcons.check, size: 18.0, color: iconColor),
          )
              : null,
        ),
      ),
    );
  }
}
*/
import 'package:agence_voyage_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
class UserMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  final TextEditingController controller; // Contrôleur de texte

  UserMenu({
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var iconColor = Colors.indigo;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.tealAccent.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: InkWell( // Utilisation de InkWell pour détecter les clics sur le texte
        onTap: onPress, // Vous pouvez supprimer cela si vous voulez juste la modification du texte
        child:
        TextField(
          keyboardType: TextInputType.number,
          controller: controller, // Utilisation du contrôleur de texte
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: title,
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 20), // Définir la taille du texte du hintText

          ),
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
        child: Icon(LineAwesomeIcons.check, size: 18.0, color: iconColor),
      )
          : null,
    );
  }
}
