import 'package:flutter/material.dart';
import 'package:agence_voyage_app/components/text_field_container.dart';
import 'package:agence_voyage_app/constants.dart';

class RoundedAgeField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedAgeField({
    super.key,
    required this.hintText,
    this.icon = Icons.calendar_month,
    required this.onChanged,
  });

  @override
  _RoundedAgeFieldState createState() => _RoundedAgeFieldState();
}

class _RoundedAgeFieldState extends State<RoundedAgeField> {
  final TextEditingController _controller = TextEditingController();
  String _errorText = ""; // Déclarez _errorText comme une chaîne non nullable.

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  _errorText = ""; // Affectez une chaîne vide à _errorText en cas de valeur vide.
                });
              } else {
                final age = int.tryParse(value);
                if (age == null || age < 18 || age > 100) {
                  setState(() {
                    _errorText = "L'âge n'est pas valide. Il faut un âge entre 18 et 100 !";
                  });
                } else {
                  setState(() {
                    _errorText = ""; // Affectez une chaîne vide lorsque l'âge est valide.
                  });
                }
                widget.onChanged(value);
              }
            },
            decoration: InputDecoration(
              icon: Icon(
                widget.icon,
                color: kPrimaryColor,
              ),
              hintText: widget.hintText,
              border: InputBorder.none,
            ),
          ),
          if (_errorText.isNotEmpty) // Vérifiez si _errorText n'est pas vide avant d'afficher l'erreur.
            Text(
              _errorText,
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}