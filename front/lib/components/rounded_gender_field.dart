import 'package:flutter/material.dart';
import 'package:agence_voyage_app/components/text_field_container.dart';
import 'package:agence_voyage_app/constants.dart';

class RoundedGenderField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final String selectedGender;
  final ValueChanged<String?> onChanged;

  static const List<String> genderOptions = ["Male", "Female"];

  const RoundedGenderField({
    Key? key,
    required this.hintText,
    this.icon = Icons.transgender,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: InputDecorator(
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
        child: DropdownButton<String>(
          value: selectedGender,
          onChanged: onChanged,
          items: genderOptions.map((String gender) {
            return DropdownMenuItem<String>(
              value: gender,
              child: Text(gender),
            );
          }).toList(),
        ),
      ),
    );
  }
}