import 'package:flutter/material.dart';
import 'package:agence_voyage_app/components/text_field_container.dart';
import 'package:agence_voyage_app/constants.dart';
class RoundeTelField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  const RoundeTelField({
    Key? key,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: (value) {
          // Vérification de la longueur du numéro de téléphone
          if (value.length == 8) {
            // Vérification que le numéro de téléphone commence par 5, 9 ou 2
            if (['5', '9', '2','4','7'].contains(value[0])) {
              // Vérification que le numéro de téléphone ne contient que des chiffres
              if (value.runes.every((charCode) => charCode >= 48 && charCode <= 57)) {
                onChanged(value);
              }
            }
          }
        },
        decoration: InputDecoration(
          icon: Icon(
            Icons.phone,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}